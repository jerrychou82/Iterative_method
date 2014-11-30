% This program compare the elapsed time of different method to calculate
% matrix vector multiplication

dtime = zeros(6,1);
stime = zeros(6,1);
for j = 2:7
    [A,b,tol,n,L,D,U] = mygenerate(mesh1(j));
    x = rand(n,1);
    % direct method
    tic;
    b = A*x;
    dtime(j-1) = toc;
    % sequential method
    tic;
    for i =1:n
        b(i) = A(i,:)*x;
    end;
    stime(j-1) = toc;
end;
