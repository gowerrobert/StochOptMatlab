function reset_method  =  metric_reset_method(x0,f_eval, g_eval, Hess_opt,opts)

if(isfield(opts,'metric_reset_method'))
    switch lower(opts.metric_reset_method)
        case 'descent-angle'            
            reset_method = @(g,s,tol)sufficient_descent_angle(g,s,tol);
        case 'always'
            reset_method = @(g,s,tol)(1);
        otherwise
            reset_method = @(g,s,tol)(0);
    end
else
    reset_method = @(g,s,tol)(0);
end

end