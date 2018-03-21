function gout = logistic_grad_sub(X,y,w,S)
 %X = X(S,:);
 X = X(:,S);
%  X= X';
y = y(S);
gout = logistic_grad(X,y,w);
end