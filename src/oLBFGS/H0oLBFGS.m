function [H0] = H0oLBFGS(lmetric)
lS = length(lmetric.S);
H0 =0;
for i = 1:lS
	H0 =H0+ (lmetric.Y{i}'*lmetric.S{i})/(lmetric.YS{i}'*lmetric.YS{i});
end
H0 = H0/lS;
end
