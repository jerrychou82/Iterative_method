% Problem 2
% Using PCG method to solve sparse linear system

%% Load data
load mesh1.mat
load mesh2.mat
time1_2 = zeros(length(mesh1),1);
iter1_2 = zeros(length(mesh1),1);
size1_2 = zeros(length(mesh1),1);
msize1_2 = zeros(length(mesh1),1);
time2_2 = zeros(length(mesh2),1);
iter2_2 = zeros(length(mesh2),1);
size2_2 = zeros(length(mesh2),1);
msize2_2 = zeros(length(mesh2),1);

reorder = 1;

%% Analysis
for i = 2:7
    [A,b,tol,n,L,D,U] = mygenerate(mesh1(i));
    M = eye(n); % In this case we use preconditioner M = I
    x = zeros(n,1);
    if reorder == 1
        p = amd(A);
        Ap = A(p,p);
        [xp,itime,niter,msize] = PCG(Ap,b(p),x,M,tol);
        x(p) = xp;
    else
        [x,itime,niter,msize] = PCG(A,b,x,M,tol);
    end;
    time1_2(i) = itime;
    iter1_2(i) = niter;
    size1_2(i) = n;
    msize1_2(i) = msize;
end;

% for i = 2:4
%     [A,b,tol,n,L,D,U] = mygenerate(mesh2(i));
%     M = eye(n); % In this case we use preconditioner M = I
%     x = zeros(n,1);    
%     [x,itime,niter,msize] = PCG(A,b,x,M,tol);
%     time2_2(i) = itime;
%     iter2_2(i) = niter;
%     size2_2(i) = n;
%     msize2_2(i) = msize;
%     
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
