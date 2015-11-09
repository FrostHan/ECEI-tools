function showmodes(shot,fs,timeperiod)


[S,F,T,poi]=autoSpectroAna(shot,fs,timeperiod);

N=length(poi);
figure
subplot(2,N,1:N)
        contourf(T,F,S,50,'linestyle','none');
        hold on
        xlabel('time/s')
        ylabel('frequency/Hz')
        title(['shot',int2str(shot),'  spectrogram'])
        
for i=1:N
        plot(poi(i).t,poi(i).f,'color','white','marker','x','markersize',20)
        text(poi(i).t,poi(i).f,['\leftarrow (',int2str(i),')'],'fontsize',20,'color','black')
end

for i=1:N
    ECEI=imaging_384_non_interp_cali(shot,[poi(i).t-0.05,poi(i).t+0.05],4,90,8000,[0.9*poi(i).f-100,1.1*poi(i).f+100]);
    subplot(2,N,N+i)
        data=ECEI.pdata(:,:,round(end/2));
        contourf(ECEI.x,ECEI.y,data,50,'linestyle','none')
        xlabel('radius/cm')
        ylabel('height/cm')
        title(['(',int2str(i),')'])
    clear ECEI
end


end

function [s0,f0,t0,poi]=autoSpectroAna(shot,fs,timeperiod)


%---随机行走参数 a=-B*v.vt+C*gravity;---
B=0.2;
C=5;
G=0.00175;

%------------------
[s0,f0,t0]=eceispectrogram(shot,timeperiod,[400,10000],fs);

s=s0/min(min(s0))-1;
s=s.^2;

Ct=range(t0)/length(t0);
Cf=range(f0)/length(f0);

t=(t0-min(t0))/Ct;
f=(f0-min(f0))/Cf;

Xgravity=zeros(size(s,1),size(s,2));
Ygravity=zeros(size(s,1),size(s,2));
for n=1:size(s,1)
    for m=1:size(s,2)
        Xgravity(n,m)=0;
        Ygravity(n,m)=0;
        for i=1:size(s,1)
            for j=1:size(s,2)
                if i~=n||j~=m
                    Xdg=(t(j)-t(m))*s(i,j)/sqrt(((t(m)-t(j))^2+(f(n)-f(i))^2)^3);
                    Ydg=(f(i)-f(n))*s(i,j)/sqrt(((t(m)-t(j))^2+(f(n)-f(i))^2)^3);
                    Xgravity(n,m)=Xgravity(n,m)+Xdg;
                    Ygravity(n,m)=Ygravity(n,m)+Ydg;
                end
            end
        end
    end
    n
end
Gra=max(max(max(abs(Xgravity))),max(max(abs(Ygravity))));
Xgravity=Xgravity/Gra;
Ygravity=Ygravity/Gra;

%-------生成游标点N个-----------
N=100;
for i=1:N
    poi(i)=struct('t',0,'f',0,'vt',0,'vf',0,'af',0,'at',0);
    poi(i).t=rand(1)*length(t0);
    poi(i).f=rand(1)*length(f0);
end

[T,F]=hhh(t,f);

M=4000;
for time=1:M
    for i=1:length(poi)
    
    % 在快完的时候调低系数进行收敛   
        if time==round(M/1.1)
            C=2.5;
            G=0.01;
        end  
%     %郎之万方程
        FX=C*interp2(T,F,Xgravity,poi(i).t,poi(i).f);
        FY=C*interp2(T,F,Ygravity,poi(i).t,poi(i).f);
        poi(i).at=-B*poi(i).vt+FX;
        poi(i).af=-B*poi(i).vf+FY;
        poi(i).vt=poi(i).vt+poi(i).at+G*C*(rand(1)-0.5);
        poi(i).vf=poi(i).vf+poi(i).af+G*C*(rand(1)-0.5);
        poi(i).t=poi(i).t+poi(i).vt;
        poi(i).f=poi(i).f+poi(i).vf;
    end
    
  
     
    
    %合并接近点,取消跑出去的点
    eli=[];
    for j=1:length(poi)
        for k=j+1:(length(poi))
            if (poi(j).t-poi(k).t)^2+(poi(j).f-poi(k).f)^2<(length(t0)/60)^2
                eli=[eli,k];
            end
        end
        if poi(j).t>max(t)||poi(j).t<min(t)||poi(j).f>max(f)||poi(j).f<min(f)
            eli=[eli,j];
        end
    end
    
    poi(eli)=[];
    

%     if mod(time,100)==0
%         figure
%         contourf(t,f,s0)
%         hold on
%         for z=1:length(poi)
%             plot(poi(z).t,poi(z).f,'color',selcolor(z),'marker','x','markersize',20)
%         end
%     end

end

for i=1:length(poi)
    poi(i).t=Ct*poi(i).t+min(t0);
    poi(i).f=Cf*poi(i).f+min(f0);
end



end

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