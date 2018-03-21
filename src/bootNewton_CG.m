function bootNewton_CG(x0,f_eval, g_eval, Hess_opt,opts)
%!-- Boot parameters for Newton_CG, so that 
% descentNewtonL_PCG reduces to simple Newton_BG
DATA = [];
n = length(x0);
opts.S = opts.numdata;
DATA.H0_opt = @(x, d)(d);
opts.PCG.memory_limit =0;
opts.PCG.update_size =0;
DATA.name=  'Newton\_CG';
opts.PCG.x0 = zeros(n,1);
opts.PCG.iter =0;
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);


end