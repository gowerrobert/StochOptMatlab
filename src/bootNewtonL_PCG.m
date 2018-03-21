function bootNewtonL_PCG(x0,f_eval, g_eval, Hess_opt,opts)
DATA = [];
n = length(x0);

DATA.H0_opt =  @(x,d) (10^(-6) * d);

if(opts.update_size ==0)
    DATA.name=  'Newton\_CG';
else
    DATA.name=  ['CG\_L\_' opts.metric_type '\_update-size\_' num2str(opts.update_size)];
end
opts.PCG.update_size= opts.update_size;
opts.PCG.x0 = zeros(n,1);
opts.PCG.iter =0;
opts.metric = [];
opts.datapass = (opts.S)/opts.numdata;
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);


end