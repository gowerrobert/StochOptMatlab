function metric =update_LBBFGS(metric,D,HeD,R, memory, update_size)
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
  return;
end
lB = length(metric.Ds);
if(lB*update_size >= memory)
    metric.Ds(1) =[];
    metric.HeDs(1) =[];
    metric.Rs(1) = [];
end

metric.Ds = [ metric.Ds D];
metric.HeDs = [ metric.HeDs HeD];
metric.Rs = [ metric.Rs R];

end