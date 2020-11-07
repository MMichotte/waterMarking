clear all; close all; clc;

load('watermark.mat');

%-----------------------------------
% Retrieving Input Signal 
%[s,Fs] = audioread('sounds/modified/output_notModified.wav');
[s,Fs] = audioread('sounds/modified/output_inverted.wav');
input_sig = s(:,1)';
input_sig_lenght = length(input_sig);
input_sig_duration = input_sig_lenght/Fs;


%-----------------------------------
% Retrieving watermark from signal
% Creating bandpass filter
Fc = 10;
[b,a] = butter(4,Fc/(Fs/2),'low');

% Applying filter
WM = filter(b,a,input_sig)';
wm_sig = wm_sig';

%{
figure();
spectrogram(WM,1024,[],1024,Fs,'yaxis');
figure();
spectrogram(wm_sig,1024,[],1024,Fs,'yaxis');
%}

%-----------------------------------
% Check Correlation 

%[c,lags] = xcorr(wm_sig,WM);
%figure();
%stem(lags,c);

try
    correlation = corrcoef(wm_sig,WM);
    lowestCorr = min(correlation)
    if lowestCorr(1) < 0.99
        fprintf('the signal has been altered !\n');
    else
        fprintf('the signal is authentic !\n');
    end
catch error
    fprintf('the signal has been altered !\n');
end




