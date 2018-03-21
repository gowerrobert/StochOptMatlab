function d = descentLstochNewt(x, g_eval, Hess_opt ,tol, opts)
% What should the Initial Hessian estimate be?
DATA = evalin('caller', 'DATA');
%% Calculating search direction
isposdef=1;
% Preconditioner
n = length(x);
d = zeros(n,1);
d(1)=1;

% % Calculating sample size with simple interpolation
% tol = 10^(-3);
% a = tol*(opts.block_size-1)/(1-tol);
% error = (opts.normg0/norm(g0));
% bsize = ceil(a*error +(1-a));

bsize = opts.block_size;
r = randsample(n,bsize);   
R =  imerse_matrix (n,r);

if(isfield(DATA,'D') && ~isempty(DATA.D))
    % Get scaling constant from H0
    DATA.H0_optx = @(d)(DATA.H0_opt(x,g_eval,Hess_opt,d));
    d= DATA.H0_optx(d);
    alpha =d(1);
    d(1) =0;
    % alpha = 10^(-8);
    % Prepare for cholesky metric
    sqrta = sqrt(alpha);
    L =@(d)(sqrta*d);
    Linv =@(d)(inv(sqrta)*d);
    LinvT =@(d)(inv(sqrta)*d);
    try
        D= chol_quNac_apply(DATA.D,DATA.HeD,L,Linv,LinvT,R);
    catch
        D = R;
    end
    % DATA.H= quNac_update(DATA.D,DATA.HeD,DATA.H);
else
    D =R;
end

if(isfield(opts,'subsampled'))
    s = randsample(opts.numdata ,opts.S);
    Hess_optx = @(d,S)(Hess_opt(x,S,d));
    HeD = Hess_optx(D,s);
    g0 = g_eval(x,s);
else
    Hess_optx = @(d)(Hess_opt(x,d));
    HeD = Hess_optx(D);
    g0 = g_eval(x);
end
% Solve compressed linear system
d =iter_BCD(D,HeD,-g0,d,opts);
%% Cleaning house
DATA.D = D;
DATA.HeD = HeD;

assignin('caller', 'DATA', DATA);
assignin('caller', 'opts', opts);
end