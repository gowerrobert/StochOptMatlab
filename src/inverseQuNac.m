% The inverse quasi-Newton image contraint update E 
% 
function E = inverseQuNac(D,HeD, H0)
projDHe = WeightedOuterProducts(D,D,D,HeD); %(Dl,Dr,D,W)
% Right a function for left and right project
H0HeprojDHe = WeightedOuterProducts(H0*HeD,D,D,HeD); %(Dl,Dr,D,W)
%HeprojDHe =Hess_opt(projDHe);

%Hinv = (Hess_opt(eye(n)))^(-1);
%Hinv*D
projDHeH0HeprojDHe = WeightedOuterProducts(D,(H0HeprojDHe')*HeD,D,HeD); %(Dl,Dr,D,W)

%E= projDHe - H0*HeprojDHe -(HeprojDHe')*H0 + (HeprojDHe')*H0*(HeprojDHe); 
E = projDHe -H0HeprojDHe-H0HeprojDHe';
E = E+ projDHeH0HeprojDHe;

end