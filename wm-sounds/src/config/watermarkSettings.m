clear all; close all; clc;

%-----------------------------------
%-- Watermark configuration :

% Number of bits added to the beginning of the sound to store WM-information:
prefixLen = 50;    
% Amplitude of the prefix bits (the lower the better) 
prefixAmplitude = 0.001; 

% Cutoff frequency for the HighPass filter
Fc = 10;

% Frequency of the watermark signal
% -> must be below 20Hz to not be hearable by a human and below Fc!
wm_freq = 0.5;  
% Amplitute of the watermark signal (the lower the better)
wm_amplitude = 0.5;


save('src/watermark.mat','prefixLen','prefixAmplitude','Fc','wm_freq','wm_amplitude');
