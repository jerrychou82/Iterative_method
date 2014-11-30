function [e,te] = findedge(t)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [e,te] = findedge(t)
%
% This function sets up the data structures for the edges
% in a triangular finite element mesh.
%
% Input:
%      t:  ntriangles x 3, where ntriangles is the number
%          of triangles in the mesh.  Each row contains the
%          indices of its three vertices.
% Output:
%      e:  nedges x 2, where nedges is the number of edges
%          in the mesh.  Row i has the indices of the rows
%          in p containing the two endpoints of edge i.
%     te:  ntriangles x 3.
%          Each row contains the indices of its three edges.
%
% Dianne O'Leary 03/2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ntriangles,m] = size(t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the three edges for the first triangle.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e(1,:) = t(1,1:2);
e(2,:) = t(1,2:3);
e(3,:) = [t(1,1),t(1,3)];
te(1,:) = [1 2 3];
nedges = 3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do the same for the remaining triangles, checking
% the e array to see if the edge already has been numbered.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=2:ntriangles,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For each edge in this triangle:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  for j=1:3,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the indices of the vertices of the current edge, in
% sorted order.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     if (j==1)
        testedge = sort(t(i,1:2));
     elseif (j==2)
        testedge = sort(t(i,2:3));
     else
        testedge = sort([t(i,1),t(i,3)]);
     end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Match the indices against the edges seen so far.
% If there is a match, r=0.  
% If not, add the edge to the e array.
% In either case, put the edge indices in the te array.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     [r,k] = min(sum(abs(e(:,:)-ones(nedges,1)*testedge),2));
     if (r == 0)
        te(i,j) = k;
     else
        nedges = nedges + 1;
        e(nedges,:) = testedge;
        te(i,j) = nedges;
     end
  end
end
