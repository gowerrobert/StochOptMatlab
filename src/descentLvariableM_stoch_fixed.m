function d = descentLvariableM_stoch_fixed(x, g_eval, Hess_opt ,iteration, opts)
%% Updates for the inverse 
% Sampling the action
if(mod(iteration-1,opts.update_frequency) ==0 || iteration <= ceil(opts.memory/opts.update_size))
    opts.sb = randsample(opts.numdata ,opts.Sb);
    HeD = Hess_opt(x,opts.sb,opts.metric.D);
    opts.hess_vec = opts.update_size;
    % Updating metric
    opts =metric_update(opts,opts.metric.D,HeD);
end
% Sampling action of gradient
s = randsample(opts.Sb ,opts.S);
g0 = g_eval(x,opts.sb(s)); 
% Applying the metric to the negative  subsampled gradient
d= Lmetric_apply(opts,-g0);
% Update D for sampling action
opts = update_sample_matrix(opts,d);

%% Cleaning house
% grad = g_eval(x,opts.numdata)
% g0
%step = 1/(5000*(1+iteration));
%d = d*step;
%(0.000176, 0.222222)
% opts.beta = 10^(-5);
% opts.alpha =1;
% opts.beta  = lnsrch_bt( x, d, g0'*d, f0, 1/iteration, @(y,mu)(f_eval(y,s)),@(y,iter,mu)(0), [], 0 );
% opts.alpha =1;
assignin('caller', 'opts', opts);
end