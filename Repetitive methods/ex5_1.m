% Author : Μ. ΚΑΡΑΒΟΚΥΡΗΣ, ΑΜ 1059636 , Date : 22/02/2021
n=500;
A1 = spdiags([1:n]',[0],n,n);
xsol = ones(n,1);
b1 = A1*xsol;
tol = 1e-6;

[x0,fl0,rr0,it0,rv0] = pcg(A1,b1,tol,4*n);

A2 = spdiags([linspace(1,2,n/2)';    
linspace(1000,1001,n/2)'],[0],n,n); 
b2 = A2*xsol;

[x1,fl1,rr1,it1,rv1] = pcg(A2,b2,tol,4*n);


%plot
semilogy(0:length(rv0)-1,rv0/norm(b1),'-o')
hold on
semilogy(0:length(rv1)-1,rv1/norm(b2),'-x')
yline(tol,'r--');
st0 = sprintf('A1, error:%.9f ',rr0);
st1 = sprintf('A2, error:%.9f ',rr1);
legend(st0,st1,'Tolerance','Location','East')
title('pcg for A1 & A2');
xlabel('Iteration number')
ylabel('Relative residual')





