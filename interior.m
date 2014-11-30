function intt = interior(p)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function intt = interior(p)
% This returns 1 if p is not on the boundary of the box  [-1,1] x [-1,1]
%         and  0 if it is.
%
% Dianne P. O'Leary 04/2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d1 = abs(p(1)+1);
d2 = abs(p(1)-1);
d3 = abs(p(2)+1);
d4 = abs(p(2)-1);
intt = (d1*d2>1.e-5) & (d3*d4>1.e-5);
