function rdata = resample1(data,R)

% resample the data by interval R
j=1;
num=floor(length(data)/R);
rdata=zeros(num,1);
for i=1:num
    rdata(i)=data(j);
    j=j+R;
    if j>length(data)
        j=length(data);
    end
end