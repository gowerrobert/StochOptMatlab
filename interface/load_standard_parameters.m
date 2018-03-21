opts.PCG.memory_limit =20;                  % Maximum amount of memory stored for Limited memory techiniques
opts.PCG.update_size =20;                   % number of columns in update matrix (update rank = 2*update_size)
opts.PCG.maxit = opts.PCG.memory_limit ;    % Maximum number of PCG iterations
opts.PCG.tol = 'super-linear';              % PCG tolerance 'super-linear',  'quadratic';  0.01;
opts.PCG.prnt = 0;                          % 1 - print inner PCG iterations, 0 - otherwise 
opts.plotting= 1;                           % 1 - record information for plotting, 0 - otherwise
opts.prnt= 1;                               % 1 - print outer iterations, 0 - otherwise  
opts.Timeout = 10*60;                        % permitted time in seconds                          
opts.line_search ='armijo';                 % type of linesearch where optiones are: armijo, exact, none, backtrack, strongwolfe
opts.H0_method = 'projected gradient';      % type of H0 metric huber_inverse % 'identity' % 'projected gradient'
opts.H0_opt_method = 'projected gradient';  % limited memory type of H0 metric 'projected gradient' %'huber_inverse' % identity
opts.metric_reset_method ='descent-angle';  % type of metric reseting criteria: always %descent-angle % never
opts.step_method = 'Newton-CG';             % type of descent directions: 'metric-grad' %'Newton-CG'
opts.QuNic_type = 'inverse';                % type of metric matrix 'inverse' %'direct'
OUTPUTS ={};
