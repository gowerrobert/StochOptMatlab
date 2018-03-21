function Hv = logistic_hessv_sub(X,y,w,S,v)
% Hessian of pseudo-Huber function. 
% remember! y_i^2 =1, and that is why y_i^2 terms do not appear.
 %X = X(S,:);
 X = X(:,S);
%  X= X';
y = y(S);
Hv = logistic_hessv(X,y,w,v);
end