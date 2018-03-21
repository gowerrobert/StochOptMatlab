function opts= gaussian_search_direction(opts,d)
opts.metric.D = randn(length(d), opts.update_size); 
end