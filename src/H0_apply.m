function out =  H0_apply(opts,v)
if(isnumeric(opts.H0))
    out = v*opts.H0;
else
    switch(opts.H0)
        case 'eye'
            out = v;
        case 'average_project_grad'
            out = average_project_grad(opts,v);
        otherwise
            out = zeros(size(v));
    end
end
end