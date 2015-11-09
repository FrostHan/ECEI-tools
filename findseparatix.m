function  findseparatix(x,y,z)
%This function is for find the separatix of some structure of plasma.
%
%by hdq

z1=z-min(min((z)));

n=length(z(:,1));

m=length(z(1,:));

G=[0,1/8,0,1/8,0;1/8,1/2,1,1/2,1/8;0,1,-7,1,0;1/8,1/2,1,1/2,1/8;0,1/8,0,1/8,0];

g=zeros(n,m);


for i=3:n-2
    for j=3:m-2
        g(i,j)=sum(sum(G.*z1(i-2:i+2,j-2:j+2)));
    end
end
figure
pcolor(x,y,z);
figure
pcolor(x,y,abs(g));


end
