%function beststep =  parameter_test(x0, f_eval, g_eval, Hess_opt, boot_method, descent_method,   opts)

%% Load Logistic parameters
opts.grad_type = 'SVRG';         % SVRG  SGD
opts.max_iterations = 10^10;
opts.regularizor ='L2';  % huber or L2
opts.hubermu = 1.0e-4;
opts.regulatrizor_parameter =  '1/num_data';% 'normalized';%'1/num_data';    % '1/num_data' or 1   10^(-6);
opts.LIBSVMdata ='w8a';  %liver-disorders  a9a  w8a  covtype.libsvm.binary   gisette_scale  real-sim   SUSY    rcv1_train.binary  news20.binary  HIGGS  SUSY  epsilon_normalized        
% Stochastic subsampling of gradients and Hessian-vector products 
%% Load problem
datapath = './tests/logistic/LIBSVM_data'; 
[opts,f_eval,g_eval,Hess_opt ] =  load_logistic('logistic',datapath,0,opts);
%%
n = length(opts.x0);    
M_big = ceil(sqrt(n));                 % Memory size
M_med = ceil(n^(1/3)); 
M_small = ceil(n^(1/4)); 
M_very_small = ceil(log(n)); 
M = M_big;
S_big = ceil(sqrt(opts.numdata));                 % subsample size
S_med = ceil(opts.numdata^(1/3)); 
S_small = ceil(opts.numdata^(1/4)); 
S_very_small = ceil(opts.numdata^(1/5)); 
opts.S = ceil(sqrt(opts.numdata));        % Sub sampling size.
opts.plotting= 1;                           % 1 - record information for plotting, 0 - otherwise
opts.prnt= 1;                               % 1 - print outer iterations, 0 - otherwise
opts.totalpasses = 30;
opts.Timeout =30000;                          % permitted time in seconds
% opts.metric_reset_method ='descent-angle';  % type of metric reseting criteria: always %descent-angle % never
opts.use_optimal_step_size =1;
OUTPUTS ={};
problem =opts.LIBSVMdata; %load_problem_parameters;
opts.Timeout =30000; 
%% Choose the method to test
method = 'prev';
boot_method = @bootLBBFGS_skip;
descent_method = @descentLBBFGS_skip; 
opts.metric_type = 'ML'; 
opts.update_size =M;
%% test subsampling size
Ss = [ 4 S_very_small S_small S_med  S_big  4*S_big 4^2*S_big 4^3*S_big];
test_type= 'subsampling';
OUTPUTS ={};
for gg = 1: length(Ss)
    opts.H0 = 1;                        % eye, average_project_grad
    opts.S = Ss(gg);
    opts.update_size =M;
    opts.memory = 5*opts.update_size;
    outLBBFGSpdd = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, boot_method ,descent_method,   opts);
    OUTPUTS = [ OUTPUTS {outLBBFGSpdd}];
end
%% Plot results
    Prob.title =[ test_type '-test-' method '-' opts.LIBSVMdata '\_' opts.regularizor '_(m,n)_=_(' num2str(OUTPUTS{1}.opts.numdata) ','   num2str(OUTPUTS{1}.opts.n) ')_S=' num2str(opts.S) '_' opts.regulatrizor_parameter];
    plotdata = extract_plot_data(OUTPUTS,Prob,'datapasses');
    %opts.singleplot = 0; opts= rmfield(opts,'singleplot');
    opts.extrafieldtrim = opts.totalpasses-5; opts.logScale =2;
    prettyPlot_plotdata(plotdata,opts)
%% test Hessian subsampling size
Ts = [ 4 S_very_small S_small S_med S_big 2*S_big ];
test_type= 'Hess_sampling';
display(test_type);
OUTPUTS ={};
opts.S = S_med;
for gg = 1: length(Ts)
    opts.H0 = 1;                        % eye, average_project_grad
    opts.T = Ts(gg);
    opts.update_size =M;
    opts.memory = 5*opts.update_size;
    outLBBFGSpdd = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, boot_method ,descent_method,   opts);
    OUTPUTS = [ OUTPUTS {outLBBFGSpdd}];
end
opts= rmfield(opts,'T');
%% Plot results
Prob.title =[ test_type '-test-' method '-' opts.LIBSVMdata '\_' opts.regularizor '_(m,n)_=_(' num2str(OUTPUTS{1}.opts.numdata) ','   num2str(OUTPUTS{1}.opts.n) ')_S=' num2str(opts.S) '_' opts.regulatrizor_parameter];
plotdata = extract_plot_data(OUTPUTS,Prob,'datapasses');
%opts.singleplot = 0; opts= rmfield(opts,'singleplot');
opts.extrafieldtrim = opts.totalpasses-10; opts.logScale =2;
prettyPlot_plotdata(plotdata,opts)
%% test L - delay size and sketch size/update_size
Ls = [ 1 2 M_small M_med M_big  2*M_big ];
test_type= 'update_size';
opts.S = S_med; 
OUTPUTS ={};
for gg = 1: length(Ls)
    opts.H0 = 1;                        % eye, average_project_grad
    opts.update_size =Ls(gg);
    opts.memory = 5*opts.update_size;
    outLBBFGSpdd = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, boot_method ,descent_method,   opts);
    OUTPUTS = [ OUTPUTS {outLBBFGSpdd}];
end
%% Plot results
Prob.title =[ test_type '-test-' method '-' opts.LIBSVMdata '\_' opts.regularizor '_(m,n)_=_(' num2str(OUTPUTS{1}.opts.numdata) ','   num2str(OUTPUTS{1}.opts.n) ')_S=' num2str(opts.S) '_' opts.regulatrizor_parameter];
plotdata = extract_plot_data(OUTPUTS,Prob,'datapasses');
%opts.singleplot = 0; opts= rmfield(opts,'singleplot');
opts.extrafieldtrim = opts.totalpasses-5; opts.logScale =2;
prettyPlot_plotdata(plotdata,opts)
%% test memory parameter
OUTPUTS ={};
test_type= 'memory';
opts.S = S_med;
Memory = [0 , 1 , 2, 4 , 8, 16];
for gg = 1: length(Memory)
    opts.H0 = 1;                        % eye, average_project_grad
    opts.update_size = M_big;
    opts.memory =Memory(gg)*opts.update_size;
    outLBBFGSpdd = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, boot_method ,descent_method,   opts);
    OUTPUTS = [ OUTPUTS {outLBBFGSpdd}];
end
%% Plot results
Prob.title =[ test_type '-test-' method '-' opts.LIBSVMdata '\_' opts.regularizor '_(m,n)_=_(' num2str(OUTPUTS{1}.opts.numdata) ','   num2str(OUTPUTS{1}.opts.n) ')_S=' num2str(opts.S) '_' opts.regulatrizor_parameter];
plotdata = extract_plot_data(OUTPUTS,Prob,'datapasses');
%opts.singleplot = 0; opts= rmfield(opts,'singleplot');
opts.extrafieldtrim = opts.totalpasses-5; opts.logScale =2;
prettyPlot_plotdata(plotdata,opts)