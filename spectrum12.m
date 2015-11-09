function spectrum1(y,Fs)
%This function is to draw a plot of fft(y)
%y is the signals of frequency Fs(HZ)
%by HDQ

T=1/Fs; %sample time
L=length(y);% Length of signal
Y=fft(y)/L;
f=Fs/2*linspace(0,1,L);

plot(f,2*abs(Y));
title('Single-Sided Amplityde Spectrum of y(t)');
xlabel('Frequency (HZ)');
ylabel('|Y(f)|');

end