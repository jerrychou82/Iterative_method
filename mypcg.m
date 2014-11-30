function [x,r] = mypcg(A,b,tol)
n = size(A,1);
M = diag(A);
Minv = diag(ones(n,1)./M);
x = zeros(n,1);

r = b - A*x;
z = Minv*r;
gamma = r'*z;
p = z;
lo = norm(r);
fprintf('>');
while norm(A*x-b)/lo >= tol
    alpha = gamma/(p'*A*p);
    x = x + alpha*p;
    r = r - alpha*A*p;
    z = Minv*r;
    gamma_bar = r'*z;
    beta = gamma_bar/gamma;
    gamma = gamma_bar;
    p = z + beta*p;
    
    fprintf('.');
end;
r = b-A*x;
fprintf('%f\n',norm(r));

end