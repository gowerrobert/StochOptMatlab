%% step size parameters for covtype
M = M_med;
opts.Timeout =20; 
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =  10^(-1); % 2*10^(-1); for M_small
% LBBFGS_prev
LBBFGS_prev_step_parameter =  3*10^(-2);%10^(-1);
% LFBBFGS
LFBBFGS_step_parameter  = 10^(-1);%; 5*10^(-2);
%SQN 
SQN_step_parameter  =  5*10^(-2);% 5*10^(-2);
% SVRG 
SVRG_step_parameter  =10^(-1);
