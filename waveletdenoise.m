function xd=waveletdenoise(data,lev,base)

x=data;

wname = base;
[c,l] = wavedec(x,lev,wname);

% Use wdcbm for selecting level dependent thresholds  
% for signal compression using the adviced parameters.
alpha = 3; m=l(1);
[thr,~] = wdcbm(c,l,alpha,m);

[xd,~,~,perf0,perfl2] =  wdencmp('lvd',c,l,wname,lev,thr,'h');

if nargout==0;
    subplot(211), plot(x), title('Original signal');
    subplot(212), plot(xd), title('De-noised signal');
    xlab1 = ['2-norm rec.: ',num2str(perfl2)];
    xlab2 = [' %  -- zero cfs: ',num2str(perf0), ' %'];
    xlabel([xlab1 xlab2]);
end

end