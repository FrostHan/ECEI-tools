function shapeECEI(ECEI,threshold)
%This function is to recognize the structure of ECE imaging and analyze the
%evolution of the structure
%
%by hdq

%------------------------------globa lvariables------------------------------
S=0;  % of the structure
Va=0; %average velocity of the structure
Vc=0; %center velocity of the structure

%-------------------------------select data--------------------------------
narr=[24 24 24];
mro=[22 11  2];
Fre=1e6;

figure
for i=1:length(narr)
    plot(squeeze(ECEI.pdata(narr(i),mro(i),:)),selcolor(i));
    hold on
end
num1=round(ginput(2));
close gcf
%--------------------------------------------------------------------------
%pick out selected data to pdata1
pdata1=zeros(size(ECEI.pdata1,1),size(ECEI.pdata,2),num1(2)-num1(1)+1);
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
pdata2=zeros(size(pdata1,1),size(pdata1,2),num2(2)-num2(1)+1);
for i=1:size(pdata1,1)
    for j=1:size(pdata1,2)
        pdata2(i,j,:)=pdata1(i,j,num2(1):num2(2));
    end
end
time2=time1(num2(1):num2(2));
%---------------------------threshold recognize-----------------------------





%--------------------------------------------------------------------------------

end