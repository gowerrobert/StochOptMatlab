function [d] =iter_BCD(R,AR,b,d0,options)
%R = M(:,s); 
%AR = A(R);
RAR = R'*AR;
d = d0 -R*(RAR\(AR'*d0 -(R')*b)) ;
end


