% Author : Μ. ΚΑΡΑΒΟΚΥΡΗΣ, ΑΜ 1059636 , Date : 23/02/2021
n=500;
A = randn(n);
A = A'*A;
xsol = rand(n,1);
tol = 1e-6;
maxit = 4*n;
b = A*xsol;

[x0,fl0,rr0,it0,rv0] = pcg(A,b,tol,maxit);
[x1,fl1,rr1,it1,rv1] = gmres(A,b,100,tol,maxit);
[x2,fl2,rr2,it2,rv2] = gmres(A,b,n,tol,maxit);

%plot
semilogy(0:length(rv0)-1,rv0/norm(b),'-o')
hold on
semilogy(0:length(rv1)-1,rv1/norm(b),'-x')
hold on
semilogy(0:length(rv2)-1,rv2/norm(b),'-*')
yline(tol,'r--');
st0 = sprintf('A - pcg last step error:%.7f ',rr0);
st1 = sprintf('A - gmres restart last step error:%.7f ',rr1);
st2 = sprintf('A - gmres last step error:%.7f ',rr2);
legend(st0,st1,st2,'Tolerance','Location','East')
title('pcg, gmres(100), gmres(n) for A');
xlabel('Iteration number')
ylabel('Relative residual')

