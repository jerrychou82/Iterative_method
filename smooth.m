function u = smooth(A,b,u,nsmooth,Apointers)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function u = smooth(A,b,u,nsmooth,Apointers)
%
% This function performs  nsmooth  iterations of the Gauss-Seidel 
% method on the linear system  A u = b  where  A  is symmetric.
%
% The array Apointers gives the index of the first element in each
% column of the sparse matrix A, when it is stored in [i,j,val] format.
%
% The natural way to implement the algorithm in Matlab is:
% for k=1:nsmooth,
%     for i=1:n,
%       u(i) = (b(i)- A(i,:)*u + A(i,i)*u(i) ) / A(i,i);
%     end
%  end
% This way is not very efficient, since 
%   -- It is a row-oriented algorithm rather than column oriented.
%   -- Matlab will expand A(i,:) to multiply by u.
% The way implemented here is more complicated but more efficient.
% Caution: It only works for symmetric matrices.
%
% Dianne O'Leary 03/2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = length(b);
[irow,jcol,val] = find(A);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For each iteration and for each row i,
%    Find the indices (index) of the rows of val 
%         corresponding to row i of A.
%    Compute innerpro = A(i,:)*u.
%    Update u(i).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:nsmooth,
   for i=1:n,
     index = Apointers(i):Apointers(i+1)-1;
     innerpro = u(irow(index))'*val(index);
     u(i) = (b(i)- innerpro + A(i,i)*u(i) ) / A(i,i);
   end
end
 

