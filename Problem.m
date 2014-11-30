% Problem 1 
% Use Gauss-Seidel method to solve linear system

% Load data
load mesh1.mat
load mesh2.mat
time1 = zeros(length(mesh1),1);
iter1 = zeros(length(mesh1),1);
msize1 = zeros(length(mesh1),1);
size1 = zeros(length(mesh1),1);
time2 = zeros(length(mesh2),1);
iter2 = zeros(length(mesh2),1);
msize2 = zeros(length(mesh2),1);
size2 = zeros(length(mesh2),1);

% Analysis for mesh 1
for i = 2:4
    [A,b,tol,n,L,D,U] = mygenerate(mesh1(i));
    x = zeros(n,1);
    M = eye(n); % In this case we use preconditioner M = incomplete Cholesky Preconditioner
    [x,itime,niter,msize] = Sym_Gauss_Seidel(A,b,x,tol);
    time1(i) = itime;
    iter1(i) = niter;
    size1(i) = n;
    msize1(i) = msize;
    G = (L+D)\U;
    lambda = eigs(G);
    fprintf(1,'%f\n',lambda(1));
end;

% % Analysis for mesh 2
% for i = 2:2
%     [A,b,tol,n,L,D,U] = mygenerate(mesh2(i));
%     x = zeros(n,1);
%     [x,itime,niter,msize] = Gauss_Seidel(A,b,x,tol);
%     time2(i) = itime;
%     iter2(i) = niter;
%     size2(i) = n;
%     msize2(i) = msize;
% end;

%% Print Results
figure
subplot(3,1,1);
plot(size1(2:4),time1(2:4),'*');
title('(Mesh 1) Elapsed time for Gauss-Seidel Method');
xlabel('Matrix size');
ylabel('Elapsed time');
subplot(3,1,2);
plot(size1(2:4),iter1(2:4),'r*');
title('(Mesh 1) Number of iterations using Gauss-Seidel Method');
xlabel('Matrix size');
ylabel('Number of iterations');
subplot(3,1,3);
plot(size1(2:4),msize1(2:4),'g*');
title('(Mesh 1) Storage spent');
xlabel('Matrix size');
ylabel('Storage');

% % Mesh 2
% figure
% subplot(3,1,1);
% plot(size2,time2,'*');
% title('(Mesh 2) Elapsed time for Gauss-Seidel Method');
% xlabel('Matrix size');
% ylabel('Elapsed time');
% subplot(3,1,2);
% plot(size2,iter2,'r*');
% title('(Mesh 2) Number of iterations using Gauss-Seidel Method');
% xlabel('Matrix size');
% ylabel('Number of iterations');
% subplot(3,1,3);
% plot(size1,msize1,'g*');
% title('(Mesh 2) Storage spent');
% xlabel('Matrix size');
% ylabel('Storage');


