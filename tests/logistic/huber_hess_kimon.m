function H = huber_hess_kimon(x,mu)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% y = sign(x).*min(abs(x),1);
% D  = 1./sqrt(mu^2 + x.^2);
% Dx = D.*x;
% H  = D.*(1 - Dx.*y);

H  = (mu^2)./sqrt(mu^2 + x.^2).^(3);


end

