function result = checkIntegrity(filePath)
    %-----------------------------------
    %-- Imports
    load('src/config/watermark.mat');
    addpath('src/helpers/');
    
    %-----------------------------------
    % Retrieving Input Signal 
    [s,Fs] = audioread(filePath);
    input_sig = s(:,1)';
  
    % Retrieving prefix information
    prefix = int16(input_sig(1,1:prefixLen)*1/prefixAmplitude);
    prefix = prefix./max(prefix);
    signal = input_sig(1,prefixLen+1:end);
    try 
        sig_initial_duration = bi2de(prefix);
        sig_initial_duration = double(sig_initial_duration) / 1000000;
    catch error
        %fprintf('error at stage 1 :'); disp(error);
        result = 'the signal has been altered !';
        return
    end
 
    % Recreating original watermark:
    t = 0:1/Fs:sig_initial_duration;
    wm_sig = wm_amplitude * sin(2*pi*wm_freq.*t);
    
    %-----------------------------------
    % Retrieving watermark from signal
    % Creating passe-bas filter
    [b,a] = butter(5,Fc/(Fs/2),'low');

    % Applying filter
    wm_extracted = filter(b,a,signal);
    
    %showSpectrum(wm_extracted,Fs);
    %showSpectrum(wm_sig,Fs);
   
    %-----------------------------------
    % Check Correlation 
    
    try
        %showCorr(wm_extracted,wm_sig);
        correlation = corr2(wm_sig,wm_extracted);
        if correlation(1) < 0.98
            result = 'the signal has been altered !';
            return
        else
            result = 'the signal is authentic !';
            return
        end
    catch error
        %fprintf('error at stage 2 :'); disp(error);
        result = 'the signal has been altered !';
        return
    end
end
