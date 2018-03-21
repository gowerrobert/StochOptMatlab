function z= LBBFGS_apply_scaled(opts,H0_optx, v)
% Expects normalized Samples, that is D = D (D^TAD)^{1/2}.
lB = length(opts.metric.Ds);
%a = zeros( opts.update_size, opts.update_size*lB);
%b =a;
if(lB==0) 
    z  = H0_optx(v);
    %opts.metric.Ds{1} * ((opts.metric.Ds{1}') *v);
    return;
end
as ={};
for i =0:lB-1
    a = (opts.metric.Ds{lB-i})'*v;
    v = v -opts.metric.HeDs{lB-i} *a;
    as= [{a} as];
    %a(:,lB-i) = (opts.metric.Ds{lB-i})'*v;
    %v = v -opts.metric.HeDs{lB-i} *a(:,lB-i);
end
% Solving R'*R*y = D'v  then z = D*y
%z  = opts.metric.Ds{1} * ((opts.metric.Ds{1}') *v);
z = H0_optx(v);
for i =1:lB
    %b(:,i) = (opts.metric.HeDs{i})' *z;
    %z = z + (opts.metric.Ds{i})*( a(:,i)- b(:,i));
    b = (opts.metric.HeDs{i})' *z;
    z = z + (opts.metric.Ds{i})*( as{i}- b);
end

end
