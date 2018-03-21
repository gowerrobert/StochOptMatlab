% demo: is a script file solves problems of the form
%     min  F(x) + \lambda/2 |x|
% where F(x) is the logistic loss function and \lambda the regularizor penalty parameter.
% It also sets printing and plotting automatically on and prints all outputs at end.
%
% Copyright (c) 2016.  Robert Gower.

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
% cd /home/robert/Dropbox/Matlab/variableM_stoch/
% cd /home/s1065527/Dropbox/Matlab/variableM_stoch
clear all;
setuppaths
%% Load Logistic parameters
opts.grad_type = 'SVRG';         % SVRG  or SGD
opts.max_iterations = 10^10;
opts.regularizor ='L2';  % huber or L2
opts.hubermu = 1.0e-4;
opts.regulatrizor_parameter =  '1/num_data'; % 'normalized';%'1/num_data';    % '1/num_data' or 1   10^(-6);
opts.LIBSVMdata ='covtype.libsvm.binary';
%% Load problem
datapath = './tests/logistic/LIBSVM_data';   % THIS RELATIVE PATH ONLY WORKS IF YOU ARE IN THE ROOT FOLDER !
[opts,f_eval,g_eval,Hess_opt ] =  load_logistic('logistic',datapath,0,opts);
n = length(opts.x0);
M = ceil(sqrt(n));                          % Memory size; number of block curvature pairs stored
opts.S = ceil(sqrt(opts.numdata));          % Sub sampling size.
opts.plotting= 1;                           % 1 - record information for plotting, 0 - otherwise
opts.prnt= 1;                               % 1 - print outer iterations, 0 - otherwise
opts.totalpasses = 10;
opts.metric_reset_method ='descent-angle';  % type of metric reseting criteria: always %descent-angle % never
OUTPUTS ={};
opts.use_optimal_step_size =0;              % already have save optimal stepsize for covtype
problem =opts.LIBSVMdata; load_problem_parameters;
opts.Timeout =30000;                        % permitted time in seconds
%% Limited memory stochastic BFGS stochastic  (gauss)
opts.step_parameter = LBBFGS_gauss_step_parameter;
opts.metric_type = 'ML';
opts.H0 = 1;                           % eye, average_project_grad
opts.update_sample_matrix = 'gauss';   % 'gauss' , 'prev' , 'metric_action'
opts.memory = 5*M;  % 6*M
opts.update_size =M;
outLBBFGSg = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLvariableM_stoch , @descentLvariableM_stoch,   opts);
OUTPUTS = [  {outLBBFGSg} OUTPUTS];
%% Limited memory stochastic BFGS stochastic  previsious directions delayed (prev)
opts.step_parameter =  LBBFGS_prev_step_parameter ;
opts.H0 = 1;                        % eye, average_project_grad
opts.memory =5*M;
opts.update_size =M;
outLBBFGSpdd = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLBBFGS_skip , @descentLBBFGS_skip,   opts);
OUTPUTS = [ OUTPUTS {outLBBFGSpdd}];
%% Limited  self conditioning Factored BBFGS stochastic  (fact)
opts.step_parameter =  LFBBFGS_step_parameter;% ;
opts.metric_type = 'fact';
opts.H0 = 1;                       %  eye, average_project_grad
opts.memory = 3*M;
opts.update_size =M;
outLF = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLFB_BFGS_stoch , @descentLFB_BFGS_stoch,   opts);
OUTPUTS = [ OUTPUTS {outLF}];
%% SQN - Stochastic L-BFGS method quasi-Newton.
opts.step_parameter =  SQN_step_parameter ;
opts.L =10;
memoryold = opts.memory;
opts.memory = 10;
outSQN = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootSQN, @descentSQN,   opts);
OUTPUTS =[OUTPUTS {outSQN}];
%% Stoch Gradient
opts.step_parameter =SVRG_step_parameter;
outgrad = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootgrad, @descentSGD,   opts);
OUTPUTS =[OUTPUTS {outgrad}];
%% plot all error X time of each object in OUTPUTS
%  Naming, saving and plotting
Prob.title =['fvals-' opts.LIBSVMdata '\_' opts.regularizor '_(m,n)_=_(' num2str(OUTPUTS{1}.opts.numdata) ','   num2str(OUTPUTS{1}.opts.n) ')_S=' num2str(opts.S) '_' opts.regulatrizor_parameter];
plotdata = extract_plot_data(OUTPUTS,Prob,'datapasses');
opts.singleplot = 1; opts.extrafieldtrim = 22; opts.logScale =2;
prettyPlot_plotdata(plotdata,opts)
