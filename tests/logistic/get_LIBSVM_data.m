cd tests/logistic/LIBSVM_data/
files = {   'gisette_scale',  'SUSY', 'url_combined',     'HIGGS' , 'epsilon_normalized', 'rcv1_train.binary' }
%  files = {'gisette_scale', 'covtype.libsvm.binary' };
%% Download and decompress the binary problems
for jj = 1: length(files)
    system(['wget http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/' files{jj}  '.bz2'])
    system(['bzip2 -d '  files{jj}  '.bz2'])
end
cd ../../..;
