function [A,b] = formAb(p,t,nip,kappa)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [A,b] = formAb(f,p,t,nip,kappa)
% This function forms the matrix A and the right-hand side b for
% the piecewise-linear finite element approximation A u = b 
% to the Helmholtz equation
% - u_{xx} - u_{yy} + kappa u = f
% in a region defined by the union of triangles.
%
% Input:
%     p:  An array of coordinates of the vertices of the mesh, one per row
%     t:  An array of indices of the vertices of the triangles,
%         one row for each triangle.
%   nip:  The number of interior points, all at the beginning of p.
%         Boundary conditions constrain the other points of the mesh
%         to have u=0.
% kappa:  The parameter in the Helmholtz equation.
%
% Output:
%     A:  The nip x nip sparse matrix for the approximation.
%     b:  The nip x 1 right-hand side.
%
% Dianne P. O'Leary 04/2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[ntriangles,n] = size(t);

A = sparse(nip,nip);
b = zeros(nip,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Iterate over each triangle.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:ntriangles,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the indices t and coordinates p of the triangle.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   t1 = t(i,1);
   t2 = t(i,2);
   t3 = t(i,3);
   p1 = p(t1,:);
   p2 = p(t2,:);
   p3 = p(t3,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the area of the triangle.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   at = norm(p1-p2);
   bt = norm(p2-p3);
   ct = norm(p3-p1);
   s = (at+bt+ct)/2;
   trianglearea = sqrt(s*(s-at)*(s-bt)*(s-ct));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the gradients of the three basis functions that are
% nonzero in this triangle.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   grad1 = gradplate(p1,p2,p3);
   grad2 = gradplate(p2,p1,p3);
   grad3 = gradplate(p3,p2,p1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute contributions to the matrix and rhs entries
% using the nodal quadrature rule.
% (Note that this has the effect of "lumping" the mass if 
% kappa is nonzero.)
% For compactness, we add in only half of the off-diagonal contributions
% to A, and half of the contribution to the main diagonal, and then
% take A + A'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   if (t1 <= nip)
      A(t1,t1) = A(t1,t1)+(1/3*kappa + (grad1'*grad1))*trianglearea/2;
      b(t1) = b(t1)+rhs(p1,kappa)*trianglearea/3;
      if (t2 <= nip)
         A(t1,t2) = A(t1,t2)+(grad1'*grad2)*trianglearea;
      end
   end
   if (t2 <= nip)
      A(t2,t2) = A(t2,t2)+(1/3*kappa + (grad2'*grad2))*trianglearea/2;
      b(t2) = b(t2)+rhs(p2,kappa)*trianglearea/3;
      if (t3  <= nip)
         A(t2,t3) = A(t2,t3)+(grad2'*grad3)*trianglearea;
      end
   end
   if (t3 <= nip)
      A(t3,t3) = A(t3,t3)+(1/3*kappa + (grad3'*grad3))*trianglearea/2;
      b(t3) = b(t3)+rhs(p3,kappa)*trianglearea/3;
      if (t1 <= nip)
         A(t1,t3) = A(t1,t3)+(grad1'*grad3)*trianglearea;
      end
   end


end

A = A + A';
