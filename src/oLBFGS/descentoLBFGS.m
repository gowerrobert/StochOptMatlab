% oLBFGS implemented according to Schraudolph, N. N., & Simon, G. (2007).
%A Stochastic Quasi-Newton Method for Online Convex Optimization.
%In Proceedings of 11th International Conference on Artificial Intelligence and Statistics.
function d = descentoLBFGS(x, g_eval, Hess_opt ,tol, opts)
DATA = evalin('caller', 'DATA');
xold = DATA.xold;
lmetric = DATA.lmetric;
lmetric.Hdiag = H0oLBFGS(lmetric); % implementation of equation (14)
%% Updates for the inverse
gold = g_eval(xold,DATA.grad_sample);
delta = x-xold;
Hdelta = DATA.grad -gold + (delta)*opts.lam ;
lmetric = lmetric.update(delta,Hdelta,delta'*Hdelta,lmetric);
%% Cleaning house
if (xold ==x)  % First iteration take damped SGD step
    d = -opts.ep*DATA.grad;
else
    d = -lmetric.apply(DATA.grad,lmetric);    
end
DATA.lmetric = lmetric;
DATA.xold = x;
opts.beta = 1;
assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);
end