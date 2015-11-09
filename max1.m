function [Amax,Ind]=max1(a)
%return the max element and its index of matrix a

Ind=[0,0];
[A,ind0]=max(a);
[Amax,Ind(2)]=max(A);
Ind(1)=ind0(Ind(2));

end