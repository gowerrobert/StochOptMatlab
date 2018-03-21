% Load Problem


 [opts,f_eval,g_eval,Hess_opt ] = load_TEST_OPT(problem,n,tol,opts);
% load_rosen();
% Load common method parameters
opts.PCG.memory_limit =10;
opts.PCG.maxit = opts.PCG.memory_limit;
opts.PCG.tol = 'super-linear'; %= super-linear,  'quadratic';  0.01;
opts.PCG.prnt= 0;
opts.Timeout = 10*60; % 5 min = 5*60
opts.CGprnt= 0;
opts.tol = tol;
opts.n = n;
opts.line_search ='armijo'; %armijo, exact, none, backtrack, strongwolfe
opts.prnt= 1;
opts.H0_method = 'identity'; %huber_inverse % 'Identity' % 'projected gradient'
opts.H0_opt_method = 'identity'; %'projected gradient' %'huber_inverse' % identity
opts.metric_reset_method ='descent-angle'; %always %descent-angle % 'never'
opts.CG_reset_method ='always'; %always %never
opts.step_method = 'Newton-CG';  % 'metric-grad' %'Newton-CG'
opts.QuNic_type = 'inverse'; % 'inverse' %'direct'