function z= LBBFGS_apply_block(opts, v)
% LBBFGS_apply: applies the Block BFGS operator with limited memory
% this implementation uses stored cholesky factoe R =chol(D^T HeD) so that we solve small
% triangular systems
sv =size(v);
lB = length(opts.metric.Ds);
a = zeros( sv(2)*opts.update_size, lB);
b =a;
for i =0:lB-1
   % R'*R*a(:,lB-i) = (opts.metric.Ds{lB-i})'*v;
    y= (opts.metric.Rs{lB-i})'\((opts.metric.Ds{lB-i})'*v);
    a(:,lB-i) = reshape(opts.metric.Rs{lB-i}\y, [sv(2)*opts.update_size 1] );
    v = v -opts.metric.HeDs{lB-i} *reshape(a(:,lB-i), [opts.update_size sv(2)]);
end
z = H0_apply(opts,v);
for i =1:lB
    % R'*R*b(:,i) =(opts.metric.HeDs{i})'*z)
    y= opts.metric.Rs{i}'\((opts.metric.HeDs{i})'*z);
    b(:,i) = reshape(opts.metric.Rs{i}\y, [sv(2)*opts.update_size 1] );
    z = z + (opts.metric.Ds{i})*reshape( a(:,i)- b(:,i), [opts.update_size sv(2)]);
end

end
