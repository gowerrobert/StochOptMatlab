function out =  test_curvature_matrix(curv, bucket)
% Examines the curvature matrix (curv = D'*HeD) to determine if we increase
% the number of buckets of increase the size of the buckets
%% calculate cosine of vectors R
normsinv = inv(diag(sqrt(diag(curv))));
cosines_curv = normsinv*curv*normsinv; %#ok<MINV>
%% sums up everything 
% criteria = (sum(sum(cosines_curv)) - length(curv))/(length(curv)^2-length(curv));
%% sums up everything in absolute value
% criteria = (sum(sum(abs(cosines_curv))) - length(curv))/(length(curv)^2-length(curv));
%% sums up upper triangle above the diagonal
 criteria = 2*sum(sum(abs(triu(cosines_curv,1))))/(length(curv)*(length(curv)-1));
 %%
fprintf('curvature criteria: %f \n',criteria);
out = struct();
if(criteria > bucket.curvtest_upper_tolerance )
    out.increase_bucket_size =1;
elseif(criteria < bucket.curvtest_lower_tolerance )
    out.decrease_bucket_size =1;
end
out.criteria = criteria;
end

%% Alternative strategies might involve the determinant 
% det(curv)