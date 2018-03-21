function d = descentLvariableM_stoch(x, g_eval, Hess_opt ,iteration, opts)
%% Limited memory stochastic Variable Metric Methods
DATA = evalin('caller', 'DATA');
% Sampling the action
HeD = Hess_opt(x,DATA.grad_sample,opts.metric.D);
% opts.hess_vec = opts.update_size;
% Updating metric
iteration = evalin('caller','iteration');
opts = metric_update(opts,opts.metric.D,HeD);
% Applying the metric to the negative  subsampled gradient
d= Lmetric_apply(opts,-DATA.grad);
% Update D for sampling action
opts = update_sample_matrix(opts,d);
assignin('caller', 'opts', opts);
end