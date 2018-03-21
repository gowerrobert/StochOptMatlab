function out =  L0_apply(opts,v)
if(isnumeric(opts.H0))
    out = v*sqrt(opts.H0);
else
    switch(opts.H0)
        case 'eye'
            out = v;
        case 'average_project_grad'
            out = average_project_grad_sqrt(opts,v);            
        otherwise
            out = 0;
    end
end
end