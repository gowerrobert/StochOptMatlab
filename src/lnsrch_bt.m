function [stp, x, f, iter, iflag, usr_par] = lnsrch_bt( x, d, dg, f, stp, fval, xnew, options, usr_par )
                                                     %( x, d, dg, f, stp, fval,xnew, options, usr_par )
%
%   [stp, x, f, iter, iflag, usr_par] = lnsrch_bt( x, d, dg, f, stp, options, usr_par )
%
%   Use backtracking to find a step size  stp > 0  such that
%  
%          f(x+stp*d) <= f(x) + ftol * stp* < gradf(x), d >,
%  
%   where gradf(x) is the gradient at x and d is a search direction.
%  
%   This function calls the following usr provided functions
%     function [fx] = f(x, usr_par)        
%     function [usr_par] = xnew( x, iter, usr_par).
%
%   This is the algorithm described in the book
%   Dennis and Schnabel "Numerical Methods for Nonlinear Equations 
%   and Unconstrained Optimization", Prentice-Hall (1983), reprinted
%   by SIAM (1996), Section 6.3.2.
%  
%   Inputs   
%      x            current iterate
%      d            search direction
%      dg           < gradf(x), d >
%      f            objective function value at x
%      stp          initial step size
%      options      line search parameters
%                      option.iprint   print if ~=0, default = 0
%                      option.fid      file identifier, default = 1
%                      option.stpmin   minimum step length, default = 1.e-8
%                      option.ftol     ftol in sufficient decrease, default = 1.e-4
%                   if lnsrch_bt  is called with options =[], then defauls
%                   are used.
%      usr_par      user parameters. These are never referenced
%                   in this function, but are passed to the
%                   user provided functions f and xnew.
%  
%   Outputs
%      stp          final step size
%      x            x + stp * d 
%      f         objective function at x+ stp * d
%      iter         number of iterations in lnsrch_ds
%                   (=number of fctn. evals. in lnsrch_ds) 
%      iflag        return flag
%                   iflag = 0 line search was successful
%                   iflag = 1 d is not a descent direction
%                   iflag = 2 initial stp < 0
%                   iflag = 3 maximum number of LS 
%                             iterations exceeded
%    
%      usr_par      user parameters. may be changed inside this function
%                   through a call to the user provided function xnew.
%
%
%   Matthias Heinkenschloss
%   Department of Computational and Applied Mathematics
%   Rice University
%   June 6, 2008
          

%% set linear search parameters
iprint  = 0;
fid     = 1;
stpmin  = 1.e-8;
%ftol    = 1.e-4;
ftol = 1.e-8;
if( ~isempty(options) )
    if( isfield(options,'iprint') ); iprint = options.iprint; end
    if( isfield(options,'fid') );    fid    = options.fid; end
    if( isfield(options,'stpmin') ); stpmin = options.stpmin; end
    if( isfield(options,'ftol') );   ftol   = options.ftol; end
end

%%  check inputs
if( dg >= 0 )       %  d is not a descent direction
    iflag = 1;
    return
end
if( stp <= stpmin ) %  initial step too small
    iflag = 2;
    return
end

%%
if( iprint > 0 )
    fprintf(fid,' lnsrch_bt with \n')
    fprintf(fid,' option.stpmin = %12.5e \n', stpmin)
    fprintf(fid,' option.ftol   = %12.5e \n', ftol)
    fprintf(fid,' iter    stepsize       Obj_fctn       required decrease \n'); 
end

%% initialize
iter   = 0;
stp_c  = stp;
f0     = f;
x0     = x;
fc     = f;

%% start linear search loop
while (stp > stpmin) 

    %  trial iterate 
    x = x0 + stp * d;

    %  compute the function value at x+stp*d
    usr_par  = xnew( x, iter, usr_par);
    f        = fval( x, usr_par);
   
    %  print iteration info
    if( iprint > 0 )
        fprintf(fid, '%4d    %12.5e    %12.5e   %12.5e \n', ...
                      iter, stp, f, f0 + stp*ftol*dg )
    end

    %  check decrease condition and return if successful
    if( f < f0 + stp*ftol*dg )
        iflag  = 0;
        return
    end

    stp_p  = stp_c;
    stp_c  = stp;
    fp     = fc;
    fc     = f;

    %  compute next step size stp
    if( iter == 0 ) 
        %  first backtrack: quadratic fit
        stp = - dg / ( 2 * (fc - f0 - dg) );
    else
        %  all subsequent backtracks: cubic fit

        t1 = fc - f0 - stp_c*dg;
        t2 = fp - f0 - stp_p*dg;
        t3 = 1 / (stp_c - stp_p);

        a = t3 * ( t1/(stp_c^2) - t2/(stp_p^2) );
        b = t3 * ( t2*stp_c/(stp_p^2) - t1*stp_p/(stp_c^2) );
        disc = b^2 - 3*a*dg;

        if( a ~= 0 ) 
            %  cubic has unique minimum
            stp = (-b + sqrt( disc ) ) / (3 * a );
        else
            %  cubic is a quadratic
            stp = -dg / ( 2 * b );
        end
        if(isnan(stp))
            stp=0.5*stp_c;
        end

    end

    %  saveguard the step size
    if( stp > 0.5*stp_c ); stp = 0.5*stp_c; end
    if( stp < stp_c/10 );  stp = stp_c/10; end

    iter = iter + 1;
end

%% stp < stpmin
iflag  = 3;


