opts.Timeout =30; 
M = ceil(n^(1/2));
%% step size parameters for covtype
% LBBFGS_prev    %%using previous search directions
LBBFGS_prev_step_parameter =   5*10^(-7); 
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =   5*10^(-3);
% LFBBFGS
LFBBFGS_step_parameter  =  5*10^(-8);
%SQN 
SQN_step_parameter  =  10^(-7);
% SVRG 
SVRG_step_parameter  = 10^(-7);
