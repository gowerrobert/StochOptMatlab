%% Gets the matrix of cosines of the vectors in V
% V  -  a column concatenation of vectors

function [cosines_out] = cosines(V)
sV = size(V);
cosines_out = zeros(sV(2));
Vprod = V'*V;
cosines_out = inv(diag(sqrt(diag(Vprod))))*Vprod*inv(diag(sqrt(diag(Vprod))));
%  for i = 1: sV(2)
%      for j = 1:sV(2)
%          cosines_out(i,j) =  Vprod(i,j)/sqrt(Vprod(i,i)*Vprod(j,j));  %V(:,i)'*V(:,j)
%      end
%  end

end