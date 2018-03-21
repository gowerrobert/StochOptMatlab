n =6000; p =200;
A = rand(n,n);
A= A'*A +eye(n,n);
S = rand(n,p);
AS =A*S;

M =rand(n,n); M = M'*M +eye(n,n);
L = chol(M);
%%
tic;
Mn= quNac_update(S,AS,M);
q_time = toc


Ln= chol_quNac(S,AS,L');


err= norm(Ln*Ln'-Mn,'fro')/norm(Mn,'fro')