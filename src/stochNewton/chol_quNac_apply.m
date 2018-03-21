function GD= chol_quNac_apply(S,AS,L,Linv,LinvT,D)
     
% tic;
%% Type I, Gratton,  Ilunga, Tshimanga
% Cholseky in Matlab R^TR = chol(A)
SAS = (S')*AS;
%R = chol(SAS);
invA =  inv(SAS);
Rb = chol(invA);
LD=L(D);
GD =  LD - S*invA*(AS')*LD;

% % Testing I
% sD = size(D);
% Ie= eye(sD(1));
% projA = S*invA*(AS');
% M_partial = (Ie -projA)*LD*(LD')*(Ie -projA');
%%% end testing


LinvS = Linv(S);
SMinvS = (LinvS')*LinvS;
X = chol(SMinvS);

% E = S*(inv(R))*(inv(X'))*(S')*LinvT(D);
% % Testing II
% M_partial = E*E';
% norm(M_partial- S*invA*S')

GD = GD + S*(Rb')*(inv(X'))*(S')*LinvT(D);
%GD = GD + S*(inv(R))*(inv(X'))*(S')*LinvT(D);
% toc
end
