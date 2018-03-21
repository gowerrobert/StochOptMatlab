function out = logistic_eval(X,y,w,S)
if(~isempty(S)) 
 %X = X(S,:);
 X = X(:,S);
%  X= X';
 y = y(S);
end
 out = -sum(log(logistic_phi((y).*(X'*w))));  
%  temp2= log(1 + exp(-y.*(X'*w)));
%  out - sum(temp2)
 %log(1 + exp(y.*(X'*w)))
end