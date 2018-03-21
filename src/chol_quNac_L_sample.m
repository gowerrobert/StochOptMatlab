function Ln= chol_quNac_L_sample(D,S,AS,L)
% Update the Cholseky factor L to Ln of a Block BFGS update
% usin self conditioned simplification - S =LD - which results in the L^(-T) term cancellation
SAS = (S')*AS;
R = chol(inv(SAS))';
%R = inv(chol(SAS));
G=  chol(D'*D,'lower');
SR = S*R;

Ln = L +SR*(inv(G)*D'- (R'*AS')*L );

%pinvD = pinv(D);
%Ln = L +SR*(pinvD- (R'*AS')*L );
% 
% sL =size(L);
% Rs =  pick_columns (sL(1),s,R);
% Ln = L + S*(Rs- R*R'*((AS')*L));
% toc
end
