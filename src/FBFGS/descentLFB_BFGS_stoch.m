function d = descentLFB_BFGS_stoch(x, g_eval, Hess_opt ,iteration, opts)
% Limited memory Factored self-conditioing Block BFGS
% The sample matrix are columns of L, the factored form
DATA = evalin('caller', 'DATA');
% Sampling the action
HeD = Hess_opt(x,DATA.grad_sample,opts.metric.D);
opts.hess_vec = opts.update_size;
% Updating metric
R = chol(opts.metric.D'*HeD);
opts.metric =update_LFBBFGS(opts.metric,opts.metric.D,HeD,R, opts.metric.c,opts.memory, opts.update_size);
c = randsample(opts.n ,opts.update_size);
Im =  imerse_matrix_sparse(opts.n,c);
opts.metric.D = LFBBFGS_apply(opts,opts.metric, Im); %_Identity_Cols
opts.metric.c = c;
% Applying the metric to the negative  subsampled gradient
d= -LBBFGS_apply(opts,DATA.grad);
%% Cleaning house
% opts.alpha = 10;
% opts.beta = 0.1;
assignin('caller', 'opts', opts);
end