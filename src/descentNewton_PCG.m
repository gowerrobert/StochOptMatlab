function d = descentNewton_PCG(x, g_eval, Hess_opt ,iteration, opts)
% What should the Initial Hessian estimate be?
DATA = evalin('caller', 'DATA');
%% Updates for the inverse
% Building an update H0 whose image
% H0 Hess(D) = Hess^(-1)Hess =D; 
s = randsample(opts.numdata ,opts.S);
Hess_optx = @(d)(Hess_opt(x,s,d));
g0 = g_eval(x,s);
% Pre-conditioned version
M =  @(d)( (DATA.H)*d);    % *DATA.stp
opts.PCG.normr0 = -1;
[opts.PCG , D, HeD] = PCG_bounded(Hess_optx,M,g0,opts.PCG);
opts.hess_vec = opts.PCG.hess_vec;
% Updating metric.
DATA.H = update_conjugate_metric(DATA.H,D,HeD,opts.metric_type);

%% Cleaning house
if(strcmp(opts.step_method,'Newton-CG') && ~isempty(D))
    d = opts.PCG.x;
else
    d = -(DATA.H)*g0;
end
% Test metric reset
if(DATA.metric_reset_method(g0,d,opts.tol ) || strcmpi(opts.PCG.flag,'neg_preconditioner') ) %opts.tol
   if(opts.prnt) display('RESETING METRIC!'); end
    % reseting the metric;
    DATA.H = DATA.H0;
   % using the H0gradient instead
   d = -DATA.H0*g0;
end

%step = 1/(1+iteration);
%d = d*step;
assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);
end