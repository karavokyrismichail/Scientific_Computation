% Author : Μ. ΚΑΡΑΒΟΚΥΡΗΣ, ΑΜ 1059636 , Date : 23/02/2021
A = randn(n);
A = A'*A;
xsol = rand(n,1);
tol = 1e-6;
maxit = 4*n;
b = A*xsol;

x = A\b;
xn = norm(b-A*x)/norm(b);
[x0,fl0,rr0,it0,rv0] = pcg(A,b,tol,maxit);
[x1,fl1,rr1,it1,rv1] = gmres(A,b,100,tol,maxit);
[x2,fl2,rr2,it2,rv2] = gmres(A,b,n,tol,maxit);
