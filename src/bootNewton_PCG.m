function bootNewton_PCG(x0, f_eval,g_eval, Hess_opt,opts)

DATA = [];
n = length(x0);
DATA.H0 =  10^(-6)*eye(n,n);
DATA.metric_reset_method =  metric_reset_method(x0,f_eval, g_eval, Hess_opt,opts);
DATA.H=DATA.H0;
% Setup PCG 
opts.PCG.x0 = zeros(n,1);
opts.PCG.iter =0;
opts.PCG.update_size= opts.update_size;
DATA.name= ['CG\_' opts.metric_type ];
DATA.x_CG = x0;

assignin('caller', 'x0', x0);
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);


end