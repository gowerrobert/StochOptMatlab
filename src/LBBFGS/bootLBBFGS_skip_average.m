function bootLBBFGS_skip_average(x0, f_eval,g_eval, Hess_opt,opts)

DATA = [];
n = length(x0);
%opts.skip_size = opts.update_size;
DATA.xmean = 0;
DATA.directions_kept =0;
DATA.activate_metric =0;
opts.bucket = [];

opts.bucket.curvtest_upper_tolerance = 0.9;
opts.bucket.curvtest_lower_tolerance = 0.45;
%% setting up permissible bucketsize and numbucket pairs
% starting from smallest buckets to largest buckets
opts.bucket.maxsize = min(ceil(sqrt(opts.n)), 30);
opts.memory = 5*opts.bucket.maxsize;
dvs = divisor(opts.bucket.maxsize);
% setup all possible pairs of (bucket.size, bucket.num) Excluding the size 1 bucket, as computing similarity between averaged directions is then  impossible
flipdvs =    fliplr(dvs);
opts.bucket.pairs = [ dvs(1:end-1) ; flipdvs(1:end-1) ];
midp = ceil((length(flipdvs)-1)/2);
opts.bucket.num = opts.bucket.pairs(2,midp);
opts.bucket.size = opts.bucket.pairs(1,midp);
opts.bucket.currentpair = midp;
%% number of steps skiped without an update
skip =  opts.bucket.num*opts.bucket.size;
% opts.bH = opts.S;
if(~isfield(opts,'bH'))
    if(opts.bucket.size>1)
        opts.bH = floor(max(min((skip*opts.S)/2,(opts.numdata)^(2/3))/(opts.bucket.size-1), opts.S));
    else
        opts.bH = floor(min((skip*opts.S)/2,(opts.numdata)^(2/3)));
    end
end

if(isfield(opts, 'name'))
    DATA.name = opts.name;
else
    DATA.name= [  'adapt\_' num2str(opts.bucket.size) 'X' num2str(opts.bucket.num)  '\_M\_' num2str(opts.memory) ];
end
opts.metric =[];
DATA.prev_directions =[];
% opts.metric_update_direction = @(opts_,d_)metric_update_direction(opts_,d_);
DATA.datapass_additional = opts.bH/(opts.numdata*skip);  %(max(opts.bH/opts.L - opts.S,0))/opts.numdata;
DATA.datapass_product = (opts.bH/skip)/opts.numdata;
%DATA.datapass_product = opts.update_size*(opts.S)/opts.numdata;
%
assignin('caller', 'x0', x0);
assignin('caller', 'opts', opts);
assignin('caller', 'DATA', DATA);


end
