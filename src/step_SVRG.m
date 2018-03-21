% DATA.grad_sample = randsample(opts.numdata ,opts.S);
% Outer loop step
if(mod(iteration,opts.inner_iterations)==1)
    inner_counter =0;
    % sampling with replacement
    DATA.rand_samples = randsample(opts.numdata ,opts.numdata, true);
    DATA.refpoint = x;
    % Calculate full gradient
    DATA.fullgrad =  g_eval(x,1:opts.numdata);
    DATA.grad = DATA.fullgrad;
    % Calculate the data passes
    DATA.datapasses(end+1) = DATA.datapasses(end)+ 1;
    DATA.datapasses_products = DATA.datapasses_products + 1;
    if(iteration ~= 1)
        DATA.datapasses(end) = DATA.datapasses(end) + ...
            (opts.inner_iterations+1)*(DATA.datapass_additional+(opts.S)/opts.numdata) ;
        DATA.datapasses_products =DATA.datapasses_products + ...
            (opts.inner_iterations+1)*(DATA.datapass_product+(opts.S)/opts.numdata) ;
    end
% Inner loop step    
else 
    DATA.grad_sample = DATA.rand_samples(inner_counter*opts.S+1: (inner_counter+1)*opts.S);
    DATA.grad =  g_eval(x,DATA.grad_sample)  -  g_eval(DATA.refpoint,DATA.grad_sample) ...
        + DATA.fullgrad;
    inner_counter = inner_counter+1;
end