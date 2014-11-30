function grad = gradplate(p1,p2,p3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function grad = gradplate(p1,p2,p3);
% Compute the gradient of the bilinear function that is 
% 1 at p3 and 0 at p2 and p1.
% Dianne P. O'Leary 03/2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (abs(p2(1)-p3(1)) > abs(p2(2)-p3(2)))
   m = (p2(2)-p3(2))/(p2(1)-p3(1));
   b = p2(2)-m*p2(1);
   a = p1(2)-m*p1(1)-b;
   grad = [-m/a;1/a];
else
   m = (p2(1)-p3(1))/(p2(2)-p3(2));
   b = p2(1)-m*p2(2);
   a = p1(1)-m*p1(2)-b;
   grad = [1/a;-m/a];
end

