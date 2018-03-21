function lmetric = update_lmetric_cells(s,y,ys,lmetric)

if (ys< 1e-18 ) return; end
if(lmetric.memory_limit ==0) return; end    
lS = length(lmetric.S);
if(lS == lmetric.memory_limit)
    lmetric.S(1) = [];
    lmetric.Y(1) = [];
    lmetric.YS(1) = []; 
end

lmetric.S{end+1} = s;
lmetric.Y{end+1} = y;
lmetric.YS{end+1} = ys;

lmetric.Hdiag = ys/(y'*y);

end