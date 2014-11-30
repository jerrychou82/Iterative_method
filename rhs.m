function b = rhs(p,kappa)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function b = rhs(p,kappa)
% Compute a right-hand side function for the test problem.
% Dianne P. O'Leary 03/2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Let u(x,y) = cos(pi/2 x) * sin(4 pi y) - (x-1)(x+1)(y-1)(y+1).
% This function satisfies the Dirichlet boundary conditions 
% but not the Neumann condition on the inner boundary of the 
% square region with hole.
%
% -u_{xx} - u_{yy} = ((pi/2)^2 + (4*pi)^2)*cos(pi/2 x)*sin(4 pi y)
%     + 2 (y-1)(y+1) + 2 (x-1)(x+1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


b =    ((pi/2)^2 + (4*pi)^2) *cos(pi/2*p(:,1)).*sin(4*pi*p(:,2)) ...
     + 2*(p(:,2)-1).*(p(:,2)+1) + 2*(p(:,1)-1).*(p(:,1)+1) ...
     + kappa * (cos(pi/2*p(:,1)).*sin(4*pi*p(:,2)) ...
                - (p(:,1)-1).*(p(:,1)+1).*(p(:,2)-1).*(p(:,2)+1) );


