clear myAudioObject dataaudio;%, close Time-domain;

myAudioObject = audiorecorder(4800,16,1);
disp('Recording...');
recordblocking(myAudioObject,2);
disp('Recorded completed.');
play(myAudioObject);
dataAudio = getaudiodata(myAudioObject);

plot(dataAudio),set(gcf,'NumberTitle','off', 'Name','Time-domain my audio');

%% Prisoneros proofs

[y Fs]=audioread('prisioneros.mp3');
ti=0;
tf=20;
t=ti*Fs+1:1:tf*Fs;
ys=y(t,:)';
figure;
set(gcf,'NumberTitle','off');
set(gcf, 'Name','Canci�n prisioneros (1000 muestras)');
plot(t,ys(1,:),'b',t,ys(2,:),'r'),grid on;
axis([1e4 1.01e4 -0.25 0.25]),hold on;

%FILTER_01 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 8.3 and the Signal Processing Toolbox 6.21.
% Generated on: 15-Nov-2018 07:28:58

% Equiripple Lowpass filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 44100;  % Sampling Frequency

Fpass = 1000;            % Passband Frequency
Fstop = 1200;            % Stopband Frequency
Dpass = 0.057501127785;  % Passband Ripple
Dstop = 0.0001;          % Stopband Attenuation
dens  = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);

% [EOF]


yt=filter(numE,denE,xt);


%% Tabaco y chanel proofs

[y Fs]=audioread('tabacoychannel.mp3');
ti=0;
tf=120;
t=ti*Fs+1:1:tf*Fs;
ys=y(t,:)';
figure;
set(gcf,'NumberTitle','off');
set(gcf, 'Name','Tabaco y channel');
plot(t,ys(1,:),'b',t,ys(2,:),'r'),grid on;
%axis([1e4 1.01e4 -0.25 0.25]),hold on;


%% Prisioneros proofs

[y Fs]=audioread('prisioneros.mp3');
ti=0;
tf=60;
t=ti*Fs+1:1:tf*Fs;
ys=y(t,:)';
figure;
set(gcf,'NumberTitle','off');
set(gcf, 'Name','Canci�n prisioneros');
plot(t,ys(1,:),'b',t,ys(2,:),'r'),grid on;
%axis([1e4 1.01e4 -0.25 0.25]),hold on;

%% FDA proofs and extraction
d = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',0.5,1,3,4,80,0.5,80,50);
Hd = design(d,'butter');




