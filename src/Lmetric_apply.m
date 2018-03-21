function d = Lmetric_apply(opts,v)
if(opts.memory ==0)
    switch(opts.metric_type)
        case 'SDNA'
            d= SDNA_apply(opts,v);
        case 'AIR'
           d= LAIR_apply(opts,v);
        case 'BBFGS'
           d = quNac_apply(opts,v);
        otherwise
           display('NOT A VALIDE METRIC in Lmetric_apply');
           d=v;
    end
else
    d=  LBBFGS_apply_cells(opts,v);%LBBFGS_apply_cells(opts,v); % LBBFGS_apply(opts,v);
end
end
