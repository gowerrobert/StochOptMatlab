function opts = metric_update(opts,D,HeD)
if(opts.memory ==0)
   opts.metric.D = D;
   opts.metric.HeD = HeD;
else
    try
    R = chol(D'*HeD);
    catch negdef
        negdef
    end
   opts.metric =update_LBBFGS(opts.metric,D,HeD,R, opts.memory, opts.update_size);
end


end