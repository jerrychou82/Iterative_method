function [x,itime,niter,msize] = PCG_ichol(A,b,x,M,tol)
tic;
% Initialization
n = size(A,1);
r = b - A*x;
z = zeros(n,1);
Mt = M';

% z(1) = r(1) / M(1,1);
% for i = 2:n
%     z(i) = (r(i) - M(i,1:i-1)*z(1:i-1)) / M(i,i);
% end;
% z(n) = z(n) / Mt(n,n);
% for i = n-1:-1:1
%     z(i) = (z(i) - Mt(i,i+1:n)*z(i+1:n)) / Mt(i,i);
% end;
z = M\r;
z = Mt\z;

gamma = r'*z;
p = z;
lo = norm(r);

% Start Gauss-Seidel Method
niter = 0;
fprintf('Start PCG ichol > ');

while norm(A*x - b)/lo > tol && niter < 1000
    alpha = gamma/(p'*A*p);
    x = x + alpha*p;
    r = r - alpha*A*p;
    
%     z = zeros(n,1);
%     z(1) = r(1) / M(1,1);
%     for i = 2:n
%         z(i) = (r(i) - M(i,1:i-1)*z(1:i-1)) / M(i,i);
%     end;
%     z(n) = z(n) / Mt(n,n);
%     for i = n-1:-1:1
%         z(i) = (z(i) - Mt(i,i+1:n)*z(i+1:n)) / Mt(i,i);
%     end;
    z = M\r;
    z = Mt\z;
    
    gamma_bar = r'*z;
    beta = gamma_bar/gamma;
    gamma = gamma_bar;
    p = z + beta*p;
    niter = niter + 1;
%     fprintf('.');
end;
itime = toc;
fprintf('\nFinish PCG ichol\n');
msize = 0;
dt = whos('A'); msize = msize + dt.bytes;
dt = whos('Mt'); msize = msize + dt.bytes;
dt = whos('r'); msize = msize + dt.bytes;
dt = whos('z'); msize = msize + dt.bytes;
dt = whos('p'); msize = msize + dt.bytes;

