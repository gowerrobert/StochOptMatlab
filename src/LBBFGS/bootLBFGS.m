function bootLBFGS(x0, f_eval,g_eval, Hess_opt,opts)
opts.QuNic_type = 'inverse';                %This signals that the BFGS update should be used
DATA = [];
%x0 = opts.x0;
n = length(x0);
% Using a

%[lmetric.H0_opt,DATA.H0] =  H0_method_select(x0,f_eval, g_eval, Hess_opt,opts);
%lmetric.H0_optx = @(d)(lmetric.H0_opt(x0,g_eval,Hess_opt,d));

% The first QuNIC step is simply a steepest descent step
g0 = g_eval(x0);
Ad = Hess_opt(x0,-g0);
alpha = lnsrch_exact(-g0,g0,Ad);
lmetric.Hdiag = alpha;
DATA.delta = -g0*alpha;
x0 = x0+DATA.delta;

lmetric.Y ={};
lmetric.S ={};
lmetric.YS ={};

lmetric.memory_limit = opts.PCG.memory_limit;
lmetric.apply = @(g,llmetric)(lbfgsProd_struct(g,llmetric));
lmetric.update = @(p,Ap,pAp,llmetric)(update_lmetric_cells(p,Ap,pAp,llmetric));

opts.PCG.CGmem =opts.PCG.memory_limit;
opts.PCG.CGsteps =1;

if (strcmp( opts.QuNic_type,'inverse'))
    if(isfield(opts,'finite_differencing') && opts.finite_differencing)
        DATA.name =  'LBFGS';
    else
        DATA.name = 'LBFGS_exact';
    end
else
    if(isfield(opts,'finite_differencing') && opts.finite_differencing)
        DATA.name =  'LDFP';
    else
        DATA.name = 'LDFP_exact';
    end
end

DATA.lmetric = lmetric;
assignin('caller', 'x0', x0);
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);


end
