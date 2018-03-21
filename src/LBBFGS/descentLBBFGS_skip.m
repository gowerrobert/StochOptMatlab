function d = descentLBBFGS_skip(x, g_eval, Hess_opt ,tol, opts)
% The SQN method as described in "A Stochastic Quasi-Newton Method for
% Large-Scale Optimization" by R H Byrd,  Jorge  Nocedal and Y Singer.
DATA = evalin('caller', 'DATA');
iteration = evalin('caller','iteration');
%% Apply L-BFGS operator
if (iteration<= opts.skip_size)
    d = -DATA.grad;
else
    d= Lmetric_apply(opts,-DATA.grad);
end
DATA.prev_directions = [ d DATA.prev_directions ];
%% Update metric
if(mod(iteration,opts.skip_size)==0)
    if(iteration>= opts.skip_size)
        if(isfield(opts,'T'))
            hess_sample = randsample(opts.numdata ,opts.T, true);
        else
            hess_sample = DATA.grad_sample;
        end
         HeD = Hess_opt(x,DATA.grad_sample,DATA.prev_directions);
        % Updating metric
        opts = metric_update(opts,DATA.prev_directions,HeD);
        DATA.prev_directions =[];
    end
end

assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);
end
