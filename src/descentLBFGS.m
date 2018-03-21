function d = descentLBFGS(x, g_eval, Hess_opt ,tol, opts)
% What should the Initial Hessian estimate be?
DATA = evalin('caller', 'DATA');
%n = length(x);
delta = DATA.delta;
lmetric = DATA.lmetric;
%lmetric.H0_optx = @(d)(lmetric.H0_opt(x,g_eval,Hess_opt,d));

%DATA.Hpast = [ DATA.Hpast H] ;
%% Updates for the inverse
% Building an update H0 whose image
% H0 Hess(D) = Hess^(-1)Hess =D;
Hess_optx = @(d)(Hess_opt(x,d));
g0 =g_eval(x);
if(isfield(opts,'finite_differencing') && opts.finite_differencing)
    Hdelta = g0 -g_eval(x-delta) ;
else
    Hdelta = Hess_optx(delta);
end
lmetric = lmetric.update(delta,Hdelta,delta'*Hdelta,lmetric);
% Hmat(:,1) = lmetric.apply([1 0 0]', lmetric)
%
%Htem = inverseQuNIc(delta,Hdelta,DATA.H0)
%% Cleaning house
d = -lmetric.apply(g0,lmetric);
DATA.lmetric = lmetric;

%DATA.Krylov = [DATA.Krylov delta];
assignin('caller', 'DATA', DATA);
end