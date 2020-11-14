function showSpectrum(sig,Fs)
    figure()
    spectrogram(sig,1024,[],1024,Fs,'yaxis');
end
