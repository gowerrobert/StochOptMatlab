clear all
problem = 'covtype';  %, url_combined, liver-disorders  a9a  w8a  covtype.libsvm.binary   gisette_scale   SUSY  news20.binary     HIGGS   real-sim epsilon_normalized     rcv1_train.binary       
%% Load Logistic parameters
opts.grad_type = 'SVRG';         % SVRG  SGD
opts.max_iterations = 10^10;
opts.regularizor ='L2';  % huber or L2
opts.hubermu = 1.0e-4;
opts.regulatrizor_parameter = '1/num_data';    % '1/num_data' or 1   10^(-6);
opts.LIBSVMdata = problem;
% Stochastic subsampling of gradients and Hessian-vector products 
%% Load problem
% datapath = '/home/s1065527/Software/Matlab/libsvm/data'; 
% datapath = '/home/gowerrobert/Dropbox/Software/LIBSVM';
datapath = '../data'; 
tol =0;
 [opts,f_eval,g_eval,Hess_opt ] =  load_logistic('logistic',datapath,tol,opts);
%%
n = length(opts.x0);                    
M_big = ceil(sqrt(n));                 % Memory size
M_med = ceil(n^(1/3)); 
M_small = ceil(n^(1/4)); 
M_very_small = ceil(n^(1/5)); 
M = M_med;
S_small = ceil((opts.numdata)^(1/4)); 
S_med = ceil((opts.numdata)^(1/3)); 
S_big = ceil((opts.numdata)^(1/2)); 
opts.S = S_big;        % Sub sampling size.
opts.update_size =M;                   % number of columns in update matrix (update rank = 2*update_size)
opts.memory=2*M;                  % Maximum amount of memory stored for Limited memory techiniques
opts.plotting= 1;                           % 1 - record information for plotting, 0 - otherwise
opts.block_size = M;                         % Block size of updates
opts.prnt= 1;                               % 1 - print outer iterations, 0 - otherwise
opts.Timeout =2;                          % permitted time in seconds
opts.metric_reset_method ='descent-angle';  % type of metric reseting criteria: always %descent-angle % never
%% 
OUTPUTS ={}; 
load_problem_parameters;   %covtype    , gisette_scale , a9a, SUSY, real_sim, rcv1_train, HIGGS, news20_binary
opts.Timeout =200;  
all_methods_limited; prefix ='fval_prev';
%all_zeromem_methods; prefix ='zero';
% all_methods_full; prefix ='full-limited';
%% plot all error X time of each object in OUTPUTS
%  Naming, saving and plotting
Prob.title =[ prefix '_' problem '_' opts.regularizor '_(n,d)=(' num2str(OUTPUTS{1}.opts.numdata) ','   num2str(OUTPUTS{1}.opts.n) ')_S=' num2str(opts.S) '_m_M_' num2str(floor(opts.numdata/opts.S)) '_' num2str(M)];
plotdata = extract_plot_data(OUTPUTS,Prob,'datapasses');
% opts.timetrim =400;
prettyPlot_plotdata(plotdata,opts);
