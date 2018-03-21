function R =  imerse_matrix (n,S)
% VERY SLOW FUNCTION< NEED TO CHANGE, maybe rows for cols? Just avoid
% altogether
R = zeros(n,length(S));
for i =1:length(S)
   R(S(i),i) =1 ;
end


end