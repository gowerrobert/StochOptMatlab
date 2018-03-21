
%% Limited BBFGS stochastic  (LBBFGS)
opts.step_parameter = LBBFGS_gauss_step_parameter;
opts.metric_type = 'ML';              % AIR, BBFGS  % type of metric matrix 'inverse' %'direct'
opts.H0 = 1;                        % eye, average_project_grad
opts.update_sample_matrix = 'gauss';   % 'gauss' , 'prev' , 'metric_action'
opts.memory = 5*M;  % 6*M
opts.update_size =M;
outLBBFGSg = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLvariableM_stoch , @descentLvariableM_stoch,   opts);
OUTPUTS = [  {outLBBFGSg} OUTPUTS];
%% Limited BBFGS stochastic  previsious directions delayed (LBBFGSpdd)
opts.step_parameter = LBBFGS_prev_step_parameter ;
opts.H0 = 1;                        % eye, average_project_grad
opts.memory =5*M;
opts.update_size =M;
outLBBFGSpdd = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLBBFGS_skip , @descentLBBFGS_skip,   opts);
OUTPUTS = [ OUTPUTS {outLBBFGSpdd}];
%% Limited BBFGS stochastic averaged previsious directions delayed (LBBFGSpdd)
%opts.step_parameter = SQN_step_parameter; %SQN_step_parameter ;
%opts.H0 = 1;%'average_project_grad';                        % eye, average_project_grad
% opts.memory =5*M;
%outLBBFGSpdd = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLBBFGS_skip_average , @descentLBBFGS_skip_average,   opts);
%OUTPUTS = [ OUTPUTS {outLBBFGSpdd}];
%% Limited  self conditioning Factored BBFGS stochastic  (LFB-BFGS) 
opts.step_parameter = LFBBFGS_step_parameter;% ;
opts.metric_type = 'fact';              % AIR, BBFGS  % type of metric matrix 'inverse' %'direct'
opts.H0 = 1;                       % 10^(-9), eye, average_project_grad
opts.memory = 3*M;
opts.update_size =M;
outLF = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLFB_BFGS_stoch , @descentLFB_BFGS_stoch,   opts);
OUTPUTS = [ OUTPUTS {outLF}];
%% SQN - Stochastic quasi-Newton by Nocedal or  BHNS - Byrd, Hansen, Nocedal,  Singer
opts.step_parameter = SQN_step_parameter ;
opts.L =10;
memoryold = opts.memory;% opts.memory = 20;
opts.memory = 10;
outSQN = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootSQN, @descentSQN,   opts);
OUTPUTS =[OUTPUTS {outSQN}];
opts.memory = memoryold;
%% Stoch Gradient
opts.step_parameter = SVRG_step_parameter;
outgrad = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootgrad, @descentSGD,   opts);
OUTPUTS =[OUTPUTS {outgrad}];
