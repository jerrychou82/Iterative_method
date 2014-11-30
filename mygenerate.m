function [A,b,tol,n,L,D,U] = mygenerate(mesh)

% Initialization
A = mesh.A;
b = mesh.b;
tol = mesh.tol;
n = size(A,1);

% Split A into A = L + D + U
iL = []; jL = []; sL = [];
iD = []; sD = [];
iU = []; jU = []; sU = [];
[i,j,s] = find(A);
for k = 1: length(i)
    if i(k) > j(k)
        iL = [iL;i(k)];
        jL = [jL;j(k)];
        sL = [sL;s(k)];
    elseif i(k) < j(k)
        iU = [iU;i(k)];
        jU = [jU;j(k)];
        sU = [sU;s(k)];
    else
        iD = [iD;i(k)];
        sD = [sD;s(k)];
    end;
end;
L = sparse(iL,jL,sL,n,n);
D = sparse(iD,iD,sD,n,n);
U = sparse(iU,jU,sU,n,n);

end