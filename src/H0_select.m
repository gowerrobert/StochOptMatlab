function func =  H0_select(opts)
switch(opts.H0)
    case 'eye'
        func = @(d)(d);
    otherwise
        func = 'zero';
end

end