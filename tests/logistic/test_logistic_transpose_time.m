% n =10^2;
% m = 10^6;
% X = sprand(m,n,1/10);
% x = rand(n,1);
% y = rand(m,1);
% w = rand(n,1);

%% With real data 
X = opts.X;
Xt =opts.Xt;
y= opts.y;
w = rand(opts.n,1)
v =rand(opts.n,1);
%% Subsampling time
S = randsample(opts.numdata ,opts.S);

tic;
 XS = X(S,:);
 transpose_time = toc
 
 
 tic;
 XtS = Xt(:,S);
 XtSt = XtS';
new_time = toc


 
 
 


%% Hess test
% tic;
% Xx  = X*w;
% yXx = y.*Xx;
% t=logistic_phi(yXx) ;
% Hv = X'*bsxfun(@times, t.*(1-t),X*v);
% transpose_time = toc
% 
% 
% tic;
% Xx  = X*w;
% yXx = y.*Xx;
% t=logistic_phi(yXx) ;
% Hv2 = Xt*bsxfun(@times, t.*(1-t),X*v);
% new_time = toc
% 
% Herror = norm(Hv-Hv2)
% 
% %% Grad test
% tic;
% Xx  = X*w;
% yXx = y.*Xx;
% gout = (X.')*(y.*(logistic_phi(yXx) - 1));  
% transpose_time = toc
% 
% 
% tic;
% Xx  = X*w;
% yXx = y.*Xx;
% gout2 = Xt*(y.*(logistic_phi(yXx) - 1)); 
% new_time = toc
% 
% 
% graderror = norm(gout - gout2)

