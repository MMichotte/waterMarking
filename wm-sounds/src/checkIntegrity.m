clear all; close all; clc;

a = integrityCheck('sounds/modified/troll_inverted.wav')
b = integrityCheck('sounds/modified/troll_echo.wav')
c = integrityCheck('sounds/modified/troll_amplified.wav')
d = integrityCheck('sounds/modified/troll_accelerated.wav')
e = integrityCheck('sounds/modified/troll_shorten.wav')
f = integrityCheck('sounds/modified/troll_unchanged.wav')
g = integrityCheck('sounds/output/troll.wav')


function result = integrityCheck(filePath)
    load('src/watermark.mat');
    %-----------------------------------
    % Retrieving Input Signal 
    [s,Fs] = audioread(filePath);
    input_sig = s(:,1)';
    
    % Retrieving prefix information
    prefix = int16(input_sig(1,1:prefixLen)*1/prefixAmplitude);
    signal = input_sig(1,prefixLen+1:end);
    try 
        sig_initial_duration = bi2de(prefix);
        sig_initial_duration = double(sig_initial_duration) / 10000;
    catch error
        result = 'the signal has been altered !';
        return
    end
    
    % Recreating original watermark:
    t = 0:1/Fs:sig_initial_duration;
    wm_sig = wm_amplitude * sin(2*pi*wm_freq.*t);
    
    %-----------------------------------
    % Retrieving watermark from signal
    % Creating bandpass filter
    [b,a] = butter(4,Fc/(Fs/2),'low');

    % Applying filter
    wm_extracted = filter(b,a,signal)';
    
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
        correlation = corrcoef(wm_sig,wm_extracted);
        lowestCorr = min(correlation);
        if lowestCorr(1) < 0.99
            result = 'the signal has been altered !';
            return
        else
            result = 'the signal is authentic !';
            return
        end
    catch error
        %disp(error);
        result = 'the signal has been altered !';
        return
    end
end






