clc;
clear all;
close all;

a = 2;
fm = 10;
fc = 100;
delta_f = 100;
kf = delta_f/fm;

fs = 1000;
dt = 1/fs;
t = 0:dt:1-dt;

m = cos(2*pi*fm*t);

m_b = tril(ones(length(m)));
m_c = m.*m_b;
sum_m = sum(m_c,2);
c = a*cos(2*pi*fc*t);
s = a*cos(2*pi*fc*t+(kf*2*pi*sum_m').*dt);

subplot(3,1,1)
plot(t,m)
ylim([-5 5])
xlabel ('Time(s)');
ylabel ('Amplitude');
title('Message and Modulated Signal')
subplot(3,1,2)
plot(t,c)
xlabel('Time');
ylabel('Carrier Signal');
title('Carrier Signal')
subplot(3,1,3)
plot(t,s);
xlabel ('Time(s)');
ylabel ('Amplitude');
title('Modulated Signal')

f = -fs/2:1:fs/2-1;
M = fftshift(fft(m));
S = fftshift(fft(s));

figure
title('Frequency Domain Representation of the Signals')
subplot(3,1,1)
plot(f,abs(M)/fs);
title('Freq. Spectrum of Message')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
subplot(3,1,2)
plot(f,abs(S)/fs);
title('Freq. Spectrum of Modulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

dem = diff(s);                 
dem = [0,dem];
r_lo = dem.*(cos(2*pi*fc*t));
[b,a] = butter(10,2*fc/fs);
r_flt = filter(b,a,r_lo);
R_flt = fftshift(fft(r_flt));

subplot(3,1,3)
plot(f,abs(R_flt)/fs);
title('Frequency Representation of the Demodulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

figure
subplot(2,1,1)
plot(abs(s))
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Envelope of Modulated Signal')
subplot(2,1,2)
plot(t,2*((r_flt)-0.1))
xlabel ('Time(s)');
ylabel ('Amplitude');
title('Demodulated Signal')