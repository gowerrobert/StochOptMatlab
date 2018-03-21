%% step size parameters for gisette_scale
opts.Timeout =50;    
%% Limited Memory
M = M_med;
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =   1*10^(-3); %
% LBBFGS_prev    %%using previous search directions
LBBFGS_prev_step_parameter =  1*10^(-3); % 
% LFBBFGS
LFBBFGS_step_parameter  =  10^(-3); %
%SQN 
SQN_step_parameter  =  1*10^(-3);
% SVRG 
SVRG_step_parameter  = 1*10^(-3);