% Problem 3
% Using PCG method to solve sparse linear system with incomplete Cholesky
% Preconditioner

%% Load data
load mesh1.mat
load mesh2.mat
time1_3 = zeros(length(mesh1),1);
iter1_3 = zeros(length(mesh1),1);
size1_3 = zeros(length(mesh1),1);
msize1_3 = zeros(length(mesh1),1);
time2_3 = zeros(length(mesh2),1);
iter2_3 = zeros(length(mesh2),1);
size2_3 = zeros(length(mesh2),1);
msize2_3 = zeros(length(mesh2),1);
reorder = 0;

%% Analysis
for i = 2:7
    [A,b,tol,n,L,D,U] = mygenerate(mesh1(i));
    tic;
    M = ichol(A); % In this case we use preconditioner M = incomplete Cholesky Preconditioner

    icholtime = toc;
    x = zeros(n,1);
    if reorder == 1
        p = amd(A);
        [xp,itime,niter,msize] = PCG_ichol(A(p,p),b(p),x,M,tol);
        x(p) = xp;
    else
        [x,itime,niter,msize] = PCG_ichol(A,b,x,M,tol);
    end;
    time1_3(i) = itime + icholtime;
    iter1_3(i) = niter;
    size1_3(i) = n;
    msize1_3(i) = msize;
end;
% 
% for i = 2:4
%     [A,b,tol,n,L,D,U] = mygenerate(mesh2(i));
%     M = eye(n); % In this case we use preconditioner M = I
%     x = zeros(n,1);    
%     [x,itime,niter,msize] = PCG_ichol(A,b,x,M,M',tol);
%     time2_3(i) = itime;
%     iter2_3(i) = niter;
%     size2_3(i) = n;
%     msize2_3(i) = msize;
% end;

%% Print Results
% figure
% subplot(2,1,1);
% plot(size1,time1,'*');
% title('(Mesh 1) Elapsed time for PCG Method');
% xlabel('Matrix size');
% ylabel('Elapsed time');
% subplot(2,1,2);
% plot(size1,iter1,'r*');
% title('(Mesh 1) Number of iterations using PCG Method');
% xlabel('Matrix size');
% ylabel('Number of iterations');
% 
% % Mesh 2
% figure
% subplot(2,1,1);
% plot(size2,time2,'*');
% title('(Mesh 2) Elapsed time for PCG Method');
% xlabel('Matrix size');
% ylabel('Elapsed time');
% subplot(2,1,2);
% plot(size2,iter2,'r*');
% title('(Mesh 2) Number of iterations using PCG Method');
% xlabel('Matrix size');
% ylabel('Number of iterations');
% 
% 
% 
