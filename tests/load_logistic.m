function [opts,f_eval,g_eval,Hess_opt ] =  load_logistic(problem,datapath,tol,opts)
% Load logistic regression problem
try
    opts.problem_title = ['logistic_' opts.regularizor '_'  opts.LIBSVMdata ];
    datafile = [datapath '/' opts.LIBSVMdata];
    [y, X] = libsvmread(datafile);
%     X = [ones(size(X,1),1) X];
    sX = size(X);
    opts.n = sX(2);
    opts.numdata = sX(1);
    opts.x0  = zeros(opts.n,1);
    opts.tol = tol;
    opts.X = X;
    opts.Xt= X';
    if(sum(y==1)+sum(y==0) == length(y))
        y = y.*2 -1 ;
    elseif(sum(y==1) +sum(y==2) == length(y))
        y = y.*2 -3 ;
    end
    if(sum(y==1) +sum(y==-1) ~= length(y))
       display('FAILED TO TRANSFORM y into -1 and 1, ABORT!!!!!');
       return;
    end
    opts.y = y;
catch loaderr
    display(loaderr.message);display(' FAILED to load logisitc function');
    f_eval =[];  g_eval =[]; Hess_opt =[];
    return
end
display(['loaded ' opts.problem_title ' with ' num2str(opts.n) ' features and ' num2str(opts.numdata) ' data' ]);
M= opts.numdata;
if(strcmp(opts.regulatrizor_parameter,'1/num_data'))
    reg = 1/M;
elseif(strcmp(opts.regulatrizor_parameter,'normalized'))
    weight =0;
    for i = 1: sX(1)
        weight = weight + norm(X(i,:));
    end
    reg = 1/weight;
else
    reg = opts.regulatrizor_parameter;
end
switch opts.regularizor
    case 'huber'
        f_eval =  @(x,S)((1./length(S))*logistic_eval(opts.Xt,y,x,S)+(reg)* huber_eval(x,opts.hubermu));
        g_eval =  @(x,S)((1./length(S))*logistic_grad_sub(opts.Xt,y,x,S)+(reg)*huber_grad(x,opts.hubermu));
        Hess_opt =  @(x,S,v)((1./length(S))*logistic_hessv_sub(opts.Xt,y,x,S,v)+ (reg)*bsxfun(@times, huber_hess_kimon(x,opts.hubermu), v) ); %huber_hess_kimon(x,opts.hubermu).*v))
    case 'L2' % is the default
        f_eval =  @(x,S)((1./length(S))*logistic_eval(opts.Xt,y,x,S)+(reg)*(0.5)* norm(x)^2);
        g_eval =  @(x,S)((1./length(S))*logistic_grad_sub(opts.Xt,y,x,S)+(reg).*x);
        Hess_opt =  @(x,S,v)((1./length(S))*logistic_hessv_sub(opts.Xt,y,x,S,v)+ (reg).*v);
    otherwise
        display('Choose regularizor huber or L2');
        error(['Unknown regularizor ' opts.regularizor  ]);
end
end
