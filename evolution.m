function [xcc,ycc,vc,nc,tc,time]=evolution(ECEI,t,fs)
%show the evolusion of the structures of Electron Temperature Imaging 
%where x=ECEI.x,y=ECEI.y,
%data1=ECEI.pdata(:,:,t1),data2=ECEI.pdata(:,:,t1+¡÷t)
%tc,theta_center_cold, is the angle of cold island center
%by hdq

%normalize

x=ECEI.x;
y=ECEI.y;
t=floor(t*fs);
data1=ECEI.pdata(:,:,t);
data2=ECEI.pdata(:,:,t+30);
time=ECEI.t(t);
data2=data2/max(max(abs(data2)));
data1=data1/max(max(abs(data1)));
%---------------data process--------------
dd=data2-data1;
[DXh,DYh]=gradient(-dd);
DXc=zeros(size(x,1),size(x,2));
DYc=zeros(size(x,1),size(x,2));
%where h means hot ,c means cold

nc=0;
nh=0;
xhc=0;
xcc=0;
yhc=0;
ycc=0;

for i=1:size(x,1)
    for j=1:size(x,2)
        if data1(i,j)<-0.5;
            DXc(i,j)=-DXh(i,j);
            DYc(i,j)=-DYh(i,j);
            DXh(i,j)=0;
            DYh(i,j)=0;
            xcc=xcc+x(i,j);
            ycc=ycc+y(i,j);
            nc=nc+1;
        elseif data1(i,j)<0.5
            DXh(i,j)=0;
            DYh(i,j)=0;
        else
            xhc=xhc+x(i,j);
            yhc=yhc+y(i,j);
            nh=nh+1;
        end
    end
end
%geometric center of the structures
xhc=xhc/nh;
yhc=yhc/nh;
xcc=xcc/nc;
ycc=ycc/nc;

tc=angle(xcc-xma+(ycc-yma)*1i);

%---------------------plot--------------------------
a=get(0,'screensize');
w=(max(max(x))-min(min(x)))/(max(max(y))-min(min(y)))*(a(4)-100);
figure('position',[10,10,w,a(4)-100])

hold on
contour(x,y,data1,[-0.9,-0.7,-0.5,0.5,0.7,0.9])
quiver(x,y,DXh,DYh,1.2,'r');
quiver(x,y,DXc,DYc,1.2,'b');

%----------average velocity of the structures------------
VXh=sum(sum(DXh));
VYh=sum(sum(DYh));

quiver([xhc],[yhc],[VXh],[VYh],3,'r','linewidth',5);


VXc=sum(sum(DXc));
VYc=sum(sum(DYc));

vc=sqrt(VYc^2+VXc^2);

quiver([xcc],[ycc],[VXc],[VYc],3,'b','linewidth',5);

hold off
end