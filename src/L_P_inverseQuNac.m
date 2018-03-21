% Performs a Matrix vector product with the 
% an approximation of the inverse Hessian. It is a memoryless approximation
% made from the conjugate directions D and their product with a Hessian matrix
% He D


function Hv = L_P_inverseQuNIc(D,HeD, H0,v)
sD = size(D);
p = sD(2);
c= zeros(p,1);
Lv = zeros(p,1);
z= v;
for i =1: p
    c(i) = 1./(D(:,i)'*HeD(:,i));
    Lv(i) = (D(:,i)'* v)*c(i);
    z = z- HeD(:,i)*Lv(i);
end

% Assignment and allocation
z = H0(z);
Hv = z;
% Testing% opts.metric_type = 'BBFGS';              % AIR, BBFGS  % type of metric matrix 'inverse' %'direct'
% opts.H0 = 'SDNA' 
% outquNIC = stochastic_solve(opts.x0, f_eval, g_eval, Hess_opt, @bootvariableM_stoch, ...
%      @descentvariableM_stoch,   opts);
%  OUTPUTS = [ OUTPUTS {outquNIC}];

% Hv= H0((eye(n,n)-HeD*(D'*HeD)^(-1)*D')*v);
for i =1: p
    b = c(i)*(HeD(:,i)'* z);
    Hv = Hv + D(:,i)*(Lv(i) -b);
end

% z = c(1)*D(:,1) *(HeD(:,1)'* Hv);
% for i =2: p
%     z = z+c(i)*D(:,i) *(HeD(:,i)'* Hv);
% end
% Hv = Hv-z;
% % Testing
% % Hvt  =(((eye(n,n)-HeD*(D'*HeD)^(-1)*D'))')*H0((eye(n,n)-HeD*(D'*HeD)^(-1)*D')*v);
% for i =1: p
%     Hv = Hv + D(:,i) *Lv(i);
% end

% Hvt +  (D*(D'*HeD)^(-1)*D')*v
end