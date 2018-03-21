% Full memory Block BFGS method in a factored form with self-conditioning
function d = descentFBBFGS(x, g_eval, Hess_opt ,iteration, opts)
DATA = evalin('caller', 'DATA');
%% Updates for the inverse
n = length(x);
% Selecting type of sample matrix
if(strcmp(opts.update_sample_matrix, 'gauss'))
    % Gaussian sample action
    D = randn(n,opts.update_size);
    S = DATA.L*D;
else
    % Sample a random subset of the columns of L
    s = randsample(n ,opts.update_size);
    S= DATA.L(:,s);
end
HeS = Hess_opt(x,DATA.grad_sample,S);
% Update metric
if(strcmp(opts.update_sample_matrix, 'gauss'))
    DATA.L= chol_quNac_L_sample(D,S,HeS,DATA.L);
else
    % Testing
%     D = imerse_matrix(n,s);
%     DATA.L= chol_quNac_L_sample(D,S,HeS,DATA.L);
    DATA.L= chol_quNac_L_cols(s,HeS,DATA.L);
end
%% Cleaning house
d = -DATA.L*(DATA.L'*DATA.grad);
assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);
end