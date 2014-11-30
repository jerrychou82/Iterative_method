function [pnew,nipnew,tnew,enew,tenew,Prolong] = refine(p,nip,t,e,te)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [pnew,nipnew,tnew,enew,tenew,Prolong] = refine(p,nip,t,e,te)
%
% This function refines the triangular mesh specified by (p,t,e,te) by
% dividing each triangle into four.
%
% Inputs:
%      p:  npts x 2, where npts is the number of triangle vertices.
%          Each row contains the two coordinates of a vertex
%          of a triangle in t.
%    nip:  number of interior points.  These points are in the first
%          nip rows of p.
%      t:  ntriangles x 3, where ntriangles is the number of
%          triangles in the mesh.
%          Each row contains the indices of its three vertices.
%      e:  nedges x 2, where nedges is the number of edges in the mesh.
%          Row i has the indices of the rows in p containing
%          the two endpoints of edge i.
%     te:  ntriangles x 3.
%          Each row contains the indices of its three edges.
%
% Outputs:
%   pnew:  array  p for the new mesh.
% nipnew:  nip for the new mesh.    
%   tnew:  array  t for the new mesh.
%   enew:  array  e for the new mesh.
%  tenew:  array te for the new mesh.
% Prolong: matrix that defines interpolation between the 
%          two sets of interior vertices.
%
% Note: triplot(t,p(:,1),p(:,2)) displays the mesh.
%
% Dianne O'Leary 03/2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ntriangles,n] = size(t);
[npts,m] = size(p);
[nedges,n] = size(e);

nedgeorig = nedges;
nptsorig = npts;
ntrianglesorig = ntriangles;
io = [2 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copy the interior points into the top of pnew, and the
% boundary points into the end of pnew.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pnew(1:nip,:) = p(1:nip,:);
pnew(nedges+nip+1:npts+nedges,:) = p(nip+1:npts,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize enew and correct the indices of the points we
% just moved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

enew = e;
index = find(enew > nip);
enew(index) = enew(index)+nedges;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make the same correction in t.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

index = find(t > nip);
t(index) = t(index)+nedges;

nipnew = nip;
indexb = nedges+nip+1;
Prolong = speye(nip);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Break each existing edge into two.
% This enlarges the set of points to size npts+nedges and gives us a 
% prolongation matrix Prolong that defines interpolation from the
% original set of points to the new set of points:
%   If the point is common to both sets, carry the old value over.
%   If the point is new, its value is the average of the two old points
%       that it lies between.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:nedges,
   p1 = pnew(enew(i,1),:);
   p2 = pnew(enew(i,2),:);
   midpt = (p1+p2)/2;
   if interior(midpt)                  % a new interior vertex
      nipnew = nipnew + 1;
      index = nipnew;
      if (e(i,1)<=nip) % Use a weight of .5 for each interior endpt of the edge.
         Prolong(index,e(i,1)) = .5;
      end
      if (e(i,2)<=nip)
         Prolong(index,e(i,2)) = .5;
      end
   else                                % a new boundary vertex
      indexb = indexb - 1;
      index = indexb;
   end
   pnew(index,:) = midpt;
   enew(nedges+i,1) = enew(i,2);
   enew(nedges+i,2) = index;
   enew(i,2) = index;
end

if (indexb == nipnew+1)
   disp('all ok')
else
   disp(sprintf('indexb=%d,nipnew+1=$d; pausing',indexb,nipnew+1))
   pause
end
nedges = 2*nedges;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Break each triangle into four.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


inew = 0;
for i=1:ntrianglesorig,
   eindices = [te(i,:),te(i,:)+nedgeorig]; 
   enow = enew(eindices,:);  % Get edges for the 4 triangles

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Three new triangles reuse old edges.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   for j=1:3,
     tnow = t(i,j);  
     hit=0;
     for k=1:6,
        for kk=1:2,
          if(enow(k,kk)==tnow)
            hit = hit + 1;
            v(hit) = enow(k,io(kk));
            eindex(hit) = eindices(k);
          end
        end
     end

     inew = inew + 1;
     tnew(inew,:) = [tnow,v];
     nedges = nedges + 1;
     tenew(inew,:) = [eindex,nedges];
     enew(nedges,:) = v;
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  One has all new edges.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   inew = inew + 1;
   tnew(inew,:) = enew(eindices(1:3),2)';
   tenew(inew,:) = nedges-2:nedges;
   
end

