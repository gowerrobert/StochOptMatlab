%% step size parameters for SUSY
opts.Timeout =100;    
%% Full Memory
% BBFGS_gauss
BBFGS_gauss_step_parameter =   10^(-5);
% FBBFGS gaussian
FBBFGS_gauss_step_parameter =   10^(-1);
%% Limited Memory
% LBBFGS_metric-action-gauss
LBBFGS_prev_step_parameter =   5*10^(-1);
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =   1;
% LFBBFGS
LFBBFGS_step_parameter  =  5*10^(-1);
%SQN 
SQN_step_parameter  =  5*10^(-2);
% SVRG 
SVRG_step_parameter  =1;
