function prettyPlot_wrapper(OUTPUTS,title)
lO = length(OUTPUTS);
ERRORS = {};
TIMES = {};
legendStr = {};
for i =1:lO
    lent(i) = length(OUTPUTS{i}.times);
    ERRORS = [ERRORS ; OUTPUTS{i}.errors];
    TIMES = [TIMES; OUTPUTS{i}.times]
    legendStr = [legendStr ; OUTPUTS{i}.name]
end
itmax = min(find(lent == max(lent(:))));
markers={'o','+','^','*','s','d','v','+','<','>','x','h','.',...
'^','*','o','p','+','<','h','.','>','x','s','d','v',...
'o','p','+','*','s','d','v','+','<','>','x','h','.'};
options.title = [ 'figures/' title ];
options.markers= markers(1:lO);
options.colors = lines(lO);
options.xlabel = 'time (s)';
options.ylabel ='|invA -H| / |invA|';
options.markerSpacing  = [ceil(lent/20)' ceil(rand(lO,1).*(lent./20)')];
options.lineStyles = {':','--','-','--','-','-'};
options.legend = legendStr;
prettyPlot(TIMES,ERRORS, options);
eval(['print -djpeg ' title '.jpg' ]);
end