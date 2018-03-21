function [d] = lbfgsProd(g,lmetric)
% BFGS Search Direction
%
% This function returns the (L-BFGS) approximate inverse Hessian,
% multiplied by the negative gradient

% Set up indexing
% [~,maxCorrections] = size(S);
% if lbfgs_start == 1
% 	ind = 1:lbfgs_end;
% 	nCor = lbfgs_end-lbfgs_start+1;
% else
% 	ind = [lbfgs_start:maxCorrections 1:lbfgs_end];
% 	nCor = maxCorrections;
% end

lS = length(lmetric.S);
if(lS==0) d=-g; return; end
al = zeros(lS,1);
be = zeros(lS,1);

d = -g;
for i = lS:1
	al(i) = (lmetric.S{i}'*d)/lmetric.YS{i};
	d = d-al(i)*lmetric.Y{i};
end

% Multiply by Initial Hessian
d = lmetric.H0_optx(d);

for i = 1:lS
	be(i) = (lmetric.Y{i}'*d)/lmetric.YS{i};
	d = d + lmetric.S{i}*(al(i)-be(i));
end
