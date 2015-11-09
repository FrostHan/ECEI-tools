function [pkloc,modifiedddata]=findsawpeaks(data,sawtoothlength,method,maxmin,peaknumber)
%This function is to find the peaks's location of sawtooth data,designed for ECEI.
%It is suitable for steady signals having sawtooth
%sawtoothlength must be estimated by youself.
%sawtoothlength=[sawtoothlength_min,..._max]
%
%The other inputs is not necessary  
%
%If maxmin=0,then it will find peaks ,elseif maxmin=1, it will find valleys,
%else it will automatically choose a better one.
%
%different methods are for denoising,1 is smooth,2 is lowpass,3 is
%wavelet,default is 1
%
%if peaks are not in the range of peaknumber,there will be a warning
%
%pkloc is a vector of locations of peaks of data,for example ,
%data(pkloc(n)) is the nth peak of data
%modifiedddata is the data having been denoised.
%
%need other programes of ECEI 
%
%Key Laboratory of Plasma Physics,CAS

if ~exist('peaknumber','var')
    peaknumber=[floor(length(data)/sawtoothlength(2)),floor(length(data)/sawtoothlength(1))];
end

if ~exist('method','var')
    method=1;
end

if ~exist('maxmin','var')
    maxmin=2;
end
    

if method ==1
    data2=smooth(data,1000);
    modifiedddata=data2;
end

if method ==2
    [b,a,~]=filter_l(0.5e5);
    data1=filtfilt(b,a,data);
    data2=smooth(data1,200);
    modifiedddata=data2;
end

if method ==3
    data2=smooth(data,200);
    data2=waveletdenoise(data2,5,'sym1');
    modifiedddata=data2;
end
% data=smooth(data,200);
% plot(data);

%if the maxium value in a window of data is in the middle,then it is the
%peak.

%------------------find peaks--------------------
n=5; %numbers of windowintervals of each window

windowlength=floor(sawtoothlength(1)*0.8);
windowinterval=windowlength/n;
kk=1;%counter

% pkloc1(1)=1;
% pkloc1(2)=1+floor(mean(sawtoothlength));
% pkloc2(1)=1;
% pkloc2(2)=1+floor(mean(sawtoothlength));
t=windowinterval/windowlength;

%max
for k=1:windowinterval:(length(data2)-windowlength);
   
    [~,maxind]=max(data2(k:(k+windowlength-1)));
    if (floor(0.5*windowlength-windowinterval/2)<=maxind)&&(maxind<=floor(0.5*windowlength+windowinterval/2))
        pkloc1(kk)=maxind;
        pkloc1(kk)=pkloc1(kk)+k+1; 
        kk=kk+1;
    end
end

%min
for k=1:windowinterval:(length(data2)-windowlength);
   
    [~,minind]=min(data2(k:(k+windowlength-1)));
    if (floor(0.5*windowlength-windowinterval/2)<=minind)&&(minind<=floor(0.5*windowlength+windowinterval/2))
        pkloc2(kk)=minind;
        pkloc2(kk)=pkloc2(kk)+k+1; 
        kk=kk+1;
    end
end

if maxmin==0
    pkloc=pkloc1;
elseif maxmin==1
    pkloc=pkloc2;
else
    if std(diff(pkloc1))<std(diff(pkloc2))
        pkloc=pkloc1;
    else
        pkloc=pkloc2;
    end
end


if length(pkloc)<peaknumber(1)||length(pkloc)>peaknumber(2)
    warning('not realiable');
end


if nargout==0
    plot(1:length(data),modifiedddata,'b-',pkloc,modifiedddata(pkloc),'r+','markersize',15);
end
% if max(diff(pkloc))>sawtoothlength(2)
%     warning([No,'not reliable']);
%     pkloc=modifypkloc(pkloc,sawtoothlength);
% end
%

end

% function pkloc2=modifypkloc(pkloc,sawtoothlength)
% 
% pkloc2=pkloc;
% for i=1:floor((length(pkloc)-1)/1.4)
%     ll=pkloc(i+1)-pkloc(i);
%     nn=floor(ll/sawtoothlength(2)+1);
%     if nn>1
%         for j=1:nn-1
%         newloc(j)=pkloc(i)+floor(ll/nn)*j;
%         end
%         pkloc2=[pkloc2,newloc];
%     end
% end
%     pkloc2=sort(pkloc2,'ascend');
% end

