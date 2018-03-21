%% step size parameters for w8a
%% parameters
M = ceil(sqrt(n));
opts.Timeout =5; 
opts.memory = 5*M;
opts.update_size =M;
%% Limited Memory
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =  10^(-3);%10^(-1); 
% LBBFGS_prev    %%using previous search directions
LBBFGS_prev_step_parameter =  10^(-2);     %% before delay %% 10^(0);
% LFBBFGS
LFBBFGS_step_parameter  =  5*10^(-3); %10^(-4);
%SQN 
SQN_step_parameter  =  10^(-2);
% SVRG 
SVRG_step_parameter  = 10^(-2);