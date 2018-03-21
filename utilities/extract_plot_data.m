function plotdata = extract_plot_data(OUTPUTS,Prob,extrafield)

lO = length(OUTPUTS);
ERRORS = {};
TIMES = {};
EXTRAFIELD ={};
legendStr = {};
ACC ={};
ITERATIONS = {};
for i =1:lO
    lent(i) = length(OUTPUTS{i}.times);
    iter(i) = lent(i);
   % flops = OUTPUTS{i}.flopsperiter*(1:1:lent(i)); 
    if(lent(i)>1000)
        grid =1:floor(lent(i)/1000):lent(i);
        lent(i)=length(grid);
    else
        grid = 1:1:lent(i);
    end
    ERRORS = [ERRORS ; OUTPUTS{i}.errors(grid)];
    TIMES = [TIMES; OUTPUTS{i}.times(grid)];
    EXTRAFIELD =  [EXTRAFIELD;   eval([ 'OUTPUTS{i}.' extrafield '(grid)'])];
    legendStr = [legendStr ; OUTPUTS{i}.name];
    ACC = [ACC ; OUTPUTS{i}.accuracy];
    ITERATIONS = [iter(i); ITERATIONS];
end
ITERATIONS;
ACC;
Prob.title(ismember(Prob.title,'_ ,.:;!/\')) = '-';
path = [ 'plotdata/' Prob.title ];
plotdata.title = Prob.title;
plotdata.legend = legendStr;
plotdata.TIMES = TIMES;
plotdata.EXTRAFIELD = EXTRAFIELD;
plotdata.extrafield_legend = extrafield;
plotdata.ERRORS = ERRORS;
plotdata.ACCURACY = ACC;
plotdata.ITERATIONS = ITERATIONS;
eval(['save(''' path ''',''plotdata'');' ])
end