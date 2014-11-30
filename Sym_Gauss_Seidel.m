function [x,itime,niter,msize] = Sym_Gauss_Seidel(A,b,x,tol)
% Start Gauss-Seidel Method
niter = 0;
n = size(A,1);
fprintf('Start sym Gauss-Seidel > ');
tic;
while norm(A*x - b) > tol && niter < 1000
    x(1) = (b(1) - A(1,2:n)*x(2:n)) / A(1,1);
    for i = 2:n
%         x(i) = (b(i) - A(i,1:i-1)*x(1:i-1) - A(i,i+1:n)*x(i+1:n)) / A(i,i);
        x(i) = (b(i) - A(i,:)*x + A(i,i)*x(i)) / A(i,i);
    end;
    
    x(n) = (b(n) - A(i,1:n-1)*x(1:n-1,1)) / A(n,n);
    for i = n-1:-1:1
%         x(i) = (b(i) - A(i,1:i-1)*x(1:i-1,1) - A(i,i+1:n)*x(i+1:n,1)) / A(i,i);
        x(i) = (b(i) - A(i,:)*x + A(i,i)*x(i)) / A(i,i);
    end;
        
    niter = niter + 1;
%     fprintf('.');
end;
itime = toc;
fprintf('\nFinish sym Gauss Seidel\n');
msize = 0;
dt = whos('A'); msize = msize + dt.bytes;
dt = whos('x'); msize = msize + dt.bytes;
dt = whos('b'); msize = msize + dt.bytes;

