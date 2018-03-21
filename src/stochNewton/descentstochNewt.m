function d = descentstochNewt(x, g_eval, Hess_opt ,tol, opts)
% Block Coodrinate descent with a full memory block BFGS preconditioner
% What should the Initial Hessian estimate be?
DATA = evalin('caller', 'DATA');
%% Calculating search direction
isposdef=1;
n= length(x);
d = zeros(n,1);
% Selecting type of sample matrix
if(strcmp(opts.update_sample_matrix, 'gaussian'))
    % Gaussian sample action
    S= rand(n,opts.update_size);
    D= DATA.L*S;
else
    % Sample L columns for action matrix
    r = randsample(n,opts.update_size);
    D= DATA.L(:,r);
end
s = randsample(opts.numdata ,opts.S);
Hess_optx = @(d,S)(Hess_opt(x,S,d));
HeD = Hess_optx(D,s);
g0 = g_eval(x,s);
% Solve compressed linear system
d =iter_BCD(D,HeD,-g0,d,opts);
%% Cleaning house
% n = length(d); Hf = Hess_optx(eye(n,n));
% Test metric reset
if(DATA.metric_reset_method(g0,d,10^(-6) ) || isposdef==0 ) %opts.tol
    if(opts.prnt) display('RESETING METRIC!'); end
    % reseting the preconditioner;
    DATA.L = DATA.L0;
end

% opts.beta  = 1;% lnsrch_bt( x, d, g0'*d, f0, 1/iteration, @(y,mu)(f_eval(y,s)),@(y,iter,mu)(0), [], 0 );
% opts.alpha =1;
assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);
end