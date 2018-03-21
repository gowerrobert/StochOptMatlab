function solution_flag = check_solution(output,f_eval, g_eval, Hess_opt)


% solution_flag = 0;    % unknown
% solution_flag = 1;    % local max
% solution_flag = 2;    % local min
% solution_flag = 3;    % local saddle
solution_flag = 0;
x = output.x;
n = length(x);
Hess = zeros(n,n);
canon = zeros(1,n);
for i = 1:n
    canon(i)= 1;
    Hess(:,i) = Hess_opt(x,canon');
    canon(i)= 0;    
end

eH = eig(Hess);
haspos =0;
hasneg =0;
for i = 1:n
    if(eig(i) < -output.opts.tol)
        hasneg =1;
    elseif (eig(i) > output.opts.tol)
        haspos =1;
    end
end

if(hasneg)
    if(haspos)
       solution_flag = 'saddle';
    else
       solution_flag = 'max';
    end
elseif(haspos)
    solution_flag = 'min';
else
    solution_flag = 'indetermined';
end
end