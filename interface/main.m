% demo: is a script file solves problems of the form
%     min  F(x) + \lambda/2 R(x)
% where F(x) is the loss function, \lambda the regularizor penalty
% parameter and R(x) the regularization function.
% It also sets printing and plotting automatically on and prints all outputs at end.
%
%------------------------------------------------------------------------------
% opts.LIBSVMdata =              a string that specifiecs a LIBSVM binary data file,
%                                exe, 'covtype.libsvm.binary'
% opts.regularizor =              'L2' to a L2 euclidean regularizor o
%                                 'huber' for a pseudo-huber regularizor
% opts.regulatrizor_parameter =   the regularior penalty parameter
%                               (\lambda). Must be a positive number.
% opts.hubermu =                 A number in [0 1] specifies accuracy of
%                                pseudo-huber approxamition to the L1 norm where hubermu-> 0 as
%                                pseudo-huber tends to a L1 regularizor
clear all;
setuppaths
%% Load Logistic parameters
opts.grad_type = 'SVRG';         % SVRG  SGD
opts.max_iterations = 10^10;
opts.regularizor ='L2';  % huber or L2
opts.hubermu = 1.0e-4;
opts.regulatrizor_parameter =  '1/num_data';% 'normalized';%'1/num_data';    % '1/num_data' or 1   10^(-6);
opts.LIBSVMdata ='madelon';  %mushrooms, liver-disorders  a9a  w8a  covtype.libsvm.binary   gisette_scale  real-sim   SUSY    rcv1_train.binary  news20.binary  HIGGS  SUSY  epsilon_normalized        
% Stochastic subsampling of gradients and Hessian-vector products 
%% Load problem
datapath = './tests/logistic/LIBSVM_data'; 
[opts,f_eval,g_eval,Hess_opt ] =  load_logistic('logistic',datapath,0,opts);
%%
n = length(opts.x0);    
M_big = ceil(sqrt(n));                 % Memory size
M_med = ceil(n^(1/3)); 
M_small = ceil(n^(1/4)); 
M_very_small = ceil(n^(1/5)); 
M = M_big;
S_big = ceil(sqrt(opts.numdata));                 % subsample size
S_med = ceil(opts.numdata^(1/3)); 
S_small = ceil(opts.numdata^(1/4)); 
S_very_small = ceil(opts.numdata^(1/5)); 
opts.S = ceil(sqrt(opts.numdata));        % Sub sampling size.
opts.plotting= 1;                           % 1 - record information for plotting, 0 - otherwise
opts.prnt= 1;                               % 1 - print outer iterations, 0 - otherwise
opts.totalpasses = 25;
opts.Timeout =30000;                          % permitted time in seconds
% opts.metric_reset_method ='descent-angle';  % type of metric reseting criteria: always %descent-angle % never
opts.use_optimal_step_size =1;
OUTPUTS ={};
problem =opts.LIBSVMdata; %load_problem_parameters;
opts.Timeout =30000; 
%% Limited BBFGS stochastic  (LBBFGS)
%opts.step_parameter = LBBFGS_gauss_step_parameter; 
opts.metric_type = 'ML';              % AIR, BBFGS  % type of metric matrix 'inverse' %'direct'
opts.H0 = 1;                        % eye, average_project_grad
opts.update_sample_matrix = 'gauss';   % 'gauss' , 'prev' , 'metric_action'
opts.memory = 5*M;  % 6*M
opts.update_size =M;
outLBBFGSg = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLvariableM_stoch , @descentLvariableM_stoch,   opts);
OUTPUTS = [  {outLBBFGSg} OUTPUTS];
%% Limited BBFGS stochastic  previsious directions delayed (LBBFGSpdd)
%opts.step_parameter =  LBBFGS_prev_step_parameter ;
opts.H0 = 1;                        % eye, average_project_grad
opts.memory =5*M;
opts.update_size =M;
outLBBFGSpdd = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLBBFGS_skip , @descentLBBFGS_skip,   opts);
OUTPUTS = [ OUTPUTS {outLBBFGSpdd}];
%% Limited  self conditioning Factored BBFGS stochastic  (LFB-BFGS) 
%opts.step_parameter =  LFBBFGS_step_parameter;% ;
opts.metric_type = 'fact';              % AIR, BBFGS  % type of metric matrix 'inverse' %'direct'
opts.H0 = 1;                       % 10^(-9), eye, average_project_grad
opts.memory = 3*M;
opts.update_size =M;
outLF = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLFB_BFGS_stoch , @descentLFB_BFGS_stoch,   opts);
OUTPUTS = [ OUTPUTS {outLF}];
%% SQN - Stochastic quasi-Newton by Nocedal
%opts.step_parameter =  SQN_step_parameter ;
opts.L =10;
memoryold = opts.memory;% opts.memory = 20;
opts.memory = 10;
outSQN = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootSQN, @descentSQN,   opts);
OUTPUTS =[OUTPUTS {outSQN}];
%% Stoch Gradient
%opts.step_parameter =SVRG_step_parameter; 
outgrad = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootgrad, @descentSGD,   opts);
OUTPUTS =[OUTPUTS {outgrad}];
%% plot all error X time of each object in OUTPUTS
%  Naming, saving and plotting
Prob.title =['fval--' opts.LIBSVMdata '\_' opts.regularizor '_(m,n)_=_(' num2str(OUTPUTS{1}.opts.numdata) ','   num2str(OUTPUTS{1}.opts.n) ')_S=' num2str(opts.S) '_' opts.regulatrizor_parameter];
plotdata = extract_plot_data(OUTPUTS,Prob,'datapasses');
opts.singleplot = 1; opts.extrafieldtrim = opts.totalpasses-5; opts.logScale =2;
prettyPlot_plotdata(plotdata,opts)
