% Compare all limited memory method using a predetermined step_size for each
% Should be called from...
% %% Limited BBFGS stochastic  (LBBFGS)
% opts.step_parameter =  LBBFGS_gaussian_step_parameter;
% opts.metric_type = 'LBBFGS';              % AIR, BBFGS  % type of metric matrix 'inverse' %'direct'
% opts.H0 = 'eye';%10^(-11);                          % 'eye', stoch_grad_proj
% opts.update_sample_matrix = 'metric-action-gauss';   % 'gaussian' , 'search-directions' , 'metric-action', 'metric-action-gauss'
% opts.update_size =M;
% outLBBFGS = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLvariableM_stoch , ...
%     @descentLvariableM_stoch,   opts);
% OUTPUTS = [ OUTPUTS {outLBBFGS}];
%% Limited BBFGS stochastic  (LBBFGS)
opts.step_parameter = LBBFGS_gaussian_step_parameter;
opts.metric_type = 'LBBFGS';              % AIR, BBFGS  % type of metric matrix 'inverse' %'direct'
opts.H0 = 1;                        % eye, stoch_grad_proj
opts.update_sample_matrix = 'gauss';   % 'gauss' , 'prev' , 'metric_action'
opts.memory = 5*M;  % 6*M
opts.update_size =M;
outLBBFGS = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLvariableM_stoch , ...
    @descentLvariableM_stoch,   opts);
OUTPUTS = [ OUTPUTS {outLBBFGS}];
%% Limited BBFGS stochastic  (LBBFGS)
opts.step_parameter = LBBFGS_prev_step_parameter ;
opts.metric_type = 'LBBFGS';              % AIR, BBFGS  % type of metric matrix 'inverse' %'direct'
opts.H0 = 1;                        % eye, stoch_grad_proj
opts.update_sample_matrix = 'prev';   % 'gauss' , 'prev' , 'metric_action'
opts.memory = 5*M;
opts.update_size =M;
outLBBFGS = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLvariableM_stoch , ...
    @descentLvariableM_stoch,   opts);
OUTPUTS = [ OUTPUTS {outLBBFGS}];
%% Limited BBFGS stochastic averaged previsious directions delayed (LBBFGSpdd)
opts.step_parameter = SQN_step_parameter; %SQN_step_parameter ;
opts.H0 = 1;%'average_project_grad';                        % eye, average_project_grad
opts.memory =5*M;
outLBBFGSpdd = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLBBFGS_skip_average , @descentLBBFGS_skip_average,   opts);
OUTPUTS = [ OUTPUTS {outLBBFGSpdd}];
%% Limited  self conditioning Factored BBFGS stochastic  (LFB-BFGS) 
opts.step_parameter = LFBBFGS_step_parameter;
opts.metric_type = 'LFBBFGS';              % AIR, BBFGS  % type of metric matrix 'inverse' %'direct'
opts.H0 = 1;                        % 10^(-9), eye, stoch_grad_proj
opts.memory = 3*M;
opts.update_size =M;
outLBBFGS = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootLFB_BFGS_stoch , ...
    @descentLFB_BFGS_stoch,   opts);
OUTPUTS = [ OUTPUTS {outLBBFGS}];
%% SQN - Stochastic quasi-Newton by Nocedal or  BHNS - Byrd, Hansen, Nocedal,  Singer
opts.step_parameter = SQN_step_parameter ;
opts.L =10;
opts.memory = 20;
outSQN = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootSQN, @descentSQN,   opts);
OUTPUTS =[OUTPUTS {outSQN}];
%% oLBFGS - Online LBFGS
% opts.prnt= 1; 
% opts.memory =20;
% outoLBFGS = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootoLBFGS, @descentoLBFGS,   opts);
% OUTPUTS =[OUTPUTS {outoLBFGS}];
%% Stoch Gradient
opts.step_parameter =1;%SVRG_step_parameter;
opts.prnt= 1; 
outgrad = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootgrad, @descentSGD,   opts);
OUTPUTS =[OUTPUTS {outgrad}];
