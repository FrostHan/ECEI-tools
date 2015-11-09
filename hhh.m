function [x,y]=hhh(x0,y0)

x=zeros(length(y0),length(x0));

y=zeros(length(y0),length(x0));

for i=1:length(y0)
    for j=1:length(x0)
      x(i,j)=x0(j);
      y(i,j)=y0(i);
    end
end
    
    
end