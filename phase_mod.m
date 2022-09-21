clc;
clear all;
close all;

t=0:.0000001:.03;
fm=400;
fc=1000;
td=pi/2;

mt = cos(2*fm*pi*t);

subplot(3,1,1)
plot(t,mt)
xlabel('Time'); ylabel('Message Signal');

mc = cos(2*fc*pi*t);
subplot(3,1,2)
plot(t,mc)
xlabel('Time'); ylabel('Carrier Signal');

dmt = diff(mt);
z=zeros(1,length(t));
for i=1:(length(t)-1)
    z(i+1)=dmt(i);
end

tm = td*mt;
kt = td/(2*pi);
freq = fc + kt.*z;
theta = 2*pi*freq.*t + tm;
st = cos(theta);
subplot(3,1,3)
plot(t,st)
xlabel('Time'); ylabel('PM');

fs = 1000;
dt = 1/fs;
t = 0:dt:1-dt;

mt = cos(2*pi*fm*t);
dmt = diff(mt);
z=zeros(1,length(t));
for i=1:(length(t)-1)
    z(i+1)=dmt(i);
end
tm = td*mt;
freq = fc + kt.*z;
theta = 2*pi*freq.*t + tm;
st = cos(theta);

f = -fs/2:1:fs/2-1;
M = fftshift(fft(mt));
S = fftshift(fft(st));

figure
title('Frequency Domain Representation of the Signals')
subplot(2,1,1)
plot(f,abs(M)/fs);
title('Freq. Spectrum of Message')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
subplot(2,1,2)
plot(f,abs(S)/fs);
title('Freq. Spectrum of Modulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')