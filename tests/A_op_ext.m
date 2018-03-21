    function [Ax] = A_op_ext(A,x)
        Ax = (A'*(A*x));   
    end