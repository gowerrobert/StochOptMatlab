function d= quNac_apply(opts, v)
     
mtc = opts.metric;    
DHeD = ((mtc.D')*mtc.HeD);
invHeDv = DHeD\((mtc.D')*v);
projv = mtc.D*invHeDv;

Heprojv= mtc.HeD*invHeDv;
w  = H0_apply(opts,v) - H0_apply(opts,Heprojv);
% w = opts.H0(v) -opts.H0(Heprojv);
d =projv+ w -mtc.D*(DHeD\((mtc.HeD')*w));
% w = -mtc.D*(DHeD\((mtc.HeD')*(opts.H0(Heprojv))));

end
