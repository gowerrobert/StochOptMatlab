%% step size parameters for real_sim
opts.Timeout =30;  
M = M_small;
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =  10^(-2);%5*10^(-1);  % 5*10^(-2);
% LBBFGS_prev
LBBFGS_prev_step_parameter =   2*10^(-2); %5*10^(-1); % 5*10^(-2);
% LFBBFGS
LFBBFGS_step_parameter  =  10^(-1);
%SQN 
SQN_step_parameter  =  10^(-2);
% SVRG 
SVRG_step_parameter  =1;
