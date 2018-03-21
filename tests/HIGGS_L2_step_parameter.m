%% step size parameters for HIGGS
%% parameters
M = M_med;
opts.Timeout =1000; 
opts.memory = 5*M;
opts.update_size =M;
%% Full memory
ML_gauss_step_parameter =10^(-5);  %% stil no good!
MLF_gauss_step_parameter =10^(0);
%% Limited Memory
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =  5*10^(-2);%10^(-1); 
% LBBFGS_prev    %%using previous search directions
LBBFGS_prev_step_parameter =  5*10^(-2);    
% LFBBFGS
LFBBFGS_step_parameter  =  10^(-1); 
%SQN 
SQN_step_parameter  =  10^(-2); % 5*10^(-2) sometimes results in sharp spikes
% SVRG 
SVRG_step_parameter  = 5*10^(-2);
