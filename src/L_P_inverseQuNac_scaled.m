function Hv = L_P_inverseQuNac_scaled(D,HeD, H0,v)
Lv = D'*v;
Hv= v -HeD*Lv ;
Hv = H0(Hv);
% Testing
% Hv= H0((eye(n,n)-HeD*(D'*HeD)^(-1)*D')*v);
b = HeD'* Hv;
Hv = Hv +D*(Lv-b);
end