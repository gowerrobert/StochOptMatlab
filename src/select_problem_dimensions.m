function dims = select_problem_dimensions(problem)

switch problem
    case 7
        dims =100:100:600;
    case 9
        dims =[100 125 150];
    case 13
        dims =100:100:500;        
    case 18
        dims =[10 20 30];  
    otherwise
        dims =100:100:1000;
end


end