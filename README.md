## StochOptMatlab

## Introduction

This is a suite of matlab code of stochastic optimization methods for minimizing an average of functions (empirical risk minimization).

## Installation and Setup

Start Matlab and make sure that the working directory is set to the
main directory of the present package.  At the MATLAB prompt, run
```Matlab
  setuppaths
```

The script adds the appropriate directories in the MATLAB path and runs mex 
on libsvmread.c, used to load the logistic problems. 

To test if the installation and setup for the quNac have been 
completed successfully please run in the MATLAB prompt:

```Matlab
  demo
```

## Objective functions implemented

1. logisitc regression + L2 regularizor
2. logisitc regression + pseudo-huber regularizor
To add new functions see

```Matlab
tests/load_logistic.m
```

## Methods implemented

1. Limited memory stochastic block BFGS [1]
2. SQN - Stochastic quasi-Newton [2]
3. SVRG - Stochastic variance reduced gradients

## Repeat tests in paper [1]

WARNING: The following experiments are CPU and memory intensive!

To run the tests carried out in the paper [1] do the following.
First download seven LIBSVM data files using the following script

```Matlab
get_LIBSVM_data
```

NOTE:  the script 'get_LIBSVM_data' will download approx 1 GB to your local hard drive. If this script fails, please manually download all seven LIBSVM files to the folder ./tests/logistic/LIBSVM_data.

To repeat all experiments in [1],  run the commands
```Matlab
problems = {    'covtype.libsvm.binary',   'gisette_scale',  'SUSY', 'url_combined',     'HIGGS' , 'epsilon_normalized', 'rcv1_train.binary' } 
test_problems_opt_step_size(problems)
```

## References

[1]   Robert M. Gower, Donald Goldfarb and Peter Richtarik
      Stochastic Block BFGS: Squeezing More Curvature out of Data

[2]   P. Moritz, R. Nishihara, and M. I. Jordan. 
      “A linearly-convergent stochastic L-BFGS algorithm”.
      arXiv:1508.02087v1 (2015).
## TODO

1. Write code for performing grid search to determine stepsizes. The code should search to see if the combined method+problem already has a saved stepsize. If it does, load that stepsize. If it doesn't, calculate the stepsize using a grid search and save the result.


## Bugs and Comments

If you have any bug reports or comments, please feel free to email 

  Robert Gower <r.m.gower@sms.ed.ac.uk>
  Robert Gower <gowerrobert@gmail.com>

Or make a pull request!

## Historical note

This package was originally called StochBFGS and was created  for testing different version of
stochastic quasi-Newton methods. In particular, the details of on stochastic block BFGS method can be found in [1].
