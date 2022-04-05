function [y]= spmv_bcrs(y,val,col_idx,row_blk,x)
% Author : Μ. ΚΑΡΑΒΟΚΥΡΗΣ, ΑΜ 1059636 , Date : 15/02/2021

nb = size(val,1);
val_c = 1;  %μετρητές
y_r = 1;
idx = 1;

for rows = 1:(length(row_blk)-1)    %για την γραμμή
    for cols = row_blk(rows):(row_blk(rows+1)-1)    %για την στήλη
        y(y_r:y_r+nb-1) = y(y_r:y_r+nb-1) + val(1:nb, val_c:val_c+nb-1)*x((col_idx(idx)*nb-nb+1):(col_idx(idx)*nb)); %y = y + Ax
        val_c = val_c+nb;   %δείχνει το επόμενο μπλοκ
        idx = idx +1;
    end
    y_r = y_r + nb;    
end
    clearvars nb val_c y_r idx
end

               
                
           
            
