function H= update_metric(H,D,HeD,type)
if(~isempty(HeD))    
    if(strcmp(type,'AIR'))
        E = AIR_update(D,HeD,H);
    elseif(strcmp(type,'BBFGS'))
        E = quNac_update(D,HeD, H);
    else
        E = quNac_update(D,HeD, H);
    end
    H= H+E;
else 
   % display('Repeat Hessian Approximation!');
end

end