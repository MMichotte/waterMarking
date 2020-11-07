clear all; close all; clc;

%{
Objectif : 

Modifier tous les n bits du signal d'entrée par un bit du WM et ce
à une fréquence donnée du signal (par exemple 0.5Hz). 

solution : 
- supprimer le son à une fréquence X
- ajouter notre WM à cette fréquence X

%}

watermark('sounds/troll.mp3');
%watermark('sounds/saucisse.mp3'); 

function watermark(file_path)
    %-----------------------------------
    %-- Parsing file path
    [filePath,fileName] = fileparts(file_path);
    
    %-----------------------------------
    %-- Retrieving Input Signal (to be watermarked) :
    [s, Fs] = audioread(file_path);
    input_sig = s(:,1)';
    input_sig_lenght = length(input_sig);
    input_sig_duration = input_sig_lenght/Fs;
    %sound(input_sig,Fs);
    
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
    wm_freq = 0.5; % must be below 20Hz to not be hearable by a human. 
    wm_amplitude = 0.5;
    wm_sig = wm_amplitude * sin(2*pi*wm_freq.*t);

    %%-----------------------------------
    %-- Cleaning input sound at WM frequency :
    Fc = 10; %Frequence de coupure 
    [b,a] = butter(5,Fc/(Fs/2),'high');
    %freqz(b,a)
    save('src/watermark.mat','wm_freq','wm_sig','Fc');

    %-- Applying filter
    filtered_input_sig = filter(b,a,input_sig);
    %figure()
    %spectrogram(filtered_input_sig,1024,[],1024,Fs,'yaxis');

    %-----------------------------------
    %-- Applying Watermark :
    output_sig = filtered_input_sig + wm_sig;
    sound(output_sig,Fs);

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
end
