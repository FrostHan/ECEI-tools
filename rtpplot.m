function rtpplot(ECEI,zlabelname)
%to plot a 3-D figure about t, r, Te(or pdata)
%at the middle plane(y=0)
%zlabelname: 'T_e' or '\delta T_e/<T_e>' or others

rows=size(ECEI.pdata,1);
columes=size(ECEI.pdata,2);

middlerow=round(rows/2);

narr=[middlerow,middlerow,middlerow];
mro=[round(columes/4),round(columes/2),round(3*columes/4)];
Fre=1e6;

%--------------------------------------------------------------------------
%selected data in time series
figure
for i=1:length(narr)
    plot(squeeze(ECEI.pdata(narr(i),mro(i),:)),selcolor(i));
    hold on
end
num1=round(ginput(2));
close gcf
%--------------------------------------------------------------------------
%pick out selected data to pdata1
for i=1:size(ECEI.pdata,1)
    for j=1:size(ECEI.pdata,2)
        pdata1(i,j,:)=ECEI.pdata(i,j,num1(1):num1(2));
    end
end
time1=ECEI.t(num1(1):num1(2));
%--------------------------------------------------------------------------
%selected data in time series
figure
for i=1:length(narr)
    plot(squeeze(pdata1(narr(i),mro(i),:)),selcolor(i));
    hold on
end
num2=round(ginput(2));
close gcf
%--------------------------------------------------------------------------
%pick out selected data to pdata2
for i=1:size(pdata1,1)
    for j=1:size(pdata1,2)
        pdata2(i,j,:)=pdata1(i,j,num2(1):10:num2(2));
    end
end
time2=time1(num2(1):10:num2(2));



data=squeeze((pdata2(12,:,:)+pdata2(13,:,:)))/2;
[X,T]=hhhh(ECEI.x(1,:),time2);

mesh(T,X,data')
xlabel('time/s')
ylabel('radial distance/cm')
zlabel(zlabelname)

end

function [x,y]=hhhh(x0,y0)

x=zeros(length(y0),length(x0));

y=zeros(length(y0),length(x0));

for i=1:length(y0)
    for j=1:length(x0)
      x(i,j)=x0(j);
      y(i,j)=y0(i);
    end
end
    
    
end