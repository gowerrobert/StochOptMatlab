function d = SDNA_apply(opts,g)
%d0 -D*(DHeD\(HeD'*d0 +(D')*g0)) 
DHeD = (opts.metric.D')*opts.metric.HeD;
d =  opts.metric.D*(DHeD\((opts.metric.D')*g)); 
end