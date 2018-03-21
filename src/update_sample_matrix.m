function opts = update_sample_matrix(opts,d)

switch opts.update_sample_matrix
case 'prev'
  opts = sample_search_direction(opts,d);
case 'gauss'
  opts = gaussian_search_direction(opts,d);
  % TRY SIMPLY H * Gaussian. This should precondition somehow?
%     case 'zero-one'
%         opts = 
case 'metric-action'
    % H0 needs to be invertible!
    s = randsample(length(d) ,opts.update_size);
    R = imerse_matrix (length(d),s);
    LBBFGS_apply_block(opts,R)
%     for i=1:opts.update_size
%         opts.D(:,i)= Lmetric_apply(opts,R(:,i));
%     end
    % Need to implement so that this works -->
%     opts.D= Lmetric_apply(opts,R);
case 'metric-action-gauss'
    % H0 needs to be invertible!
    R = randn(length(d), opts.update_size);
    opts.D =  LBBFGS_apply_block(opts,R);
%    sR = size(R);
%     for i=1:sR(2)
%         D(:,i)= Lmetric_apply(opts,R(:,i));
%     end
otherwise
  opts = sample_search_direction(opts,d);
end

end