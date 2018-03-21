form = '%12.6e   %5.0f %9.2g   %4.6f   %5.5f\n';
% if(iteration ==1)
%     fprintf('%s \n', DATA.name);
% end
if(mod(iteration,30) ==0)
    fprintf('%s', DATA.name);
    head = '        f       Itr       stp      data    time';
    disp('  ');   disp(head);
end

if(iteration ==1)
    fprintf(form, f, iteration, xdiff, 0, cur_time);
else
    fprintf(form, f, iteration, xdiff, DATA.datapasses(end), cur_time);
end