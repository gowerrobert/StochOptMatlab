%% step size parameters for covtype
opts.Timeout =150;  
M = 10;
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =   1;%10^(-1);
% LBBFGS_prev
LBBFGS_prev_step_parameter =  10^(-1);%1;
% LFBBFGS
LFBBFGS_step_parameter  =1;%; 10^(-1);
%SQN 
SQN_step_parameter  = 5*10^(-2);% 5*10^(-2);
% SVRG 
SVRG_step_parameter  = 1; %10^(-1);