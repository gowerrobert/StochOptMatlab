function Ln= chol_quNac(S,AS,L)
% Linv,LinvT,D
% Update the Cholseky factor L to Ln of a Block BFGS update
% tic;
%% Type I, Gratton,  Ilunga, Tshimanga
% Cholseky in Matlab R^TR = chol(A)

SAS = (S')*AS;
%R = chol(SAS);
invA =  inv(SAS);
R = chol(invA);
Ln =  L - (S*invA)*((AS')*L);

% % Testing I
% sD = size(D);
% Ie= eye(sD(1));
% projA = S*invA*(AS');
% M_partial = (Ie -projA)*L*(L')*(Ie -projA');
%%% end testing

LinvS = L\S; 
SMinvS = (LinvS')*LinvS;

G= chol(SMinvS);
Ln = Ln + S*(R')*(inv(G'))*LinvS';
% toc
end
