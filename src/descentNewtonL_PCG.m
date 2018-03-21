function d = descentNewtonL_PCG(x, g_eval, Hess_opt ,iteration, opts)
% What should the Initial Hessian estimate be?
DATA = evalin('caller', 'DATA');
%% Updates for the inverse
s = randsample(opts.numdata ,opts.S);
Hess_optx = @(d)(Hess_opt(x,s,d));
g0 = g_eval(x,s);
DATA.H0_optx = @(d)(DATA.H0_opt(x,d));
% The Preconditioner-vector operator
if(isfield(opts,'metric')  && isfield(opts.metric, 'Ds') )
    %M =  @(d)( L_P_inverseQuNac_scaled(DATA.D,DATA.HeD, DATA.H0_optx ,d));
    %M =  @(d)( L_P_inverseQuNac(DATA.D,DATA.HeD, DATA.H0_optx ,d));
    M =  @(d)(  LBBFGS_apply_scaled(opts,DATA.H0_optx, d));
else
    M = DATA.H0_optx;
end

[opts.PCG , D, HeD] = PCG_bounded(Hess_optx,M,g0,opts.PCG);
opts.hess_vec = opts.PCG.hess_vec;
%display(opts.PCG.flag);
% update metric
if(isfield(opts,'metric'))
    opts.metric =update_LBBFGS(opts.metric,D,HeD,1, opts.memory, opts.update_size);
end
    
if(strcmpi(opts.PCG.flag,'neg_preconditioner'))
    display('Negative Curvature Flag');
    d = -g0;
else
    %     DATA.D = D;
    %     DATA.HeD = HeD;
    d = opts.PCG.x;
end
% If something about opts.PCG
% step = 1/(1+iteration);
% % d = d*step;
%   opts.beta = 10^(-5);
%   opts.alpha = 1;
%% Cleaning house

assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);
end