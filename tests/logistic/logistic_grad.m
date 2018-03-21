function gout = logistic_grad(X,y,w)
Xx  = X'*w;
yXx = y.*Xx;

gout = X*(y.*(logistic_phi(yXx) - 1));  
   
end