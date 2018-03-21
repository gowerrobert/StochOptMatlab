function bootLBBFGS_skip(x0, f_eval,g_eval, Hess_opt,opts)

DATA = [];
n = length(x0);
opts.skip_size = opts.update_size;

if(isfield(opts, 'name'))
    DATA.name = opts.name;
else
    DATA.name= [  'prev\_'  num2str(opts.update_size) '\_M\_' num2str(opts.memory/opts.update_size) '\_S\_' num2str(opts.S) ];
end

if(isfield(opts,'T'))
    DATA.name= [DATA.name '\_T\_' num2str(opts.T)];
end
opts.metric =[];
opts.metric_type = 'BBFGS';
DATA.prev_directions =[];
% opts.metric_update_direction = @(opts_,d_)metric_update_direction(opts_,d_);
DATA.datapass_additional = 0;
if(isfield(opts,'T'))
   DATA.datapass_additional = DATA.datapass_additional+ (opts.T)/opts.numdata; 
end
DATA.datapass_product = opts.update_size*(opts.S)/opts.numdata;


assignin('caller', 'x0', x0);
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);


end