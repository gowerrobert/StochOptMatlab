function H= update_conjugate_metric(H,D,HeD,type)
if(~isempty(HeD))    
    if(strcmp(type,'direct'))
        E = directQuNac(D,HeD,H);
    else
        E = inverseQuNac_scaled(D,HeD, H);
    end
    H= H+E;
else 
   % display('Repeat Hessian Approximation!');
end

end