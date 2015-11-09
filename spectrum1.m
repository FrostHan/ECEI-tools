function spectrum1(y,Fs)
%This function is to draw a plot of fft(y)
%y is the signals of frequency Fs(HZ)
%by HDQ

T=1/Fs; %sample time
L=length(y);% Length of signal
NFFT=2^nextpow2(L);
Y=fft(y,NFFT)/L;
f=Fs/2*linspace(0,1,NFFT/2+1);

plot(f,2*abs(Y(1:NFFT/2+1)));
title('Single-Sided Amplityde Spectrum of y(t)');
xlabel('Frequency (HZ)');
ylabel('|Y(f)|');

end