%% step size parameters for url
opts.Timeout =6000;  
M = 2;
memory =3;
% LBBFGS gaussian
LBBFGS_gauss_step_parameter =  10^(-2);% for M  = 10 use 5*10^(-1);  % 5*10^(-2);
% LBBFGS_prev
LBBFGS_prev_step_parameter =   10^(-2);
% LFBBFGS
LFBBFGS_step_parameter  = 10^(-2);
%SQN 
SQN_step_parameter  =   10^(-2);%5*10^(-2) has good initial behaviour but then growing oscilatory behaviour
% SVRG 
SVRG_step_parameter  =10^(-1);
