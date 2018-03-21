function out = logistic_phi(t)

idx = t > 0;
out = zeros(size(t));
out(idx) = (1 + exp(-t(idx))).^(-1);
exp_t = exp(t(~idx));
out(~idx) = exp_t ./ (1. + exp_t);


% out2 = (1 + exp(-t));


% lt= length(t);
% out2 = zeros(size(t));
% for i=1:lt
%    if(t(i)<=0)
%       expti =  exp(t(i));
%       out2(i)= expti/(1+expti);
%    else
%        out2(i)= 1/(1+exp(-t(i)));
%    end   
% end

end