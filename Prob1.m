% Problem 1 
% Use Gauss-Seidel method to solve linear system

% Load data
load mesh1.mat
load mesh2.mat
time1_1 = zeros(length(mesh1),1);
iter1_1 = zeros(length(mesh1),1);
msize1_1 = zeros(length(mesh1),1);
size1_1 = zeros(length(mesh1),1);
time2_1 = zeros(length(mesh2),1);
iter2_1 = zeros(length(mesh2),1);
msize2_1 = zeros(length(mesh2),1);
size2_1 = zeros(length(mesh2),1);
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
        [x,itime,niter,msize] = Gauss_Seidel(A,b,x,tol);
    end;    
    time1_1(i) = itime;
    iter1_1(i) = niter;
    size1_1(i) = n;
    msize1_1(i) = msize;
end;

% % Analysis for mesh 2
% for i = 2:2
%     [A,b,tol,n,L,D,U] = mygenerate(mesh2(i));
%     x = zeros(n,1);
%     [x,itime,niter,msize] = Gauss_Seidel(A,b,x,tol);
%     time2_1(i) = itime;
%     iter2_1(i) = niter;
%     size2_1(i) = n;
%     msize2_1(i) = msize;
% end;

%% Print Results
% figure
% subplot(3,1,1);
% plot(size1_1(2:4),time1_1(2:4),'*');
% title('(Mesh 1) Elapsed time for Gauss-Seidel Method');
% xlabel('Matrix size');
% ylabel('Elapsed time');
% subplot(3,1,2);
% plot(size1_1(2:4),iter1_1(2:4),'r*');
% title('(Mesh 1) Number of iterations using Gauss-Seidel Method');
% xlabel('Matrix size');
% ylabel('Number of iterations');
% subplot(3,1,3);
% plot(size1_1(2:4),msize1_1(2:4),'g*');
% title('(Mesh 1) Storage spent');
% xlabel('Matrix size');
% ylabel('Storage');

% % Mesh 2
% figure
% subplot(3,1,1);
% plot(size2_1,time2_1,'*');
% title('(Mesh 2) Elapsed time for Gauss-Seidel Method');
% xlabel('Matrix size');
% ylabel('Elapsed time');
% subplot(3,1,2);
% plot(size2_1,iter2_1,'r*');
% title('(Mesh 2) Number of iterations using Gauss-Seidel Method');
% xlabel('Matrix size');
% ylabel('Number of iterations');
% subplot(3,1,3);
% plot(size1_1,msize1_1,'g*');
% title('(Mesh 2) Storage spent');
% xlabel('Matrix size');
% ylabel('Storage');


