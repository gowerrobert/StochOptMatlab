## StochOptMatlab

Previously called StochBFGS (Stochastic Block BFGS) on Robert M. Gower's webpage


## Introduction

This is a suite of stochastic optimization methods for minimizing an average of functions (empirical risk minimization). This package was created for testing different version of
stochastic quasi-Newton methods. In particular, the details of on stochastic block BFGS method can be found in:

[1]   Robert M. Gower, Donald Goldfarb and Peter Richtarik
      Stochastic Block BFGS: Squeezing More Curvature out of Data, 2016.

For comparisons, this package also includes an implementation of the SVRG 
method and a stochastic L-BFGS method proposed in [2]. 



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

## Functions implemented

>logisitc regression + L2 regularizor
>logisitc regression + pseudo-huber regularizor

## Methods implemented


## Repeat tests in paper [1]

WARNING: The following experiments are CPU and memory intensive!

To run the tests carried out in the paper [1] do the following.
First download seven LIBSVM data files using the following script

  >>  get_LIBSVM_data

NOTE:  the script 'get_LIBSVM_data' will download approx 1 GB to your local hard drive. If this script fails, please manually download all seven LIBSVM files to the folder StochBFGS/tests/logistic/LIBSVM_data.

To repeat all experiments in [1],  run the commands

  >>  problems = {    'covtype.libsvm.binary',   'gisette_scale',  'SUSY', 'url_combined',     'HIGGS' , 'epsilon_normalized', 'rcv1_train.binary' } 
  >>  test_problems_opt_step_size(problems)

## References

[1]   Robert M. Gower, Donald Goldfarb and Peter Richtarik
      Stochastic Block BFGS: Squeezing More Curvature out of Data

[2]   P. Moritz, R. Nishihara, and M. I. Jordan. 
      “A linearly-convergent stochastic L-BFGS algorithm”.
      arXiv:1508.02087v1 (2015).
## 5. TODO


## 6. Bugs and Comments

If you have any bug reports or comments, please feel free to email 

  Robert Gower <r.m.gower@sms.ed.ac.uk>
  Robert Gower <gowerrobert@gmail.com>

Or make a pull request!

Robert Gower
30 March 2016
