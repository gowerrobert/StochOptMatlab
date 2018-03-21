function d= LAIR_apply(opts,v)
mtc = opts.metric;    
DHeD = ((mtc.D')*mtc.HeD);
invHeDv = DHeD\((mtc.D')*v);
projv = mtc.D*invHeDv;
Heprojv= mtc.HeD*invHeDv;
d = opts.H0(v) + projv ...
 -mtc.D*(DHeD\((mtc.HeD')*(opts.H0(Heprojv))));

 %(Heprojv')*(opts.H0(Heprojv));

%-opts.metric.D*(DHeD\((opts.metric.HeD')*(opts.H0(Heprojv))));

% toc
end

