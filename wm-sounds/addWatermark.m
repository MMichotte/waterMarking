clear all; close all; clc;

%{
Objectif : 

Modifier tous les n bits du signal d'entrée par un bit du WM et ce
à une fréquence donnée du signal (par exemple 0.5Hz). 

%}


%-----------------------------------
% Retrieving Input Signal (to be watermarked) :
[s, Fs] = audioread('sounds/troll.mp3');
%[s, Fs] = audioread('sounds/saucisse.mp3');
input_sig = s(:,1)';
input_sig_lenght = length(input_sig);
input_sig_duration = input_sig_lenght/Fs;
%sound(input_sig,Fs);

%spectrogram
figure(1)
spectrogram(input_sig,1024,[],1024,Fs,'yaxis');

%fft
input_fft = fft(input_sig);
P2 = abs(input_fft/input_sig_lenght);
P1 = P2(1:input_sig_lenght/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(input_sig_lenght/2))/input_sig_lenght;
figure(2)
plot(f,P1);

%-----------------------------------
% Creating Watermark signal :
t = 0:1/Fs:input_sig_duration;
t = t(1:length(t)-1);
%f_wm = linspace(1000,10000,length(t)); %Hz
wm_freq = 0.5; %must be below 20Hz to not be hearable by a human. 
wm_amplitude = 0.5;
wm_sig = wm_amplitude * sin(2*pi*wm_freq.*t);
save('watermark.mat','wm_freq','wm_sig');

%-----------------------------------
% Applying Watermark :
output_sig = input_sig + wm_sig;
sound(output_sig,Fs);

figure(3)
spectrogram(output_sig,1024,[],1024,Fs,'yaxis');

%fft
input_fft = fft(input_sig);
P2 = abs(input_fft/input_sig_lenght);
P1 = P2(1:input_sig_lenght/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(input_sig_lenght/2))/input_sig_lenght;
figure(4)
plot(f,P1);


%-----------------------------------
% Outputing watermarked sound :
audiowrite('sounds/output.wav',output_sig,Fs);



%{
interval = 100; % interval between each bit change 
fprintf('elements: %d%%',input_sig_lenght/interval);

%copy of input_signal before applying WM. 
output_sig = input_sig;

%replace each bit of signal at interval with bit of WM : 
output_sig(interval:interval:end) = wm_sig(interval:interval:end); 

sound(output_sig,Fs);

figure(2)
spectrogram(output_sig,1024,[],1024,Fs,'yaxis');
[oS,oF, oT, oP] = spectrogram(output_sig,1024,[],1024,Fs,'yaxis');



%output_sig = input_sig + wm_sig;
%sound(output_sig,Fs);
%audiowrite('sounds/troll_wm.wav',output_sig,Fs);



%sptool;

%load('sig2.mat');
%figure(3)
%spectrogram(sig2.data,1024,[],1024,Fs,'yaxis');
%[S,F,T,P] = spectrogram(sig2.data,1024,[],1024,Fs,'yaxis');




%}

