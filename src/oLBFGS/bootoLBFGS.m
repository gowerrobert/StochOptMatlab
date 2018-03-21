function bootoLBFGS(x0, f_eval,g_eval, Hess_opt,opts)
DATA = [];
DATA.datapass = (opts.S)/opts.numdata;
% Constants specific to oLBFGS
opts.c=0.1;  opts.lam = 0.0; opts.ep = 10^(-10);

lmetric.Y ={};
lmetric.S ={};
lmetric.YS ={};

lmetric.memory_limit = opts.memory;
lmetric.apply = @(g,llmetric)(lbfgsProd_struct(g,llmetric));
lmetric.update = @(p,Ap,pAp,llmetric)(update_lmetric_cells(p,Ap,pAp,llmetric));
DATA.name =  'oLBFGS';
DATA.xold = x0;
DATA.datapass_additional = 0;
DATA.datapass_product = (opts.S)/opts.numdata;
DATA.lmetric = lmetric;
% opts.alpha =2;
% opts.beta = 0.5;

assignin('caller', 'x0', x0);
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);

end
