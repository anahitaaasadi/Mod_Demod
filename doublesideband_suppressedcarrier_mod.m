clc;
clear all;
close all;

Fs = 400;
fc = 100;
fm = 4;
dt = 1/Fs;
t = 0:dt:1-dt;
a = 2;

m = cos(2*pi*fm*t);
c = a.*cos (2*pi*fc*t);
s = m.*c;

subplot (3,1,1);
plot (t,m);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Message Signal');
subplot (3,1,2);
plot (t,c);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Carrier Signal');
subplot (3,1,3);
plot (t,c);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Carrier Signal');
subplot (3,1,2);
plot (t, s, t, a*m ,t, -a*m, 'r');
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Modulated Signal');

M = fftshift(fft(m));
C = fftshift(fft(c));
S = fftshift(fft(s));
f = -Fs/2:1:Fs/2-1;

figure
subplot(4,1,1)
plot(f,abs(M)/Fs);
title('Freq. Spectrum of Message Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
subplot(4,1,2)
plot(f,abs(C)/Fs);
title('Freq. Spectrum of Carrier Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
subplot(4,1,3)
plot(f,abs(S)/Fs);
title('Freq. Spectrum of Modulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
r_lo = s.*c;
[b,a] = butter(10,2*fc/Fs);
r_flt = filter(b,a,r_lo);
R_flt = fftshift(fft(r_flt));
subplot(4,1,4)
plot(f,abs(R_flt)/Fs);
title('Freq. Spectrum of Demodulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

figure
subplot(2,1,1)
plot(t,abs(s));
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Envelope of Modulated Signal')
subplot(2,1,2)
plot(t,r_flt/2)
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Demodulated Signal')