function Hv = logistic_hessv(X,y,w,v)
% Hessian of pseudo-Huber function. 
% remember! y_i^2 =1, and that is why y_i^2 terms do not appear.
Xx  = X'*w;
yXx = y.*Xx;
t=logistic_phi(yXx) ;
%Xy = diag(t.*(1-t))*X;
%Hv = X'*(t.*(1-t).*(X*v));
%Hv = X'*bsxfun(@times, (y.^2).*t.*(1-t),X*v);
Hv = X*bsxfun(@times, t.*(1-t),X'*v);
end