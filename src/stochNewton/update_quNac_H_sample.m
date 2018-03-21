function M = update_quNac_H_sample(A,M, options)
  S = randsample(options.n,options.p);
 % Msqrt = M^(1/2); R=Msqrt(:,S);
 % Mchol = chol(M)';
 % R = Mchol(:,S);
  R = M(:,S); 
%   I = eye(size(A)); R = I(:,S);
  M= quNac_update(R,A,M);
end