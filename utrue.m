
function u = utrue(p)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function u = utrue(p)
% Compute the solution for the test problem.
% This is called by test.m
%
% Dianne P. O'Leary 03/2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Let u(x,y) = cos(pi/2 x) * sin(4 pi y) - (x-1)(x+1)(y-1)(y+1)
% which satisfies the Dirichlet boundary conditions but not the Neumann
% condition on the inner boundary of the square region with hole.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


u = cos(pi/2*p(:,1)).*sin(4*pi*p(:,2)) ...
     - (p(:,1)-1).*(p(:,1)+1).*(p(:,2)-1).*(p(:,2)+1);

