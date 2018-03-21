% The block BFGS update for when the action matrix is a set of coordinates
%INPUT:
% s        A subset of {1,...,d} denoting which coordinate vectors to use
% M         Previous metric
function M= quNac_update_with_coordinates(R,AR,M)

%% Type II, direct diagonal manip
invA =  inv((R')*AR);
RinvA = R*invA;
MAR = M*(AR);
Aproj = AR*(RinvA');
r= size(Aproj,1);
Aproj(1:r+1:end) = Aproj(1:r+1:end) - 1.0;
M = M + RinvA*(R') -MAR*(RinvA')+RinvA*((MAR')*Aproj);

end
;