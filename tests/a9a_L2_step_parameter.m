%% step size parameters for real_sim
opts.Timeout =5; 
M = ceil(sqrt(n));         
%% Limited Memory
% LBBFGS_metric-action-gauss
LBBFGS_prev_step_parameter =   10^(-1);
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =   10^(-1);
% LFBBFGS
LFBBFGS_step_parameter  =  10^(-2);
%SQN 
SQN_step_parameter  =  10^(-1);
% SVRG 
SVRG_step_parameter  =10^(-1);