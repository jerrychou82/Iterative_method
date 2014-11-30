% Problem 5 
% Use Symmetric Gauss-Seidel method to solve linear system

% Load data
load mesh1.mat
load mesh2.mat
time1_5 = zeros(length(mesh1),1);
iter1_5 = zeros(length(mesh1),1);
size1_5 = zeros(length(mesh1),1);
msize1_5 = zeros(length(mesh1),1);
time2_5 = zeros(length(mesh2),1);
iter2_5 = zeros(length(mesh2),1);
size2_5 = zeros(length(mesh2),1);
msize2_5 = zeros(length(mesh2),1);
reorder = 1;

% Analysis for mesh 1
for i = 2:5
    [A,b,tol,n,L,D,U] = mygenerate(mesh1(i));
    A = full(A);
    x = zeros(n,1);
    if reorder == 1
        p = amd(A);
        Ap = A(p,p);
        [xp,itime,niter,msize] = Gauss_Seidel(Ap,b(p),x,tol);
        x(p) = xp;
    else
        [x,itime,niter,msize] = Sym_Gauss_Seidel(A,b,x,tol);
    end;
    time1_5(i) = itime;
    iter1_5(i) = niter;
    size1_5(i) = n;
    msize1_5(i) = msize;
end;

% % Analysis for mesh 2
% for i = 2:2
%     [A,b,tol,n,L,D,U] = mygenerate(mesh2(i));
%     x = zeros(n,1);
%     [x,itime,niter] = Sym_Gauss_Seidel(A,b,x,tol);
%     time2_5(i) = itime;
%     iter2_5(i) = niter;
%     size2_5(i) = n;
%     msize2_5(i) = msize;
% end;

%% Print Results
% figure
% subplot(2,1,1);
% plot(size1,time1,'*');
% title('(Mesh 1) Elapsed time for Gauss-Seidel Method');
% xlabel('Matrix size');
% ylabel('Elapsed time');
% subplot(2,1,2);
% plot(size1,iter1,'r*');
% title('(Mesh 1) Number of iterations using Gauss-Seidel Method');
% xlabel('Matrix size');
% ylabel('Number of iterations');
% 
% % Mesh 2
% figure
% subplot(2,1,1);
% plot(size2,time2,'*');
% title('(Mesh 2) Elapsed time for Gauss-Seidel Method');
% xlabel('Matrix size');
% ylabel('Elapsed time');
% subplot(2,1,2);
% plot(size2,iter2,'r*');
% title('(Mesh 2) Number of iterations using Gauss-Seidel Method');
% xlabel('Matrix size');
% ylabel('Number of iterations');
