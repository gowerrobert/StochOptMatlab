function z= LBBFGS_apply_cells(opts, v)
% LBBFGS_apply: applies the Block BFGS operator with limited memory
% this implementation uses stored cholesky factoe R =chol(D^T HeD) so that we solve small
% triangular systems
lB = length(opts.metric.Ds);
a = cell(lB);
b =a;
for i =0:lB-1 
   % R'*R*a(:,lB-i) = (opts.metric.Ds{lB-i})'*v;
    y= (opts.metric.Rs{lB-i})'\((opts.metric.Ds{lB-i})'*v);
    a{lB-i} = opts.metric.Rs{lB-i}\y;
    v = v -opts.metric.HeDs{lB-i} *a{lB-i};
end
z = H0_apply(opts,v);
for i =1:lB
    % R'*R*b(:,i) =(opts.metric.HeDs{i})'*z)
    y= opts.metric.Rs{i}'\((opts.metric.HeDs{i})'*z);
    b{i} = opts.metric.Rs{i}\y;  
    z = z + (opts.metric.Ds{i})*( a{i}- b{i});
end

end
