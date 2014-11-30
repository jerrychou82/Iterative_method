function [x,itime,niter,msize] = PCG(A,b,x,M,tol)
% Initialization
% Minv = inv(M); % When M = I
r = b - A*x;
z = r;
gamma = r'*z;
p = z;
lo = norm(r);

% Start Gauss-Seidel Method
niter = 0;
n = size(A,1);
fprintf('Start PCG >');
tic;
while norm(A*x - b) > tol && niter < 1000
    alpha = gamma/(p'*A*p);
    x = x + alpha*p;
    r = r - alpha*A*p;
    z = r;
    gamma_bar = r'*z;
    beta = gamma_bar/gamma;
    gamma = gamma_bar;
    p = z + beta*p;
    niter = niter + 1;
%     fprintf('.');
end;
itime = toc;
fprintf('\nFinish PCG\n');
msize = 0;
dt = whos('A'); msize = msize + dt.bytes;
dt = whos('x'); msize = msize + dt.bytes;
dt = whos('b'); msize = msize + dt.bytes;
dt = whos('z'); msize = msize + dt.bytes;
dt = whos('r'); msize = msize + dt.bytes;
dt = whos('p'); msize = msize + dt.bytes;

