if(~isfield(opts,'inner_iterations'))
    opts.inner_iterations = floor(opts.numdata/opts.S); % length(x0);
end
% if(~isfield(opts,'step_parameter'))
%     opts =calibrate_SVRG(x0,f_eval, g_eval, Hess_opt,opts,boot_method, descent_method);
% end
% boot a first batch sample
DATA.grad_sample = randsample(opts.numdata ,opts.S);