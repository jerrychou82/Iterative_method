%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your Homework Assignment
% Multigrid Methods:
% Managing Massive Meshes
% September/October 2006 
%
% This program calls the multigrid V-Cycle algorithm to solve 
% partial differential equations
%   -u_{xx} - u_{yy} + kappa u = f
% over the domains:
%   Problem 1: [-1,1] x [-1,1], with u=0 on the boundary
%   Problem 2: [-1,1] x [-1,1] with a hole cut out,
%              with u=0 on the boundary of the square 
%              and Neumann boundary conditions on the hole.
% Various values of kappa are used, to check the convergence
% properties of multigrid.
%
% solution21.m
% Dianne P. O'Leary  04/2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nsmooth = 3;
maxit = 50;
mykappa = [0,.5,10,100,-.5,-10,-100];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate Problem 1 and solve using the V-Cycle Multigrid method.
% (The data structure  mesh  is documented in generateproblem.m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrefine = 7;
k = 0;
for kappa = mykappa,
    disp(sprintf('kappa = %f',kappa))
    mesh = generateproblem(1,nrefine,kappa);
    k = k + 1;
    [mesh,mytime(1,k),itn(1,k)] = multigrid(mesh,nrefine,nsmooth,maxit);
%   ut = utrue(mesh(nrefine).p);
%   max(abs(mesh(nrefine).u-ut(1:mesh(nrefine).nip)))
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate Problem 2 and solve using the V-Cycle Multigrid method.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrefine = 4;
k=0;

for kappa = mykappa,
    disp(sprintf('kappa = %f',kappa))
    mesh = generateproblem(2,nrefine,kappa);
    k = k + 1;
    [mesh,mytime(2,k),itn(2,k)] = multigrid(mesh,nrefine,nsmooth,maxit);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Print a summary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' S U M M A R Y   O F   R E S U L T S')
disp(' Problem  kappa    time(msec)     iterations')
for myproblem = 1:2,
  for j=1:k
    disp(sprintf('     %3d %5.2f %10d  %10d', ...
         myproblem,mykappa(j),fix(mytime(myproblem,j)*1000),itn(myproblem,j)))
  end
end
