    function [g] = grad_eval_ext(x, A,b)
       g = A'*(A*x - b);   
    end