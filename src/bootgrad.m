function bootgrad(x0, f_eval, g_eval, Hess_opt,opts)
DATA = [];
if(strcmp(opts.grad_type,'SGD'))
    if(opts.totalpasses == opts.max_iterations)
        DATA.name = 'GD';
    else
        DATA.name = 'SGD';
    end
else
    DATA.name = 'SVRG';
end
DATA.x0 = x0;
DATA.datapass_additional = 0; % Already accounted for in execution; (opts.S)/opts.numdata;
DATA.datapass_product = 0;
assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);

end