function beststep =  optimal_step_size(x0, f_eval, g_eval, Hess_opt, boot_method, descent_method,   opts)

grid = [1, 5*10^(-1), 10^(-1), 5*10^(-2), 10^(-2), 5*10^(-3),10^(-3), 5*10^(-4),10^(-4), ... 
    5*10^(-5), 10^(-5), 5*10^(-6),10^(-6), 5*10^(-7),10^(-7), 5*10^(-8), 10^(-8), 5*10^(-9), 10^(-9), 5*10^(-10), 10^(-10)];

minf = inf;
beststep = 1;
opts.get_optimal_step_size =0;
for gg = 1: length(grid)
    display(['Trying stepsize: ' num2str(grid(gg))]);
    opts.step_parameter = grid(gg);
    try
    out = stochastic_solve(x0, f_eval, g_eval, Hess_opt, boot_method, descent_method,   opts);
    catch something_messed_up % try a smaller step size 
        continue;
    end
    if(strcmp(out.stopping_flag,'NaN') || (max(out.errors) > out.errors(1)))
        continue;
    elseif(min(out.errors(end)) < minf)
       minf = out.errors(end);
       beststep = grid(gg);
    else %already found a better solution
       return; 
    end
end

end