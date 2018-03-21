function  test_problems_opt_step_size(problems)
% test_problems_opt_step_size expects there to be a script called [problem]_[regularizor]_step_parameter
% where the problem name has all dot, comma and unusual symbols replaced by
% underscore, that is problem(ismember(problem,',.:;!/\')) = '_';
%% Example input
% problems = {    'covtype.libsvm.binary',   'gisette_scale',  'SUSY', 'url_combined',     'HIGGS' , 'epsilon_normalized', 'rcv1_train.binary' }  
%%  Other examples: 'w8a', 'news20.binary'
%% Load Logistic parameters
opts.grad_type = 'SVRG';         % SVRG  SGD
opts.max_iterations = 10^10;
opts.regularizor ='L2';  % huber or L2
opts.hubermu = 1.0e-4;
opts.regulatrizor_parameter = '1/num_data';    % '1/num_data' or 1   10^(-6);
% Stochastic subsampling of gradients and Hessian-vector products
%% Load problem
% datapath = '/home/s1065527/Software/Matlab/libsvm/data';
% datapath = '/home/gowerrobert/Dropbox/Software/LIBSVM';
for i = 1:length(problems)
    problem = problems{i};
    opts.LIBSVMdata = problem;
    datapath = '../data';
    tol =0;
    [opts,f_eval,g_eval,Hess_opt ] =  load_logistic('logistic',datapath,tol,opts);
    %%
    n = length(opts.x0);
    M_big = ceil(sqrt(n));                 % Alternative choices of Memory size
    M_med = ceil(n^(1/3));
    M_small = ceil(n^(1/4));
    M_very_small = ceil(n^(1/5));
    M = M_med;
    opts.S =  ceil((opts.numdata)^(1/2));       % Sub sampling size.
    opts.totalpasses = 30;
    opts.update_size =M;                   % number of columns in update matrix (update rank = 2*update_size)
    opts.memory=5*M;                  % Maximum amount of memory stored for Limited memory techiniques
    opts.plotting= 1;                           % 1 - record information for plotting, 0 - otherwise
    opts.block_size = M;                         % Block size of updates
    opts.prnt= 1;                               % 1 - print outer iterations, 0 - otherwise
    opts.metric_reset_method ='descent-angle';  % type of metric reseting criteria: always %descent-angle % never
    %%
    OUTPUTS ={};
    problem(ismember(problem,'-,.:;!/\')) = '_';
    display([ problem '_' opts.regularizor '_step_parameter'])
    eval([ problem '_' opts.regularizor '_step_parameter']);   %covtype    , gisette_scale , a9a, SUSY, real_sim, rcv1_train, HIGGS, news20_binary
    opts.Timeout = 10*60*60;                        % Increasing the timeout so the opts.totalpasses determines when the method stops
    % Test all limited memory methods
    all_methods_limited; prefix ='time_';
    %% plot all error X time of each object in OUTPUTS
    %  Naming  
    Prob.title =[ prefix '_' problem '_' opts.regularizor '_(n,d)=(' num2str(OUTPUTS{1}.opts.numdata) ','   num2str(OUTPUTS{1}.opts.n) ')_S=' num2str(opts.S) '_m_' num2str(floor(opts.numdata/opts.S)) '_ada_45_9'];
    %  Saving
    plotdata = extract_plot_data(OUTPUTS,Prob,'datapasses');
    %  Plotting
    prettyPlot_plotdata(plotdata,opts);
end
