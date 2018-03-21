function metric =update_LFBBFGS(metric,D,HeD,R, c,memory, update_size)
%R = chol(D'*HeD); % invR = inv(R);
% normalize the sample matrix and sampled action.
% D = D*R;
% HeD = HeD*R;
% test later
% D = R'\D'; D= D'; 
% HeD = R'\HeD'; HeD= HeD';
if(~isfield(metric,'Ds'))
  metric.Ds = {D};
  metric.HeDs = {HeD};
  metric.Rs = {R};
  metric.cs = {c};
  return;
end
lB = length(metric.Ds);
if(lB*update_size >= memory)
    metric.Ds(1) =[];
    metric.HeDs(1) =[];
    metric.Rs(1) = [];
    metric.cs(1) = [];
end

metric.Ds = [ metric.Ds D];
metric.HeDs = [ metric.HeDs HeD];
metric.Rs = [ metric.Rs R];
metric.cs = [ metric.cs c];
end