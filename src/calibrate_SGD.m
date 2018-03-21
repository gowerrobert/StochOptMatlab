function opts  = calibrate_SGD(x0,f_eval, g_eval, Hess_opt,opts,method_boot, descent_method)
% Calibrate the step size   beta/(1+alpha t)
iteration =0;
safety_margin =1;
num_repeats =20;
betas = zeros(1,num_repeats);
x = x0;
min_beta = 1;
for i=1:num_repeats
    method_boot(x0,f_eval, g_eval, Hess_opt,opts);
    DATA.datapasses =0;
    step_SGD;  s =DATA.grad_sample;
    f0 = f_eval(x0,s);
    g0 = g_eval(x0,s);
%         s = randsample(opts.numdata ,opts.S);
%     DATA.grad=g0; DATA.grad_sample = s;
    d = descent_method(x0, g_eval, Hess_opt ,1, opts);
    stp0 = 2;
    beta  = lnsrch_bt( x0, d, g0'*d, f0, stp0, @(y,mu)(f_eval(y,s)),@(y,iter,mu)(0), [], 0 );
    if(beta<min_beta)
        min_beta=beta;
        stp0 = 2*min_beta;
    end
end
beta= min_beta;
alpha_max = 1/10;
%take 10 steps and see if the last is decrease, otherwise start again and
%double alpha?

for j=1:10
    alpha = alpha_max/2;
    fk = 2*f0;
    while(fk >= f0)
        alpha = alpha*2;
        x = x0;
        method_boot(x0,f_eval, g_eval, Hess_opt,opts);
        for i =1:num_repeats
            s = randsample(opts.numdata ,opts.S);
            g0 = g_eval(x0,s);
            DATA.grad=g0; DATA.grad_sample = s;
            d = descent_method(x, g_eval, Hess_opt ,1, opts);
            x = x+(beta/(1+(i-1)*alpha))*d;
        end
        fk = f_eval(x,1:opts.numdata);
    end
    if(alpha>alpha_max)
        alpha_max=alpha;
    end
end
% Boot things again
method_boot(x0,f_eval, g_eval, Hess_opt,opts);
opts.beta= beta*safety_margin;
opts.alpha= alpha_max/safety_margin;
fprintf('\n(beta,alpha) = (%f, %f)\n', opts.beta,opts.alpha );
end
