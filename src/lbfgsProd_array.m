% LBFGS for arrays 
function Hv = lbfgsProd_array(D,HeD, H0,v)
sD = size(D);
p = sD(2);
c= zeros(p,1);
Lv = zeros(p,1);
z= v;
for i =1: p
    c(i) = 1./(D(:,i)'*HeD(:,i));
    % the difference between LquNac v <--z
    Lv(i) = (D(:,i)'* z)*c(i);
    z = z- HeD(:,i)*Lv(i);
end

% Assignment and allocation
z = H0(z);
Hv = z;

for i =1: p
     % the difference between LquNac   Hv <--z 
    b = c(i)*(HeD(:,i)'* Hv);
    Hv = Hv + D(:,i)*(Lv(i) -b);
end

end