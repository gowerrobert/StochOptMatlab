% function DATA   = step_SGD(x,opts)
DATA.grad_sample = randsample(opts.numdata ,opts.S);
DATA.grad  = g_eval(x,DATA.grad_sample );
%totalpass= opts.datapasses(end);
DATA.datapasses(end+1) = DATA.datapasses(end)+(opts.S)/opts.numdata;
% DATA.datapasses(end+1) = DATA.datapasses(end)+ DATA.datapass+(opts.S)/opts.numdata;
% end