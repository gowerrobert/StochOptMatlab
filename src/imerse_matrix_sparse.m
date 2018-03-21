function R =  imerse_matrix_sparse(n,S)
% sparse implementation of a imersion matrix
R = sparse(n,length(S));
for i =1:length(S)
   R(S(i),i) =1 ;
end


end