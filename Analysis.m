% Problem 1,2,3,5 with dataset from first category
load result.mat;

%% Plot Mesh1 result
figure
size1 = 1:7;
size1 = size1'*ones(1,4);
subplot(3,1,1); hold on
plot(size1(2:5,1),iter1(2:5,1),'*');
plot(size1(2:7,2),iter1(2:7,2),'r*');
plot(size1(2:7,3),iter1(2:7,3),'g*');
plot(size1(2:5,4),iter1(2:5,4),'k*');
legend('Prob1','Prob2','Prob3','Prob5');
title('(Mesh 1) Number of iterationsd');
xlabel('Matrix size');
ylabel('Number of iterations');


subplot(3,1,2); hold on
plot(size1(2:5,1),time1(2:5,1),'*'); hold on
plot(size1(2:7,2),time1(2:7,2),'r*'); hold on
plot(size1(2:7,3),time1(2:7,3),'g*'); hold on
plot(size1(2:5,4),time1(2:5,4),'k*');
legend('Prob1','Prob2','Prob3','Prob5');
title('(Mesh 1) Elapsed time');
xlabel('Matrix size');
ylabel('Elapsed time');

subplot(3,1,3); hold on
plot(size1(2:5,1),msize1(2:5,1),'*'); hold on
plot(size1(2:7,2),msize1(2:7,2),'r*'); hold on
plot(size1(2:7,3),msize1(2:7,3),'g*'); hold on
plot(size1(2:5,4),msize1(2:5,4),'k*');
legend('Prob1','Prob2','Prob3','Prob5');
title('(Mesh 1) Storage spent');
xlabel('Matrix size');
ylabel('Storage');

%% Plot Mesh2 result
figure
subplot(3,1,1); hold on
plot(1:1,iter2(2:2,1),'*');
plot(1:3,iter2(2:4,2),'r*');
plot(1:3,iter2(2:4,3),'g*');
plot(1:1,iter2(2:2,4),'k*');
legend('Prob1','Prob2','Prob3','Prob5');
title('(Mesh 2) Number of iterationsd');
xlabel('Matrix size');
ylabel('Number of iterations');

subplot(3,1,2); hold on
plot(1:1,time2(2:2,1),'*'); hold on
plot(1:3,time2(2:4,2),'r*'); hold on
plot(1:3,time2(2:4,3),'g*'); hold on
plot(1:1,time2(2:2,4),'k*');
legend('Prob1','Prob2','Prob3','Prob5');
title('(Mesh 2) Elapsed time');
xlabel('Matrix size');
ylabel('Elapsed time');

subplot(3,1,3); hold on
plot(1:1,msize2(2:2,1),'*'); hold on
plot(1:3,msize2(2:4,2),'r*'); hold on
plot(1:3,msize2(2:4,3),'g*'); hold on
plot(1:1,msize2(2:2,4),'k*');
legend('Prob1','Prob2','Prob3','Prob5');
title('(Mesh 2) Storage spent');
xlabel('Matrix size');
ylabel('Storage');



%% Combine
time1 = [time1_1,time1_2,time1_3,time1_5];
iter1 = [iter1_1,iter1_2,iter1_3,iter1_5];
msize1 = [msize1_1,msize1_2,msize1_3,msize1_5];
size1 = [size1_1,size1_2,size1_3,size1_5];
size2 = [size2_1,size2_2,size2_3,size2_5];
msize2 = [msize2_1,msize2_2,msize2_3,msize2_5];
iter2 = [iter2_1,iter2_2,iter2_3,iter2_5];
time2 = [time2_1,time2_2,time2_3,time2_5];
save('result','iter1','iter2','time1','time2','msize1','msize2','size1','size2');
