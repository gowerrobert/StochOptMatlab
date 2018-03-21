function X= LFBBFGS_apply(opts,metric, U)
% Calculates the action of L_k(U) where L_k is a factored form of 
% a block BFGS update, where all the previous sampling matrices are formed 
%of columns of previous factored forms (self-conditioning).
%This routine requires
%   metric.Ds       =   A cell array of sampling matrices 
%   metric.HeDs     =   A cell array of sampled Hessian actions
%   metric.Rs       =   A cell array of Cholseky factors   metric.Rs{i}'*metric.Rs{i} = metric.Ds{i}'*metric.HeDs{i}
%   metric.cs       =   A cell array of coordinates of previous columns of
%   factored matrices L_i  used as sample matrices, that is L_i(:,c(i)) =
%   D(i)
%   U = eye(length(U));

lB = length(metric.Ds);
X= L0_apply(opts,U);
% H0_apply(opts,v);
%% Straightforward implementation
% % X = X - D_i (Lambda_i)^{-1} Y_i^TX + D_i R_i U_{C_i}
% for i =1:lB
%     Lambda = (metric.Ds{i})'*metric.HeDs{i};
%     Z= Lambda\((metric.HeDs{i})'*X);
%     %barR = chol(inv(Lambda));
%     barR = inv(chol(Lambda));
%     W = barR*U(metric.cs{i},:);
%     X = X +metric.Ds{i} *(W-Z);
% end
% inv(chol(Lambda)) Not equal to  chol(inv(Lambda))' 
%% Efficient implementation
for i =1:lB
      Z = metric.Rs{i}'\((metric.HeDs{i})'*X);
      W = (metric.Rs{i})\Z;
      Z = (metric.Rs{i})\U(opts.metric.cs{i},:);   
      X = X+ opts.metric.Ds{i}*(Z-W);
end

%% Full implementation L
% c= L0_apply(opts,1);
% L = c*eye(length(U));
% for i =1:lB
%    % Dpre= imerse_matrix(opts.n, metric.cs{i});
%    % L= chol_quNac_L_sample(Dpre,metric.Ds{i},metric.HeDs{i},L) ;%   chol_quNac_L_cols(metric.cs{i},metric.HeDs{i},DATA.L);
%     L= chol_quNac_L_cols(metric.cs{i},metric.HeDs{i},L);
% end
% LU = L*U;
% norm(LU -X)/norm(LU)
% 
% %% Full implementation L
% % The factorization is not unique, due to non-unique factorizations of the
% % componets. The Real test is then
% c= L0_apply(opts,1);
% H = c^2*eye(length(U));
% for i =1:lB
%     H=  quNac_update(metric.Ds{i},metric.HeDs{i}, H); 
% end
%norm(X*X' -U'*H*U, 'fro')/norm(U'*H*U, 'fro')
% norm(L*L' -H, 'fro')/norm(H, 'fro')
end