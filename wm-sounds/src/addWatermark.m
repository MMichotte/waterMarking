function status = addWatermark(file_path)
    %-----------------------------------
    %-- Imports
    load('src/config/watermark.mat');
    addpath('src/helpers/');
    
    %-----------------------------------
    %-- Parsing file path
    [filePath,fileName] = fileparts(file_path);
    
    %-----------------------------------
    %-- Retrieving Input Signal (to be watermarked) :
    [s, Fs] = audioread(file_path);
    input_sig = s(:,1)';
    input_sig_lenght = length(input_sig);
    input_sig_duration = input_sig_lenght/Fs;
    input_sig_duration_ms = fix(input_sig_duration*10000);
    input_sig_duration_ms_bin = de2bi(input_sig_duration_ms,prefixLen,'right-msb');
    
    if input_sig_duration >= 24*3600
        status = 'ERROR: signal must be < than 24h!';
        return
    end
    
    %sound(input_sig,Fs);
    %showSpectrum(input_sig,Fs);
    %showFFT(input_sig,Fs);
    
    %-----------------------------------
    %-- Creating Watermark signal :
    t = 0:1/Fs:input_sig_duration;
    t = t(1:length(t)-1);
    wm_sig = wm_amplitude * sin(2*pi*wm_freq.*t);
    
    %-- add prefix data :
    wm_sig = [input_sig_duration_ms_bin*prefixAmplitude,wm_sig];
       
    %%-----------------------------------
    %-- Cleaning input sound at WM frequency :
    [b,a] = butter(5,Fc/(Fs/2),'high');
    %freqz(b,a)
    

    %-- Applying filter
    filtered_input_sig = filter(b,a,input_sig);
    %showSpectrum(filtered_input_sig,Fs);

    %-----------------------------------
    %-- Applying Watermark :
    filtered_input_sig = [zeros(1,prefixLen),filtered_input_sig];
    output_sig = filtered_input_sig + wm_sig;
    
    %sound(output_sig,Fs);
    %showSpectrum(output_sig,Fs);
    %showFFT(output_sig,Fs);

    %-----------------------------------
    %-- Outputing watermarked sound :
    
    %audiowrite(sprintf('sounds/output/%s.wav',fileName),output_sig,Fs);
    audiowrite(sprintf('%s/%s_wm.wav',filePath,fileName),output_sig,Fs);
    status = 'Signal successfully marked!';
end
