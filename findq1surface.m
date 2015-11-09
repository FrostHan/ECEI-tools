function [xq1,yq1]=findq1surface(shot,time,fLO,It,R0,h)
%This function can help you find out the q=1 surface
%You should choose a period of time with stable signals having sawtooth.
%h is the height of our detecting area
%R0 is radius of the center of plasma
%
%For the ploted figure,q=1 surface is the on the circle of lowest value.
%You can click on 4 points of the q=1 surface and draw the circle
%----------------location-------------------

if nargin<6
    h=52.5;% unit will be 'cm'
end
if nargin<3
    fLO=90;
    It=8000;
    R0=1.85;
end
B0=4.16e-4*It/R0;
fvco=[2.5,3.4,4.3,5.2,6.1,7.0,7.9,8.8,9.7,10.6,11.5,12.4,13.3,14.2,15.1,16];
f=fLO+fvco;
x=((5600*B0*R0)./f-100*R0);
% minr=min(r);
% maxr=max(r);
% nr=length(r);
% r=linspace(maxr,minr,nr);
y=linspace(h/2,-h/2,24);
%----------------------------------------
pdata = zeros(24,16);
%------------------data------------------
for i=1:24
    for j=1:16
        [tmp,~]=loadecei1(shot,i,j,time);
        tmp=smooth(tmp,1000);
        sdata=std(tmp);
        mdata=mean(tmp);
        pdata(i,j)=(sdata/mdata)^2;
    end
end
pdata=kickbadout(shot,pdata);
%---------------------------------------
contourf(x,y,pdata,30,'linestyle','none');
hold on
colorbar;
[X1,Y1]=ginput(4);

%------------plot q=1 circle------------
xy=[X1(1) Y1(1);X1(2) Y1(2);X1(3) Y1(3);X1(4) Y1(4)];
syms x0;
syms y0;
syms ax;
syms by;
f=((xy(:,1)-x0).^2)./ax^2+((xy(:,2)-y0).^2)./by^2-1;
[ax,by,x0,y0]=solve(f(1),f(2),f(3),f(4));
ax=eval(ax(1));
by=eval(by(1));
x0=eval(x0(1));
y0=eval(y0(1));%把符号变量转换成数值
t=0:pi/20:2*pi;
x=ax*cos(t)+x0;
y=by*sin(t)+y0;
plot(x,y,'r-');
xq1=x;
yq1=y;
hold on
end