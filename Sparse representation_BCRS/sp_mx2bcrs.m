function [val, col_idx, row_blk] = sp_mx2bcrs(A,nb)
% Author : Μ. ΚΑΡΑΒΟΚΥΡΗΣ, ΑΜ 1059636 , Date : 14/02/2021

col_idx = [];
row_blk = [1];  % Ξεκινάει με την τιμή 1
row_c = 0;
ind_c = 1;
val_c = 1;

for i=1:nb:size(A, 1)
    for j=1:nb:size(A, 1)
        if nnz(A(i:i+nb-1, j:j+nb-1))
            val(1:nb, val_c:val_c+nb-1) = A(i:i+nb-1, j:j+nb-1);   % βάζει στο val το μπλοκ με τα μη μηδενικά
            col_idx(end + 1) = ind_c;   % βάζει στο col_idx, τη θέση (στήλη) του μη μηδενικού μπλοκ στη συγκεκριμένη γραμμή
            row_c = row_c + 1;
            val_c = val_c + nb; % κρατάει το άθροισμα των μη μηδενικών μπλοκ στη συγκεκριμένη γραμμή 
        end
        ind_c = ind_c + 1;
    end
    row_blk(end + 1) = row_blk(end) + row_c;    % δείχνει πότε αλλάζει η γραμμή
    row_c = 0; % αρχικοποίηση μετρητών
    ind_c = 1;
end
clearvars row_c ind_c val_c
end





















