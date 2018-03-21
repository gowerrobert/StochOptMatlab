function bootLvariableM_stoch(x0, f_eval,g_eval, Hess_opt,opts)

DATA = [];
n = length(x0);
if(isfield(opts, 'name'))
    DATA.name = opts.name;
else
    DATA.name= [  opts.update_sample_matrix '\_'  num2str(opts.update_size) '\_M\_' num2str(opts.memory/opts.update_size) ];
end
%opts.reset_frequency = ceil(sqrt(n));
% Start with binay D -- Very Unstable
%p = randsample(length(x0) ,opts.update_size);
%opts.metric.D =imerse_matrix(length(x0),p);
opts.metric =[];
opts.metric.D = randn(n, opts.update_size); 
opts.metric_update_direction = @(opts_,d_)metric_update_direction(opts_,d_);
DATA.datapass_additional = 0;
DATA.datapass_product = opts.update_size*(opts.S)/opts.numdata;
%
assignin('caller', 'x0', x0);
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);


end