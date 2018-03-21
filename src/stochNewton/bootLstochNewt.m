function bootLstochNewt(x0, f_eval,g_eval, Hess_opt,opts)

DATA = [];
%% REMOVE later this next line!
DATA.H =  H0_select(x0,f_eval, g_eval, Hess_opt,opts);
if(isfield(opts,'H0_opt_method'))
    DATA.H0_opt =  H0_method_select(x0,f_eval, g_eval, Hess_opt,opts);
else
    DATA.H0_opt = opts.H0_opt;
end

% Taking a gradient step first
% g0 = g_eval(x0);
% stp = line_search(opts.line_search,x0,f_eval,g_eval,g0,-g0,Hess_opt);
% DATA.delta = -stp*g0;
% DATA.stp = stp;
% % Take a quNIC step with H0
% x0 = x0+DATA.delta;

DATA.name= 'L-Stoch. Newton';
DATA.x_CG = x0;

assignin('caller', 'x0', x0);
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);


end