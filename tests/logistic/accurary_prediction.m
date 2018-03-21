function accurary = accurary_prediction(X,y,x)

%out = sum(log(1 + exp(-(y).*(X*w))));    
prediction =  (X)*x;  
lp = length(prediction);

pos_ind  = prediction>0;
neg_ind  = ~pos_ind;

pos_y = y>0;
neg_y = ~pos_y;

pos_correct = sum(pos_ind.*pos_y);
neg_correct = sum(neg_ind.*neg_y);

accurary = pos_correct/lp+neg_correct/lp;
%display(['accuracy ' num2str(accurary*100) '%' ])
end