function d = descentSQN(x, g_eval, Hess_opt ,tol, opts)
% The SQN method as described in "A Stochastic Quasi-Newton Method for
% Large-Scale Optimization" by R H Byrd,  Jorge  Nocedal and Y Singer.
DATA = evalin('caller', 'DATA');
iteration = evalin('caller','iteration');
opts.xmean = opts.xmean +x;
lmetric = DATA.lmetric;
%% Apply L-BFGS operator
if (iteration<= 2*opts.L)
    d = -DATA.grad;
else
    d = -lmetric.apply(DATA.grad,lmetric);
end
%% Update metric
if(mod(iteration,opts.L)==0)
    opts.xmean = opts.xmean/opts.L;
    if(iteration>= 2*opts.L)
        delta = opts.xmean - opts.xoldmean;
        sH = randsample(opts.numdata ,opts.bH);
        Hdelta = Hess_opt(opts.xmean,sH,delta);
        lmetric = lmetric.update(delta,Hdelta,delta'*Hdelta,lmetric);
        DATA.lmetric = lmetric;
    end
    opts.xoldmean = opts.xmean;
end

% opts.beta = 0.1;
% opts.alpha = 2;
assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);
end
