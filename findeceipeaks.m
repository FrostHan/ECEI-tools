function [pkloc,fd]=findeceipeaks(data,sawtoothlength,No,leastpeaknumber)
%This function is to find the peaks's location of data,for ECEI


if ~exist('leastpeaknumber','var')
    leastpeaknumber=floor(length(data)/sawtoothlength(2))-1;
end

%[b,a,~]=filter_l(0.5e5);
data1=smooth(data,1000);
%data1=filtfilt(b,a,data1);
% data2=waveletdenoise(data2,5,'sym1');
%data2=smooth(data1,100);
data2=data1;
fd=data2;


    
% data=smooth(data,200);
% plot(data);

%if the maxium value in a window of data is in the middle,then it is the
%peak.

n=5; %numbers of windowintervals of each window

windowlength=floor(min(sawtoothlength(2),sawtoothlength(1)*1.6));
windowinterval=floor(sawtoothlength(1)/n);
kk=1;%counter

pkloc1(1)=1;
pkloc1(2)=1+floor(mean(sawtoothlength));
pkloc2(1)=1;
pkloc2(2)=1+floor(mean(sawtoothlength));
%max
for k=1:windowinterval:(length(data2)-windowlength);
   
    [~,maxind]=max(data2(k:(k+windowlength-1)));
    if (floor((0.5-0.5/n)*windowlength)<maxind)&&(maxind<floor((0.5+0.5/n)*windowlength))
        pkloc1(kk)=maxind;
        pkloc1(kk)=pkloc1(kk)+k+1; 
        kk=kk+1;
    end
end

%min
for k=1:windowinterval:(length(data2)-windowlength);
   
    [~,minind]=min(data2(k:(k+windowlength-1)));
    if (floor(0.4*windowlength)<minind)&&(minind<floor(0.6*windowlength))
        pkloc2(kk)=minind;
        pkloc2(kk)=pkloc2(kk)+k+1; 
        kk=kk+1;
    end
end

%decide which is better
if std(diff(pkloc1))<std(diff(pkloc2))&&length(pkloc1)>leastpeaknumber
    pkloc=pkloc1;
elseif std(diff(pkloc2))<std(diff(pkloc1))&&length(pkloc2)>leastpeaknumber
    pkloc=pkloc2;
else
    warning([No,'not reliable']);
    pkloc=pkloc1;
end

% if max(diff(pkloc))>sawtoothlength(2)
%     warning([No,'not reliable']);
%     pkloc=modifypkloc(pkloc,sawtoothlength);
% end
%

end

function pkloc2=modifypkloc(pkloc,sawtoothlength)

pkloc2=pkloc;
for i=1:floor((length(pkloc)-1)/1.4)
    ll=pkloc(i+1)-pkloc(i);
    nn=floor(ll/sawtoothlength(2)+1);
    if nn>1
        for j=1:nn-1
        newloc(j)=pkloc(i)+floor(ll/nn)*j;
        end
        pkloc2=[pkloc2,newloc];
    end
end
    pkloc2=sort(pkloc2,'ascend');
end

