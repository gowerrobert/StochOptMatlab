%% Testing cost of Hessian vector product X subsampling size

i=1;
time_hv =0;
for S = 1:opts.numdata/10:opts.numdata
x=    rand(opts.n,1);
v = rand(opts.n,1);
s = randsample(opts.numdata ,S);
tic
Hess_opt(x,s,v);
time_hv(i) =toc;
i=i+1;
end
plot(1:opts.numdata/10:opts.numdata, time_hv )
%% Testing time as increase H-block product
time_hvq=0;
i=1;
for q = 1:10:100
x=    rand(opts.n,1);
v = rand(opts.n,q);
s = randsample(opts.numdata ,10*ceil(sqrt(opts.numdata)));
tic
Hess_opt(x,s,v);
time_hvq(i) =toc;
i=i+1;
end
plot ( 1:10:100, time_hvq, 'red')
%% plotting




