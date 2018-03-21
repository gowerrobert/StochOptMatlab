function E = inverseQuNac_scaled(D,HeD, H0)
% projDHe = WeightedOuterProducts(D,D,D,HeD); %(Dl,Dr,D,W)
% % Right a function for left and right project
% H0HeprojDHe = WeightedOuterProducts(H0*HeD,D,D,HeD); %(Dl,Dr,D,W)
% %HeprojDHe =Hess_opt(projDHe);
% 
% %Hinv = (Hess_opt(eye(n)))^(-1);
% %Hinv*D
% projDHeH0HeprojDHe = WeightedOuterProducts(D,(H0HeprojDHe')*HeD,D,HeD); %(Dl,Dr,D,W)
% 
% %E= projDHe - H0*HeprojDHe -(HeprojDHe')*H0 + (HeprojDHe')*H0*(HeprojDHe); 
% E1 = projDHe -H0HeprojDHe-H0HeprojDHe';
% E1 = E1+ projDHeH0HeprojDHe;
sD = size(D);
Ip = eye(sD(2),sD(2));
H0HeD = H0*HeD;
H0HeprojDHe = H0HeD*(D');
E = -H0HeprojDHe-H0HeprojDHe'+ D*( ((HeD')*(H0HeD)) +Ip)*(D'); %+ D*((HeD')*H0HeprojDHe);
end