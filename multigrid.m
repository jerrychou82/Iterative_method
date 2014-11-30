function [mesh,mytime,itn] = multigrid(mesh,nrefine,nsmooth,maxit)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [mesh,mytime,itn] = multigrid(mesh,nrefine,nsmooth,maxit)
%
% This function runs the V-Cycle multigrid algorithm on the problem
% specified in the structure  mesh  (defined in generateproblem.m).
% 
% nrefine = number of levels in mesh
% nsmooth = number of iterations of Gauss-Seidel to be used as
%           a smoother on each level
%
% The function returns the answer in mesh and the time (seconds) in
% mytime.
%
% The iteration is terminated if the reduction in residual is greater
% than the tolerance specified in mesh, or if the number of iterations
% itn exceeds maxit.
%
% Dianne P. O'Leary  04/2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Start the multigrid iteration.')

tic
tol = mesh(nrefine).tol;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The coarsest mesh problem is solved using a direct method.
% Compute the LU factors here.
% (We don't use Cholesky, since if the Helmholtz parameter kappa
%  is negative, the matrix may fail to be positive definite, so
%  Cholesky can be unstable.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[mesh(1).L,mesh(1).U] = lu(mesh(1).A);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The other problems are solved using Gauss-Seidel iteration.
% To implement this efficiently, we find the starting points for
% the columns in each matrix A, exploiting the fact that A is
% symmetric.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for refine=2:nrefine,
   [i,j,val] = find(mesh(refine).A);
   pointer(1) = 1;
   col = 1;
   for k=2:length(j),
       if (j(k)>col)
           col = col + 1;
           pointer(col) = k;
       end
   end
   pointer(col+1) = k+1;
   mesh(refine).Apointers = pointer;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Each execution of the following while loop is one V-Cycle.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

itn = 0;
residnorm = norm(mesh(nrefine).b);
rnorm(1) = residnorm;
bnorm = residnorm;
nsmooth = 3;

while(residnorm/bnorm > tol)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Walk from fine to coarse.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   for k=nrefine:-1:1,
    if (k < nrefine)
       mesh(k).u = zeros(size(mesh(k).b));
    end
    if (k > 1)
       mesh(k).u = ...
         smooth(mesh(k).A,mesh(k).b,mesh(k).u,nsmooth,mesh(k).Apointers);
       mesh(k-1).b = mesh(k).Prolong' * (mesh(k).b - mesh(k).A * mesh(k).u);
    end
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Walk from coarse to fine, using a direct method on the coarsest grid.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   for k=1:nrefine,

    if (k==1)
       mesh(k).u = mesh(1).U \ (mesh(1).L \ mesh(1).b);
    else
       mesh(k).u = ...
         smooth(mesh(k).A,mesh(k).b,mesh(k).u,nsmooth,mesh(k).Apointers);
    end
    if (k < nrefine)
       mesh(k+1).u = mesh(k+1).u + mesh(k+1).Prolong * mesh(k).u;
    end
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evaluate the norm of the residual so that termination can be tested.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   residnorm = norm(mesh(nrefine).A * mesh(nrefine).u - mesh(nrefine).b);
   itn = itn + 1;
   rnorm(itn+1) = residnorm;

   if (itn > maxit)
      disp(sprintf('Multigrid failed to converge'))
      break
   end

end

mytime = toc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Print the iteration history.  Note that this is done outside the timer,
% since it can dominate the clocktime.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:itn+1,
   disp(sprintf('Iteration %d, residual norm %e',k-1,rnorm(k)))
end

disp(sprintf('Time: %d microsec',fix(mytime*1000)))
