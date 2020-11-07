clear all; close all; clc;

load('watermark.mat');

%-----------------------------------
% Retrieving Input Signal 
[s2,Fs2] = audioread('sounds/output.wav');
input_sig2 = s2(:,1)';
input_sig2_lenght = length(input_sig2);
input_sig2_duration = input_sig2_lenght/Fs2;


%-----------------------------------
% Retrieving watermark from signal
% Creating bandpass filter
[b,a] = butter(4,[wm_freq-0.1,wm_freq+0.1],'bandpass');

% Applying filter
WM = filter(b,a,input_sig2);

% Check Correlation 
[c,lags] = xcorr(wm_sig,WM);

figure(1)
stem(lags,c);


% Retrieving Input Signal 
[s2,Fs2] = audioread('sounds/output2.wav');
input_sig2 = s2(:,1)';
input_sig2_lenght = length(input_sig2);
input_sig2_duration = input_sig2_lenght/Fs2;


%-----------------------------------
% Retrieving watermark from signal
% Creating bandpass filter
[b,a] = butter(4,[wm_freq-0.1,wm_freq+0.1],'bandpass');

% Applying filter
WM = filter(b,a,input_sig2);

% Check Correlation 
[c,lags] = xcorr(wm_sig,WM);

figure(2)
stem(lags,c);
