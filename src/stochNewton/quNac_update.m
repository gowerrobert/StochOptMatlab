% quNac_update updates the Block BFGS metric matrix, that is, 
% M = arg min_M || M - M_old||_{F(A)}   subject to MAR = R,   M = M^T
% INPUT:
% R             Sample matrix d \times q 
% AR            Product of A*R
% M             Previous metric matrix
% Robert M. Gower   2015
function M= quNac_update(R,AR,M)
% tic;
%% Type I, Stable, full matrix products
% I_n= eye(size(M));
% invRAR = inv((R')*AR);
% proj = (R*invRAR*(R'));
% projA = (R*invRAR*AR');
% M = proj + (I_n -projA)*M*(I_n -projA');
%% Type II, direct diagonal manip
invA =  inv((R')*AR);
RinvA = R*invA;
MAR = M*(AR);
Aproj = AR*(RinvA');
r= size(Aproj,1);
Aproj(1:r+1:end) = Aproj(1:r+1:end) - 1.0;
M = M + RinvA*(R') -MAR*(RinvA')+RinvA*((MAR')*Aproj);
%% Type III, save on products
% AR = A*R;
% invA =  inv((R')*AR);
% invAR = invA*(R');
% MAR = M*(AR);
% MAproj = MAR*invAR;
% M = M + R*invAR- MAproj'+(((AR*invAR)'-eye(size(A)))*MAproj) ;

%% Type IV, Gram-schimdt to invA, S. Gratton?

% toc
end