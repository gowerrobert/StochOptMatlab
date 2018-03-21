function d = descentLBBFGS_skip_average(x, g_eval, Hess_opt ,tol, opts)
% The SQN method as described in "A Stochastic Quasi-Newton Method for
% Large-Scale Optimization" by R H Byrd,  Jorge  Nocedal and Y Singer.
DATA = evalin('caller', 'DATA');
iteration = evalin('caller','iteration');
%% Apply L-BFGS operator
if (DATA.activate_metric )
    d= Lmetric_apply(opts,-DATA.grad);
else
    d = -DATA.grad;
end
DATA.xmean = DATA.xmean +x;
if(mod(iteration,opts.bucket.size)==0 )
    DATA.xmean = DATA.xmean/opts.bucket.size;
    if(iteration > opts.bucket.size)
        delta = DATA.xmean - DATA.xoldmean;
        DATA.prev_directions = [ delta DATA.prev_directions ];
        DATA.directions_kept = DATA.directions_kept+1;
    end
    DATA.xoldmean = DATA.xmean;
    DATA.xmean = 0;
end
%% Update metric
if(DATA.directions_kept == opts.bucket.num)
%     fprintf('bucketsize = %d, num of buckets = %d \n',opts.bucket.size, opts.bucket.num );   
    HeD = Hess_opt(x,DATA.grad_sample,DATA.prev_directions);
    opts = metric_update(opts,DATA.prev_directions,HeD);
    DATA.prev_directions =[];
    DATA.directions_kept =0;
    DATA.activate_metric =1;
end

assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);
end

% Curvature 