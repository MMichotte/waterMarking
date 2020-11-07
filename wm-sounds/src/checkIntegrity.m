clear all; close all; clc;

a = integrityCheck('sounds/modified/troll_inverted.wav')
b = integrityCheck('sounds/modified/troll_amplified.wav')
c = integrityCheck('sounds/modified/troll_accelerated.wav')
d = integrityCheck('sounds/modified/troll_unchanged.wav')


function result = integrityCheck(filePath)
    load('src/watermark.mat');
  
    %-----------------------------------
    % Retrieving Input Signal 
    [s,Fs] = audioread(filePath);
    input_sig = s(:,1)';

    %-----------------------------------
    % Retrieving watermark from signal
    % Creating bandpass filter
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
        lowestCorr = min(correlation);
        if lowestCorr(1) < 0.99
            result = 'the signal has been altered !';
        else
            result = 'the signal is authentic !';
        end
    catch error
        %disp(error);
        result = 'the signal has been altered !';
    end
end






