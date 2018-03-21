function [X,y] = subsample(X,y,S)

if(~isempty(S))
    s = randsample(length(y),S);
    X = X(s,:);
    y =y(s,:);
end

end