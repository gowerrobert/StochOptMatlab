function bootLFB_BFGS_stoch(x0, f_eval,g_eval, Hess_opt,opts)

DATA = [];
n = length(x0);
DATA.name= [ opts.metric_type '\_'  num2str(opts.update_size) '\_M\_' num2str(opts.memory/opts.update_size) ];
opts.metric =[];
%
% c= L0_apply(opts,1);
opts.metric.c = randsample(opts.n ,opts.update_size); 
opts.metric.D = full(imerse_matrix_sparse(opts.n,opts.metric.c)); % imerse_matrix(opts.n,opts.metric.c); %randn(n, opts.update_size);
DATA.datapass_additional = 0;
DATA.datapass_product = opts.update_size*(opts.S)/opts.numdata;
%
assignin('caller', 'x0', x0);
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);

end