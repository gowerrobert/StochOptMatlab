% PCG_bounded is an implementation of Preconditioned Conjugate Gradients,
% with an additional upper bound on number of iterations set by PCG.maxit.
% PCG_bounded returns the conjugate directions in P and the action of the
% system A on P
% Copyright (c) 2014.  Robert Gower.
function [PCG, P, AP] = PCG_bounded(A,M,b,PCG)

r=b-A(PCG.x0);
x = PCG.x0;
z=M(r);
normr0=sqrt(r'*z);
%normr0=sqrt(r'*r);
normx = sqrt(x'*x);
resNE =1;

form = '%5.0f %9.2g %12.5g %9.2g\n';
if PCG.prnt
    head = '    k       normx        resNE        normr';
    disp('  ');   disp(head);
    fprintf(form, 0,  normx, 1, 1);
end

% Selecting the type of tolerance used
switch PCG.tol
    case 'super-linear'
        tol = min(0.01, normr0);
    case 'quadratic'
        tol = min(0.01*normr0, normr0^2);
    otherwise
        tol =  PCG.tol;
end

tol = tol.*normr0;
P =[];
AP = [];
% flag for max iterations reached
flag = -1;
for i=1:PCG.maxit
    if(i~=1)
        z = M(r);
    end
    zr= z'*r;
    if( zr < 0 );
        % display('Indefinite M PRECON in PCG!'); 
        flag = 'neg_preconditioner'; 
        break;
    end
    %normr = sqrt(r'*r);
    normr = sqrt(zr);
    if (normr <  tol), flag ='converged'; break; end
    
    if ( i > 1 ),
        beta = zr/zr_old;
        p=-z+beta*p;
    else
        p = -z;
    end
    
    Ap=A(p);
    curv = p'*Ap;
    if(curv <= 0)
        flag = 'neg_curv';
        break;
    end
    alpha=    zr/curv;
    x=x+alpha*p;
    r=r+alpha*Ap;
    scurv =  1/sqrt(curv);
    if(isempty(P) && i<=PCG.update_size)
        P =  scurv*p;
        AP = scurv*Ap;
    elseif (i<=PCG.update_size)
        P = [P scurv*p];
        AP = [AP scurv*Ap];
    end
    
    resNE = normr/normr0;
    zr_old = zr;
    if PCG.prnt, fprintf(form, PCG.iter+i, normx, resNE, normr); end
end
PCG.iter = i+PCG.iter;
PCG.hess_vec = i;
PCG.CGsteps = i;
PCG.x = x;
PCG.resNE=resNE;
PCG.flag= flag;
end
