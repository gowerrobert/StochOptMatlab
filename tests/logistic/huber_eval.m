function f = huber_eval(x,mu)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% f =0;
% for i =1: length(x)
%   f =  f+(mu^2 +x(i)^2)^(1/2)-mu;
% end


f = sum(sqrt(mu^2 + x.^2) - mu);

end

