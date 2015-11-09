function [data,t]=loadeceim_h(shot,Ranchannel,Ranrow,Time,FS,step)
if ~exist('FS','var'),
    FS=1e6;
end
%------------------------------LOADDATA------------------------------------
data=zeros(length(Ranchannel),length(Ranrow),round(round((Time(2)-Time(1))*FS)/step));
for i=1:length(Ranchannel)
    Channel=Ranchannel(i);
    for j=1:length(Ranrow)
        Row=Ranrow(j);
        tmp=loadecei1(shot,Channel,Row,Time,FS);
        tmp=smooth(tmp,10);
        tmp=tmp(1:step:end);
        for m=1:length(tmp)
            data(i,j,m)=tmp(m,1);
        end
    end
end
t=linspace(Time(1),Time(2),size(data,3));
%--------------------------------------------------------------------------
if ~exist('step','var')
step=100;
end
if nargout==0
    num=1;
%     figure

    [m,n,~]=size(data);
    for i=1:m
        for j=1:n
            p=subposition(n,m,num);
            if m>n
                p=subposition(m,n,num);
            end
            tmp=squeeze(data(i,j,:));
%             tmp=smooth(tmp,100);
            subplot('position',p)
            plot(t,smooth(tmp,50))
            grid on
            axis tight
            xlabel('Time/s','fontsize',12)
            ylabel([int2str(Ranchannel(i)),'-',int2str((Ranrow(j)))],'fontsize',12)
            num=num+1;
        end
    end
    xaxislock
    picdir=['D:\matlab\',int2str(shot),'\','picture'];
    if ~exist(picdir,'dir');mkdir(picdir);end
    saveas(gcf,[picdir,'\','row',num2str(Ranrow(1)),'-',num2str(Ranrow(length(Ranrow))),'ch',num2str(Ranchannel(1)),'-',num2str(Ranchannel(length(Ranchannel))),'Time',num2str(Time(1)),'s-',num2str(Time(2)),'s.jpg'],'jpg')
end
% set(gcf,'position',[ 9 71 1265,644])
% gtext(['Shot  #',int2str(shot)],'fontsize',14)

            