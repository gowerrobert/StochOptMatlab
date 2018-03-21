function d = descentvariableM_stoch(x, g_eval, Hess_opt ,iteration, opts)
% Full memory stochastic Variable Metric Methods
DATA = evalin('caller', 'DATA');
%% Updates for the inverse
n = length(x);
% Updating metric. 
if(strcmp(opts.update_sample_matrix, 'gauss'))
    % Gaussian sample action
    D = randn(n,opts.update_size);
else
    % Need to write special Hess_opt for D coordinate vectors
    %M= quNac_update_with_coordinates(R,AR,M)
    c = randsample(n ,opts.update_size);
%     D = imerse_matrix(n ,m);
    D =  imerse_matrix_sparse(n,c);
end
HeD = Hess_opt(x,DATA.grad_sample,D);
DATA.H = update_metric(DATA.H,D,HeD,opts.metric_type);
%% Cleaning house
d = -(DATA.H)*DATA.grad;
% Test metric reset
% sufficient_descent_angle(-DATA.grad,d)
if(sufficient_descent_angle(-DATA.grad,d) < 0.05)
%     if(opts.prnt) 
         display('RESETING METRIC!');
%     end
%     % reseting the metric;
     DATA.H = DATA.H0;
%    % using the H0gradient instead
     d = -DATA.H0*DATA.grad;
 end
% opts.beta = 10^(-3);
% opts.alpha = 1;
assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);
end