% demo: vizualizing SGD on logistic regression
clear all;
setuppaths
%% Load Logistic parameters
opts.grad_type = 'SGD';         % SVRG  or SGD
opts.max_iterations =20;
opts.regularizor ='L2';  % huber or L2
opts.hubermu = 1.0e-4;
opts.regulatrizor_parameter =  '1/num_data'; % 'normalized';%'1/num_data';    % '1/num_data' or 1   10^(-6);
opts.LIBSVMdata ='fourclass_scale';
%% Load problem
datapath = './tests/logistic/LIBSVM_data';   % THIS RELATIVE PATH ONLY WORKS IF YOU ARE IN THE ROOT FOLDER !
[opts,f_eval,g_eval,Hess_opt ] =  load_logistic('logistic',datapath,0,opts);
opts.x0 = [0,0]';
n = length(opts.x0);
M = ceil(sqrt(n));                          % Memory size; number of block curvature pairs stored
opts.S = 1;%ceil(sqrt(opts.numdata));          % Sub sampling size.
opts.plotting= 1;                           % 1 - record information for plotting, 0 - otherwise
opts.prnt= 1;                               % 1 - print outer iterations, 0 - otherwise
opts.totalpasses = 10;
opts.metric_reset_method ='descent-angle';  % type of metric reseting criteria: always %descent-angle % never
OUTPUTS ={};
opts.use_optimal_step_size =0;              % already have save optimal stepsize for covtype
problem =opts.LIBSVMdata; 
% load_problem_parameters;
opts.Timeout =10; 

%% Stoch Gradient
opts.max_iterations =50*1000;
opts.totalpasses = 40;
opts.S = 1;
opts.step_parameter =0.01;
outgrad = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootgrad, @descentSGD,   opts);
OUTPUTS =[OUTPUTS {outgrad}];

%% Plotting

f_tot = @(x1,x2) f_eval([x1 x2 ]',1:opts.numdata);

x = 0:0.2:3;
y= -3:0.2:1;
Z = zeros(length(x),length(y));
for i=1:length(x)
    for j =1:length(y)
        Z(i,j) =        f_tot(x(i),y(j)); 
    end
end
h = figure();
[C,h] = contour(y,x,Z,20)
% clabel(C,h)
hold on;
scatter(outgrad.xs(2,:),outgrad.xs(1,:),[],[0 0 1])
legend('f',['\alpha = ' num2str(opts.step_parameter)])
name = ['SGD-' num2str(opts.step_parameter) ];
name(ismember(name,'_ ,.:;!/\')) = '-';
set(gcf, 'PaperPosition', [0 0 5 5]); %Position plot at left hand corner with width 5 and height 5.
set(gcf, 'PaperSize', [5 5]);
eval(['print -dpdf ' name '.pdf' ]);

%% Gradient Descent
opts.max_iterations =20;
opts.totalpasses = opts.max_iterations;
opts.S = opts.numdata;
opts.step_parameter =5;
outgrad = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootgrad, @descentSGD,   opts);
OUTPUTS =[OUTPUTS {outgrad}];
%% Limited memory stochastic BFGS stochastic  (gauss)
opts.grad_type = 'SVRG'; 
opts.totalpasses = 800;
opts.step_parameter = 0.0003;
opts.max_iterations =150;
opts.S = 1;
opts.metric_type = 'ML';
opts.H0 = 1;                           % eye, average_project_grad
opts.update_sample_matrix = 'gauss';   % 'gauss' , 'prev' , 'metric_action'
opts.memory = 3*M;  % 6*M
opts.update_size =M;
outgrad = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLvariableM_stoch , @descentLvariableM_stoch,   opts);
OUTPUTS = [  {outLBBFGSg} OUTPUTS];
%%
Prob.title =['fval--' opts.LIBSVMdata '\_' opts.regularizor '_(m,n)_=_(' num2str(OUTPUTS{1}.opts.numdata) ','   num2str(OUTPUTS{1}.opts.n) ')_S=' num2str(opts.S) '_' opts.regulatrizor_parameter];
plotdata = extract_plot_data(OUTPUTS,Prob,'datapasses');
opts.singleplot = 1; opts.logScale =2; %opts.timeonly =0; 
prettyPlot_plotdata(plotdata,opts)