clc;
clear all;
close all;

Fs = 400;
dt = 1/Fs;
t = 0:dt:1-dt;
fm = 4;
fc = 100;
a = 2;
% mod_index = 1.5;
mod_index = 0.5;
m = cos(2*pi*fm*t);
c = a*cos(2*pi*fc*t);
s = (1 + (mod_index.*m)).*c;
subplot(3,1,1)
plot(t,m);
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Message Signal')
subplot(3,1,2)
plot(t,c)
xlabel('Time');
ylabel('Carrier Signal');
subplot(3,1,3)
plot(t,s,t,a.*(1+(mod_index)*m),t,a.*(-1-(mod_index)*m),'r');
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Modulated Signal')

M = fftshift(fft(m));
S = fftshift(fft(s));
f = -Fs/2:1:Fs/2-1;
figure
subplot(3,1,1)
plot(f,abs(M)/Fs);
title('Freq. Spectrum of Message')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
subplot(3,1,2)
plot(f,abs(S)/Fs);
title('Freq. Spectrum of Modulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
r_env = abs(s);
[b,a] = butter(10,2*fc/Fs);
r_flt = filter(b,a,r_env);
R_flt = fftshift(fft(r_flt));
subplot(3,1,3)
plot(f,abs(R_flt)/Fs);
title('Freq. Spectrum of Demodulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

figure
subplot(2,1,1)
plot(t,r_env);
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Envelope of Modulated Signal')
subplot(2,1,2)
plot(t,2*(r_flt-1))
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Demodulated Signal')