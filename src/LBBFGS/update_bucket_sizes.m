function  opts = update_bucket_sizes(opts, testout)

if(isfield(testout,'increase_bucket_size'))
    % increase bucketsize if possible
    if(opts.bucket.currentpair < length(opts.bucket.pairs))
        opts.bucket.currentpair = opts.bucket.currentpair+1;
        display('increased bucket size');
    end
elseif(isfield(testout,'decrease_bucket_size'))
    if(opts.bucket.currentpair > 1)
        opts.bucket.currentpair = opts.bucket.currentpair-1;
        display('decreased bucket size');
    end
end

curpair = opts.bucket.pairs(:,opts.bucket.currentpair);
opts.bucket.size = curpair(1);
opts.bucket.num = curpair(2);
 fprintf('bucketsize = %d, num of buckets = %d \n',opts.bucket.size, opts.bucket.num );
end