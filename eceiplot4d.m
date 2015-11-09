function eceiplot4d(ECEI,DeltaTeMatrix)
%when you run this program, first choose a range
%(click the positions of start and end, for two times)
%then, click four positions to plot 



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
        pdata2(i,j,:)=pdata1(i,j,num2(1):num2(2));
    end
end
time2=time1(num2(1):num2(2));
%--------------------------------------------------
%selected data in time series
figure
for i=1:length(narr)
    plot(squeeze(pdata2(narr(i),mro(i),:)),selcolor(i));
    hold on
end
num3=round(ginput(4));
close gcf
%--------------------------------------------------------------------------
%pick out selected data to pdata3
for i=1:size(pdata1,1)
    for j=1:size(pdata1,2)
        for k=1:4
            pdata3(i,j,k)=pdata2(i,j,num3(k));
        end
    end
end
count=['a','b','c','d'];



for i=1:4
    num3(i);
    surf(ECEI.x,ECEI.y,pdata3(:,:,i))
    title(count(i))
end



end