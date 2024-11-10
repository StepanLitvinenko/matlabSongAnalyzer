close all

clear


[data, fs] = audioread("audio_2024-11-01_22-30-41.ogg");

freq = -329.642;

% plot(data)

idexes = [71323:229093];

signal= data(idexes)';


time = (1:length(signal)).*1/fs;

sincosPrim = complex(cos(2*pi*freq*time), sin(2*pi*freq*time));

rawSig = signal;
signal = hilbert(signal);
signal = signal.*sincosPrim;


freqSecond = -freq;

sincosSecond = complex(cos(2*pi*freqSecond*time), sin(2*pi*freqSecond*time));

signal = signal.*sincosSecond;

figure()

spectr = fft(signal);
spectrAbs = abs(spectr);
freqs = -fs/2:fs/length(signal):fs/2;
freqs = freqs(1:end-1);

subplot(3,1,1);
plot(log10(spectrAbs));



spectrAbs = abs(spectr);

logAbsSpecter = log10(spectrAbs);

indecexEval = logAbsSpecter > 0.8;
spectrAbs = spectrAbs.*indecexEval;
hold on
plot(log10(spectrAbs));





hold off

subplot(3,1,2);

plot(real(signal));

signal = ifft(spectr.*indecexEval);

hold on 
plot(real(signal));
hold off
subplot(3,1,3);
plot(unwrap(diff(angle(spectr))));


 sound(real(signal), fs)

