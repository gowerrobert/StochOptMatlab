function y = huber_grad(x,mu)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

y= x;
for i =1: length(x)
   y(i) =  x(i) *(mu^2 +x(i)^2)^(-1/2);
end


end

