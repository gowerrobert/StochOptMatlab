function  table_output_times(OUTPUTS,options)

sO = size(OUTPUTS);
lO = sO(2);
l1 = sO(1);

if(strcmp(OUTPUTS{1,1}.opts.problem, 'logistic'))
    titles = {'problem'	,'line search',	'# features', '# data', 'descent'	, 'memory/imagedim' };
else
    titles = {'problem'	,'line search',	'dimension',	'descent'	, 'memory/imagedim' };
end

for i =1:lO
    titles{end+1} =  OUTPUTS{1,i}.name;
end
datacsv = titles;
display(titles);
for j =1:l1
    data_cells{1} = OUTPUTS{j,1}.opts.problem_title;
    data_cells{end+1} = OUTPUTS{j,1}.opts.line_search;
    data_cells{end+1} = num2str(length(OUTPUTS{j,1}.opts.x0));
    if(strcmp(OUTPUTS{1,1}.opts.problem, 'logistic'))
        data_cells{end+1} = num2str(OUTPUTS{j,1}.opts.numdata);
    end
    data_cells{end+1} = OUTPUTS{j,1}.opts.step_method;
    if(isfield(OUTPUTS{j,1},'memory_limit') )
       data_cells{end+1} = OUTPUTS{j,1}.memory_limit;
    else
       data_cells{end+1} = 0;
    end
    % printing out titles
    for i =1:lO
        %   titles{end+1} =  OUTPUTS{j,i}.name;
        if(strcmpi(OUTPUTS{j,i}.stopping_flag, 'conv.' ))
            if(strcmp(OUTPUTS{j,i}.opts.problem, 'logistic'))
                acc =  OUTPUTS{j,i}.accuracy;
                data_cells{end+1} = [num2str(OUTPUTS{j,i}.cput) '/' num2str(acc) '/'  num2str(OUTPUTS{j,i}.error) ];
            else
                data_cells{end+1} = OUTPUTS{j,i}.cput;
            end
        else
            if(strcmp(OUTPUTS{j,i}.opts.problem, 'logistic'))
                acc = OUTPUTS{j,i}.accuracy;
                data_cells{end+1} = [num2str(OUTPUTS{j,i}.cput) '/' num2str(acc) '/'  num2str(OUTPUTS{j,i}.error) ];
            else
                data_cells{end+1} = [num2str(OUTPUTS{j,i}.cput) '/' OUTPUTS{j,i}.stopping_flag];
            end
        end
    end
    %  datacsv = titles;
    datacsv = [datacsv ; data_cells];
    %  data_cells
    data_cells = {};
end
header = [options.title '_header'];
struct2csv(OUTPUTS{1,1}.opts,[header '.csv' ])
cell2csv([ options.title '.csv'], datacsv)
end