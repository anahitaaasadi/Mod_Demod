clc;
clear all;
close all;

fs = 400;
fc = 100;
fm = 4;

dt = 1/fs;
t = 0:dt:1-dt;

m = cos(2*pi*fm*t);
mh = imag(hilbert(m));
s = m.*cos(2*pi*fc*t) + mh.*sin(2*pi*fc*t);

subplot (3,1,1);
plot (t,m);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Message Signal');
subplot (3,1,2);
plot (t,mh);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Hilber Transform of Message Signal');
subplot (3,1,3);
plot (t,s);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Modulated Signal');

M = fftshift(fft(m));
MH = fftshift(fft(mh));
S = fftshift(fft(s));
f = -fs/2:1:fs/2-1;

figure
subplot(3,1,1)
plot(f,abs(M)/fs);
title('Freq. Spectrum of Message Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
subplot(3,1,2)
plot(f,abs(S)/fs);
title('Freq. Spectrum of Modulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

r_lo = s.*cos(2*pi*fc*t);
[b,a] = butter(10,2*fc/fs);
r_flt = filter(b,a,r_lo);
R_flt = fftshift(fft(r_flt));
subplot(3,1,3)
plot(f,abs(R_flt)/fs);
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
plot(t,2*r_flt)
xlabel('Time(s)')
ylabel('Amplitude')
title('Demodulated Signal')