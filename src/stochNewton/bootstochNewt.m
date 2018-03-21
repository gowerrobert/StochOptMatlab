function bootstochNewt(x0, f_eval,g_eval, Hess_opt,opts)

DATA = [];
n = length(x0);
DATA.H0 =  eye(length(x0));%H0_select(opts); %H0_select(x0,f_eval, g_eval, Hess_opt,opts);
DATA.metric_reset_method =  metric_reset_method(x0,f_eval, g_eval, Hess_opt,opts);
DATA.H=DATA.H0;
DATA.L0=(DATA.H0)^(1/2); 
DATA.L=DATA.L0;
opts.reset =0;
% Taking a gradient step first
% g0 = g_eval(x0);
% stp = line_search(opts.line_search,x0,f_eval,g_eval,g0,-g0,Hess_opt);
% DATA.delta = -stp*g0;
% DATA.stp = stp;
% % Take a quNIC step with H0
% x0 = x0+DATA.delta;

DATA.name= [ 'Stoch\_Newton\_' num2str(opts.update_size)];
DATA.x_CG = x0;
opts.datapass = (opts.S)/opts.numdata;
assignin('caller', 'x0', x0);
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);


end