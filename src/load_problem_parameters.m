%% load problem specifc parameters 
problem(ismember(problem,'-,.:;!/\')) = '_';
[ problem '_' opts.regularizor '_step_parameter']
eval([ problem '_' opts.regularizor '_step_parameter']);