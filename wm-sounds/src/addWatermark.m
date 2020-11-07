clear all; close all; clc;

%{
Objectif : 

Modifier tous les n bits du signal d'entrée par un bit du WM et ce
à une fréquence donnée du signal (par exemple 0.5Hz). 

solution : 
- supprimer le son à une fréquence X
- ajouter notre WM à cette fréquence X


%attention : son max de 24h! => 32 premier bits du WM = temps du son

%}

watermark('sounds/troll.mp3');
%watermark('sounds/saucisse.mp3'); 

function status = watermark(file_path)
    %-----------------------------------
    %-- Watermark configuration :
    prefixLen = 50; %soit max 24h de son
    prefixAmplitude = 0.001;
    wm_freq = 0.5; % must be below 20Hz to not be hearable by a human. 
    wm_amplitude = 0.5;
    Fc = 10; % LowPass Filter freq
    save('src/watermark.mat','wm_freq','wm_amplitude','Fc','prefixLen','prefixAmplitude');
    
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
    %sound(input_sig,Fs);
    
    if input_sig_duration >= 24*3600
        status = 'ERROR: signal must be < than 24h!'
        return
    end
    
    %{
    %-- spectrogram
    figure()
    spectrogram(input_sig,1024,[],1024,Fs,'yaxis');

    %-- fft
    input_fft = fft(input_sig);
    P2 = abs(input_fft/input_sig_lenght);
    P1 = P2(1:input_sig_lenght/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    f = Fs*(0:(input_sig_lenght/2))/input_sig_lenght;
    figure()
    plot(f,P1);
    %}
    
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
    %figure()
    %spectrogram(filtered_input_sig,1024,[],1024,Fs,'yaxis');

    %-----------------------------------
    %-- Applying Watermark :
    filtered_input_sig = [zeros(1,prefixLen),filtered_input_sig];
    output_sig = filtered_input_sig + wm_sig;
    %sound(output_sig,Fs);

    %{
    figure()
    spectrogram(output_sig,1024,[],1024,Fs,'yaxis');

    %fft
    input_fft = fft(filtered_input_sig);
    P2 = abs(input_fft/input_sig_lenght);
    P1 = P2(1:input_sig_lenght/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    f = Fs*(0:(input_sig_lenght/2))/input_sig_lenght;
    figure()
    plot(f,P1);
    %}

    %-----------------------------------
    %-- Outputing watermarked sound :
    
    audiowrite(sprintf('sounds/output/%s.wav',fileName),output_sig,Fs);
    status = 'Signal successfully marked!'
end
