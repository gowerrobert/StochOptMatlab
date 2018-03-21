function Ln= chol_quNac_L_cols(s,AS,L)
% Update the Cholseky factor L to Ln of a Block BFGS update
% usin self conditioned simplification - S =LD - which results in the L^(-T) term cancellation
% with D = I_{:C} a subset of the columns of Identity. 
S= L(:,s);
SAS = (S')*AS;

% R = chol(inv(SAS))';
R  =  inv(chol(SAS));

%sL =size(L);
%Rs =  pick_columns (sL(1),s,R);
T = - R*R'*((AS')*L);
for i =1:length(s)
   T(:,s(i)) =R(:,i)+T(:,s(i)) ;
end
Ln = L + S*T;
%(Rs- R*R'*((AS')*L));
% toc
end
