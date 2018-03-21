function  prettyPlot_plotdata(plotdata,options)

if(isfield(options,'timetrim'))
    minerr = inf;
    lO = length(plotdata.TIMES);
    for i =1:lO
        TIME = plotdata.TIMES{i};
        ind =  TIME<options.timetrim;
        plotdata.TIMES{i} = TIME(ind);
        plotdata.ERRORS{i} = plotdata.ERRORS{i}(ind) ; %log(plotdata.ERRORS{i}(ind) +exp(1)-1);
        minerrnow =  min(plotdata.ERRORS{i});
        if(minerrnow < minerr)
            minerr = minerrnow;
        end
        plotdata.EXTRAFIELD{i} = plotdata.EXTRAFIELD{i}(ind);
    end
elseif(isfield(options,'extrafieldtrim'))
    minerr = inf;
    lO = length(plotdata.EXTRAFIELD);
    for i =1:lO
        EXTRAFIELD = plotdata.EXTRAFIELD{i};
        ind =  EXTRAFIELD<options.extrafieldtrim;
        plotdata.EXTRAFIELD{i} = EXTRAFIELD(ind);
        minerrnow =  min(plotdata.ERRORS{i});
        if(minerrnow < minerr)
            minerr = minerrnow;
        end
        plotdata.TIMES{i} = plotdata.TIMES{i}(ind);
        plotdata.ERRORS{i} = plotdata.ERRORS{i}(ind) ;
    end
else
    minerr = 0;
end

lO = length(plotdata.ERRORS);
for i =1:lO
    plotdata.ERRORS{i} = plotdata.ERRORS{i} - minerr;
    lent(i) = length(plotdata.ERRORS{i});
end
markers={'o','+','^','*','s','d','v','+','<','>','x','h','.',...
    '^','*','o','p','+','<','h','.','>','x','s','d','v',...
    'o','p','+','*','s','d','v','+','<','>','x','h','.'};
options.markersize =8;
options.linewidth =1.5;
options.markers= markers(1:lO);
options.colors = lines(lO);
options.ylabel ='error';
options.xlimits = [0.99 inf];
markerspace = [ceil(lent/7)' ceil(rand(lO,1).*(lent./7)')];
options.markerSpacing = markerspace;
lineStyles= {':','--','-','-.', ':','--','-','-.',':','--','-','-.'};
options.lineStyles = lineStyles(1:lO);
% Naming
if(isfield(options,'timeonly') )
    plotdata.title = ['times' plotdata.title(6:end)];
end
path = [ 'figures/' plotdata.title ];
% resixe box to be fat and wide
if(~isfield(options,'timeonly'))
    if(~isfield(options,'singleplot'))
        FigHandle = figure('Position', [0, 0, 600, 300]);  %  [0, 0, 750, 300]
        subplot(1,2,1);  %set(gca, 'Position', [0 0 200 400])
    else
        options.legend = plotdata.legend;
    end
    options.xlabel = plotdata.extrafield_legend;
    prettyPlot(plotdata.EXTRAFIELD,plotdata.ERRORS, options);
    set(gca,'defaultTextFontName', 'Arial')
    xlhand = get(gca,'xlabel');  set(xlhand,'fontsize',14) ;
    xlhand = get(gca,'ylabel');  set(xlhand,'fontsize',14) ;
    ch = get(gcf,'children'); set(ch(1), 'fontsize',10);
end
%% Repeat for time
if(~isfield(options,'singleplot') || isfield(options,'timeonly'))
    if(~isfield(options,'timeonly'))
        subplot(1,2,2);        
        options= rmfield(options,'ylabel');
    end
    options= rmfield(options,'xlimits');
    options.legend = plotdata.legend;
    options.xlabel = 'time (s)';
    prettyPlot(plotdata.TIMES,plotdata.ERRORS, options);
    set(gca,'defaultTextFontName', 'Arial')
    xlhand = get(gca,'xlabel');  set(xlhand,'fontsize',14) ;
    xlhand = get(gca,'ylabel');  set(xlhand,'fontsize',14) ;
    ch = get(gcf,'children'); set(ch(1), 'fontsize',10);
    set(gca,'ytick',[])
    set(gca,'FontSize',10);
end
if (isfield(options,'singleplot'))
    figuresize(12,10,'centimeters');
    eval(['print -dpdf ' path '-single.pdf' ]);
else
    figuresize(22,10,'centimeters');
    eval(['print -dpdf ' path '.pdf' ]);
end

end