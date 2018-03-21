n =10;
M = 5;

for i = 1:M
end
L = rand(n,n);
A = rand(n,n);
A = A'*A;
p =4;
s = randsample(n ,p);
R =  imerse_matrix (n,s);
S = L*R;
AS= A*S;
M = L*L';

%%
Mqunac = quNac_update(S,AS,M)

%%
Ln= chol_quNac_L_cols(s,AS,L);
MLcols = Ln*Ln'

%%
Ln= chol_quNac_L_sample(R,S,AS,L);
MLsample = Ln*Ln'
%%
memory = 2*n;
metric =update_LFBBFGS(metric,metric.D,HeD,R, s, memory, p);