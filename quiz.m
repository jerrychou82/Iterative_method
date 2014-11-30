load mesh1.mat

for i = 2:6
    [A,b,tol,n,L,D,U] = mygenerate(mesh1(i));
    
    [x,r] = mypcg(A,b,tol);
    fprintf('||r|| = %f\n', norm(r));
end;


