%% correct_plot_name
path = 'plotdata';
files = dir([ path '/fval*.mat'])
%% Print all names
for i=1:length(files)
    fprintf(' %2.0d :  %s \n',i, files(i).name);
end
%% Changing sp\_Lgauss to Raco\_gauss
% oldstr = '(m-n)';
% newstr = '(n-d)';
for i=1:length(files)
    %%
    curname = files(i).name;
    pathname = [ path '/' curname ];
    eval(['load ' pathname ]);
 
    close all;
%     opts.ylimits = 'adapt';
%         opts.timetrim = 100;
    clear opts;
    %opts.singleplot = 1; opts.timeonly =1;
    opts.extrafieldtrim = 21;
    opts.logScale =2;
    prettyPlot_plotdata(plotdata,opts);
    %%
    %    eval(['save(''' pathname ''',''plotdata'');' ])
end
% for j = 1:length(plotdata.TIMES)
% TIMEs(j) = plotdata.TIMES{j}(end);
% end
% fprintf([curname(1:15) ' min time ' num2str(min(TIMEs)) ' \n '])

%% Remove a plot
% ind = 3;
% plotdata.legend(ind) =[];
% plotdata.TIMES(ind) = [];
% plotdata.ERRORS(ind) = [];
% plotdata.EXTRAFIELD(ind) = [];

   % get last error
    %     lasterror = plotdata.ERRORS{1}(end);
    %     opts.yshifted= lasterror;
    %     pathname = [ path '/' curname ];
    %     eval(['load ' pathname ]);
    
%     if(length(plotdata.legend)==6)
%         ind_remove =3;
%         plotdata.legend(ind_remove) = [];
%         plotdata.TIMES(ind_remove) = [];
%         plotdata.ERRORS(ind_remove) = [];
%         plotdata.EXTRAFIELD(ind_remove) = [];
%     end
    %
    %     str = plotdata.legend{1};
    %     str(1:10) = [];
    %     plotdata.legend{1} = ['MLgauss' str]
    %
    %      str = plotdata.legend{3};
    %     str(1:6) = [];
    %      plotdata.legend{3} = [ 'f' str(4:end)]
    %
    %     str = plotdata.legend{3};
    %     str(1:4) = [];
    %     plotdata.legend{3} = ['MLfact' str]
    %     pos = strfind( plotdata.title, oldstr  );
    %     if(~isempty(pos))
    %         plotdata.title(pos:pos+length(oldstr)-1) = newstr;
    %     end
    %     pos = strfind( plotdata.title, '|S|'  );
    %     if(~isempty(pos))
    %         plotdata.title(pos+1:pos+2) = [];
    %         plotdata.title(pos) ='S';
    %     end
