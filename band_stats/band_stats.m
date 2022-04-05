function P = band_stats(mxid)
% Author : Μ. ΚΑΡΑΒΟΚΥΡΗΣ, ΑΜ 1059636 , Date : 18/02/2021
[r,c] = size(mxid); %sizes of mxid to test if it is an array 
P = [];

if isa(mxid,'string')   %if mxid is a stringl, i convert it to char
    mxid = convertStringsToChars(mxid);
end
    
if isa(mxid,'char')     %if mxid is char, then i choose the matrix with this name
    try
        Problem = ssget(mxid);
    catch
        error('mxid doesnt match with any existing matrix');
    end
    A = Problem.A;
    
elseif (r > 1) || (c > 1)   %if mxid is array, then i use mxid
    A = mxid;
    
elseif floor(mxid) == mxid    %if mxid is interger, than i choose the matrix with this id
    try
        Problem = ssget(mxid);
    catch
        error('mxid doesnt match with any existing matrix');
    end
    A = Problem.A;
    [m,n]=size(A);
    m = min(m,n);
    A = A(1:min(m,1000),1:min(m,1000));
    
else 
    error('mxid data type is not valid');   %in case that mxid is not the right data type
    
end


p = size(A,1);  %size of A
nnzA = nnz(A);  %number of nnz for A
froA = norm(A, 'fro');  %frobenius norm of A
Ak = zeros(p);  %creation of an all zero array in size of p, so then we can put the diagonials

if nnzA == 0    %check if A has only zero elements
    for k = 0:p-1
        P(k+1,1) = 0;
    end

elseif nnzA > 0     %rnnz for the kth diagonials of A, in every loop, it uses the values of the previous result
    for k = 0:p-1   %if k = 0, we use only one diagonial
        if k == 0
            P(k+1,1) = nnz(spdiags(A,k))/nnzA;

        else
            P(k+1,1) = P(k,1) + (nnz(spdiags(A,k))/nnzA) + (nnz(spdiags(A,-k))/nnzA);
            
        end
    end
end

if froA == 0    %check if A has only zero elements
    for k = 0:p-1
        P(k+1,2) = 0;
    end

elseif froA > 0     %rerr for the kth diagonials of A 
    for k = 0:p-1
        if k == 0   %if k = 0, we use only one diagonial
            v = diag(A,k);     
            Ak = Ak + diag(v);  %it puts the kth diagonials in the zero matrix 
            rerr = A - Ak;
            P(k+1,2) = norm(rerr,'fro')/froA; 
            
        else
            v = diag(A,k);
            Ak = Ak + diag(v,k);
            v = diag(A,-k);
            Ak = Ak + diag(v,-k);
            rerr = A - Ak;
            P(k+1,2) = norm(rerr,'fro')/froA;
        end
    end
end

x = 0:(p-1);    %values for plot
y1 = P(1:p,1);
y2 = P(1:p,2);

figure      %plotting data
plot(x,y1,'-x',x,y2,'-o');
legend('rnnz','rerr');
title('Test for bandedness');
xlabel('iteration p (p = q), bandwidth k = p + p + 1'); 
ylabel('values of rnnz and rerr for kth diagonials of A');

end