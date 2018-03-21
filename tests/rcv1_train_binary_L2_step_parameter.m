%% step size parameters for rcv1
M = 10;
opts.Timeout =20; 
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =  1; % 10^(-1); % 2*10^(-1); for M_small
% LBBFGS_prev
LBBFGS_prev_step_parameter =  5*10^(-1);%5*10^(-2)
% LFBBFGS
LFBBFGS_step_parameter  = 5*10^(-1);%; 5*10^(-2);
%SQN 
SQN_step_parameter  =  10^(-2);% 5*10^(-2);
% SVRG 
SVRG_step_parameter  =1;
