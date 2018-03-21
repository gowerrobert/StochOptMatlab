function opts = sample_search_direction(opts,d)
opts.metric.D = opts.metric.D(:,1:end-1);
opts.metric.D  = [d opts.metric.D ];
end