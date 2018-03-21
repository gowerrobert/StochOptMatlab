function acc = test_log_model(opts, output)
opts_new = opts;
opts_new.LIBSVMdata = [opts.LIBSVMdata '.val'];
problem = 'logistic';
opts_new.X =[];

[opts_new,~,~,~ ] = load_logistic(problem,1,opts_new);
if(isempty(opts_new.X))
    opts_new.LIBSVMdata = [opts.LIBSVMdata '.t'];
    [opts_new,~,~,~ ] =load_logistic(problem,1,opts_new);
end

if(~isempty(opts_new.X))
    acc = accurary_prediction(opts_new.X,opts_new.y,output.x);
else
    acc = 0.0;
end


end