function d = descentSGD(x, g_eval, Hess_opt ,tol, opts)
DATA = evalin('caller', 'DATA');
d = -DATA.grad;
%t=evalin('caller','iteration');
% d = d/(14*(t+1));
% opts.beta = 4*10^(-4);
% opts.alpha =0.10000;
assignin('caller', 'opts', opts);
end