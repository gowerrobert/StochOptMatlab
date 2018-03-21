function bootSQN(x0, f_eval,g_eval, Hess_opt,opts)
DATA = [];
% Constants specific to SQN
if(~isfield(opts,'L'))
    opts.L = 10;
end
if(~isfield(opts,'bH'))
    opts.bH = floor(min((opts.L*opts.S)/2,(opts.numdata)^(2/3)));
end
opts.xmean = 0;

lmetric.Y ={};
lmetric.S ={};
lmetric.YS ={};
lmetric.memory_limit = opts.memory;
lmetric.apply = @(g,llmetric)(lbfgsProd_struct(g,llmetric));
lmetric.update = @(p,Ap,pAp,llmetric)(update_lmetric_cells(p,Ap,pAp,llmetric));
% DATA.name = [ 'SQN\_L' num2str(opts.L) '\_b\_' num2str(opts.b) '\_bH\_' num2str(opts.bH)];
if(strcmp(opts.grad_type,'SVRG'))
    prefix= 'MNJ';
else
    prefix= 'BHNS';
end
DATA.name = [ prefix '\_bH\_' num2str(opts.bH)];
DATA.lmetric = lmetric;
DATA.datapass_additional = opts.bH/(opts.numdata*opts.L);  %(max(opts.bH/opts.L - opts.S,0))/opts.numdata;
DATA.datapass_product = (opts.bH/opts.L)/opts.numdata;
% opts.alpha =2;
% opts.beta =0.5;

assignin('caller', 'x0', x0);
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);
end
