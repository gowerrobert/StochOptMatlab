function metric =update_LBBFGS(metric,D,HeD, memory, update_size)
R = chol(D'*HeD); invR = inv(R);
% normalize the sample matrix and sampled action.
D = D*invR;
HeD = HeD*invR;
% test later
% D = R'\D'; D= D'; 
% HeD = R'\HeD'; HeD= HeD';
if(~isfield(metric,'Ds'))
  metric.Ds = {D};
  metric.HeDs = {HeD};
  return;
end
lB = length(metric.Ds);
if(lB*update_size >= memory)
    metric.Ds(1) =[];
    metric.HeDs(1) =[];
end

metric.Ds = [ metric.Ds D];
metric.HeDs = [ metric.HeDs HeD];

end