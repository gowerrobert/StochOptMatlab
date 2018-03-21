%setuppaths: 
%    Adds to path the files of the current folder
%    And compiles the mex file libsvmread for use with logistic test

% Get root location of resultsSetup
root = fileparts(which(mfilename)); 

% ----------------------------------------------------------------------
% Add the appropriate subdirs to path.
% ----------------------------------------------------------------------

addpath(genpath(root));
fprintf('%s \n',root);

fprintf(['\n The above directories and their subdirectories have been'  ,...
         ' temporarily added to your path.\n']);
% -------------------------------------------------------------------------
% Compile the libsvmread.c 
% -------------------------------------------------------------------------
cd([root '/tests/logistic/LIBSVM_data/']);

try
   if exist('libsvmread','file')~=3, mex libsvmread.c; end
   fprintf('Compilation of MEX files for libsvmread was successful!\n');
catch err
    display(err);
    cd(root);
   error('Could not compile MEX files for libsvmread:');
end
cd ../../../;

clear;
