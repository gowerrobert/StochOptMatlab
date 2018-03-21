% main_logisitc: is a script file solves problems of the form
%     min  F(x) + \lambda R(x)
% where F(x) is the logistic loss function and R(x) a regularizor, and \lambda the regularizor penalty parameter.
% It also sets printing and plotting automatically on and prints all outputs at end.
%
% Copyright (c) 2014.  Robert Gower.

%  problem =               'logisitc'; Requires field opts.LIBSVMdata
%------------------------------------------------------------------------------
% opts.LIBSVMdata =              a string that specifiecs a LIBSVM binary data file,
%                                exe, 'heartsc'
% opts.regularizor =              'L2' to a L2 euclidean regularizor o
%                                 'huber' for a pseudo-huber regularizor
% opts.regulatrizor_parameter =   the regularior penalty parameter
%                               (\lambda). Must be a positive number.
% opts.hubermu =                 a number in [0 1] specifies accuracy of
%                                pseudo-huber approxamition to the L1 norm where hubermu-> 0 as
%                                pseudo-huber tends to a L1 regularizor
% cd /home/gowerrobert/Dropbox/Matlab/variableM_stoch/
% cd /home/s1065527/Dropbox/Matlab/variableM_stoch
setuppaths
clear all;
%% Load Logistic parameters
opts.grad_type = 'SVRG';         % SVRG  SGD
opts.max_iterations = 10^10;
opts.regularizor ='L2';  % huber or L2
opts.hubermu = 1.0e-4;
opts.regulatrizor_parameter = '1/num_data';    % '1/num_data' or 1   10^(-6);
opts.LIBSVMdata ='rcv1_train.binary';  %liver-disorders  a9a  w8a  covtype.libsvm.binary   gisette_scale  real-sim   rcv1_train.binary                   
% Stochastic subsampling of gradients and Hessian-vector products 
%% Load problem
datapath = '/home/s1065527/Software/Matlab/libsvm/data'; 
% datapath = '/home/gowerrobert/Dropbox/Software/LIBSVM';
tol =0;
 [opts,f_eval,g_eval,Hess_opt ] =  load_logistic('logistic',datapath,tol,opts);
%%
n = length(opts.x0);                    
M = ceil(sqrt(n));                 % Memory size
opts.S = ceil(sqrt(opts.numdata));        % Sub sampling size.
opts.update_size =M;                   % number of columns in update matrix (update rank = 2*update_size)
opts.memory=2*M;                  % Maximum amount of memory stored for Limited memory techiniques
opts.PCG.maxit = opts.memory ;    % Maximum number of PCG iterations
opts.PCG.tol = 'super-linear';              % PCG tolerance 'super-linear',  'quadratic';  0.01;
opts.PCG.prnt = 0;                          % 1 - print inner PCG iterations, 0 - otherwise
opts.plotting= 1;                           % 1 - record information for plotting, 0 - otherwise
opts.block_size = M;                         % Block size of updates
opts.prnt= 1;                               % 1 - print outer iterations, 0 - otherwise
opts.Timeout =10;                          % permitted time in seconds
opts.metric_reset_method ='descent-angle';  % type of metric reseting criteria: always %descent-angle % never
OUTPUTS ={};
%% Step size parameter sets
switch opts.LIBSVMdata
   case 'real-sim'
      step_parameter_set = 5*[10^(-1) 10^(-2) 10^(-3) 10^(-4)];
   case 'rcv1_train.binary'
      step_parameter_set = 5*[10^(-1) 10^(-2) 10^(-3) 10^(-4)];      
   otherwise
      step_parameter_set = [10^(-2) 10^(-3) 10^(-4) 10^(-5)];
end
%% Limited BBFGS stochastic  (LBBFGS)
opts.metric_type = 'LBBFGS';              % AIR, BBFGS  % type of metric matrix 'inverse' %'direct'
opts.H0 = 'eye';%10^(-11);                          % 'eye', stoch_grad_proj
opts.update_sample_matrix = 'gaussian';   % 'gaussian' , 'search-directions' , 'metric-action', 'metric-action-gauss'
opts.memory =5*M;
opts.update_size =M;
%% 
OUTPUTS =[];
for i =1:length(step_parameter_set)
    opts.step_parameter = step_parameter_set(i);
    opts.name =  sprintf('%2.0e',step_parameter_set(i));
    outLBBFGS = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLvariableM_stoch , ...
        @descentLvariableM_stoch,   opts);
    OUTPUTS = [ OUTPUTS {outLBBFGS}];
end
%% plot all error X time of each object in OUTPUTS
Prob.title = [ opts.metric_type '\_' opts.regularizor '\_' opts.LIBSVMdata]; 
prettyPlot_2subplot_solve_system_wrapper(OUTPUTS,Prob,'datapasses');
%prettyPlot_solve_system_wrapper(OUTPUTS,Prob);