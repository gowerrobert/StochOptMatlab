function d = descentBFGS(x, g_eval, Hess_opt ,tol, opts)
% What should the Initial Hessian estimate be?
DATA = evalin('caller', 'DATA');
n = length(x);
H =DATA.H;
% Dislocated BFGS
%delta = -g0*DATA.stp;
g0 = g_eval(x);
delta = DATA.delta;
%DATA.Hpast = [ DATA.Hpast H] ;

%% Updates for the inverse
% Building an update H0 whose image
% H0 Hess(D) = Hess^(-1)Hess =D;
Hess_optx = @(d)(Hess_opt(x,d));
if(isfield(opts,'finite_differencing') && opts.finite_differencing)
        Hdelta = g_eval(x) -g_eval(x-delta) ;
else
    Hdelta = Hess_optx(delta);
end


if(sum(Hdelta)~=0)
    if(strcmp(opts.QuNic_type,'direct'))
        E = directQuNac(delta,Hdelta,H);
    else
        E = inverseQuNac(delta,Hdelta,H);
    end
    H= H+E;
end
d = -H*g0;

if(DATA.metric_reset_method(g0,d,opts.tol )) %opts.tol 
    display('RESETING METRIC!');
   % reseting the metric;
   DATA.H = DATA.H0;
   % using the H0gradient instead
   d = -DATA.H0*g0;
end

 if(sum(Hdelta)==0 || sum(isnan(Hdelta)))
     d =zeros(n,1);
 end
 
%% Cleaning house
DATA.H = H;
%DATA.Krylov = [DATA.Krylov delta];
assignin('caller', 'DATA', DATA);
end