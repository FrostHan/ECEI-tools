function [S,F,T]=eceispectrogram(shot,time,freqrange,fs)
%This funtion is to create a spectrogram for ecei,which is the sum of 
%spectrograms of every channels and rows,
%freqrange is the range of frequency we care
%fs is signal frequecy of ecei
%by hdq

[data0,~]=loadecei1(shot,12,11,time,fs);
R=floor(fs/freqrange(2)/2);

fs2=floor(fs/R);

[pdata,~]=loadeceim_h(shot,1:24,1:16,time,fs,R);
for i=1:24
    for j=1:16
        if max(pdata(i,j,:))-min(pdata(i,j,:))<0.1
            pdata(i,j,:)=pdata(i,j,:)-pdata(i,j,:);
        else
            pdata(i,j,:)=pdata(i,j,:)/mean(pdata(i,j,:));
        end
    end
end



rdata0=resample1(data0,R);
rdata0=rdata0-mean(rdata0);%eliminate low frequency part

nfft=floor(sqrt(length(rdata0)))*2;

[S,F,T]=spectrogram(rdata0,nfft,nfft/2,nfft,fs2);
S=abs(S);

for i=1:24
    for j=1:16
        rdata=pdata(i,j,:);
        rdata=rdata-mean(rdata);%eliminate low frequency part
        [P,~,~]=spectrogram(rdata,nfft,nfft/2,nfft,fs2);
        if i~=12||j~=11
            S=S+abs(P);
        end
    end
end

%
a=floor(length(F)*(freqrange(1)/freqrange(2)));
S=S(a:end,:);
F=F(a:end);
T=T+time(1);


if nargout==0
    figure
    contourf(T,F,log(abs(S)),80,'linestyle','none');
    xlabel('time/s')
    ylabel('frequency/Hz')
    title(['shot',int2str(shot)])
end

end