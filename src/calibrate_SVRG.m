function opts  = calibrate_SVRG(x0,f_eval, g_eval, Hess_opt,opts,method_boot, descent_method)
% Calibrate the step size   beta/(1+alpha t)
safety_margin =0.1;
% num_repeats =20;
num_steps_forward = 30;
beta =10^(-1);
factor = 0.5;
f0 = f_eval(x0,1:opts.numdata);
ff = 2*f0;
display('Calibrating step_size')
while (ff>= f0)
    fprintf('Testing Beta = %f\n',beta);
    x = x0;
    method_boot(x0,f_eval, g_eval, Hess_opt,opts);
    DATA.datapasses =0;
    for iteration =1:num_steps_forward
        step_SVRG;
        d = descent_method(x0, g_eval, Hess_opt ,1, opts);
        x = x +beta*d;
    end
    ff= f_eval(x,1:opts.numdata);
    if(isnan(ff))
        beta  =beta*factor^2;
        ff = 2*f0;
    elseif (ff>= f0)
        beta  =beta*factor;
    end
end
opts.step_parameter  =beta*safety_margin;
     fprintf('Beta = %f',beta);
end