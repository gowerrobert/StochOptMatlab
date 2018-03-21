%% step size parameters for epsilon_normalized
opts.Timeout =1100; 
%% Limited Memory
M = M_big;  
LBBFGS_gauss_step_parameter =  5*10^(-3) ;
% LBBFGS_prev    %%using previous search directions
LBBFGS_prev_step_parameter =  10^(-1); 
% LFBBFGS
LFBBFGS_step_parameter  =  5*10^(-3); 
%SQN 
SQN_step_parameter  =  5*10^(-3); 
% SVRG 
SVRG_step_parameter  = 5*10^(-1);
