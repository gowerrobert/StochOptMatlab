function bootBFGS(x0, f_eval, g_eval, Hess_opt,opts)
opts.QuNic_type = 'inverse';                %This signals that the BFGS update should be used
DATA = [];
n = length(x0);
% Take a steepest descent step
evalin('caller','opts.maximage =1;');

% Select H0 approx
DATA.H0 =  H0_select(x0,f_eval, g_eval, Hess_opt,opts);
DATA.metric_reset_method =  metric_reset_method(x0,f_eval, g_eval, Hess_opt,opts);

g0 = g_eval(x0);
stp = line_search(opts.line_search,x0,f_eval,g_eval,g0,-g0,Hess_opt);
DATA.delta = -stp*g0;
DATA.stp = stp;
%[DATA.H0, DATA.delta] = H0gradProject(x0, g_eval, Hess_opt);
DATA.H= DATA.H0;
% The first QuNIC step is simply a steepest descent step
%x0 = x0+DATA.delta;
%
if (strcmp( opts.QuNic_type,'inverse'))
    if(isfield(opts,'finite_differencing') && opts.finite_differencing)
        DATA.name =  'BFGS';
    else
        DATA.name = 'BFGS_exact';
    end
else
    if(isfield(opts,'finite_differencing') && opts.finite_differencing)
        DATA.name =  'DFP';
    else
        DATA.name = 'DFP_exact';
    end
end

DATA.steps = DATA.delta;
DATA.x0 = x0;
assignin('caller', 'x0', x0);
assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);

end