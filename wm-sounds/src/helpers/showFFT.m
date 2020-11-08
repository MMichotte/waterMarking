function showFFT(sig,Fs)
    sig_len = length(sig);
    sig_fft = fft(sig);
    P2 = abs(sig_fft/sig_len);
    P1 = P2(1:sig_len/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    f = Fs*(0:(sig_len/2))/sig_len;
    figure()
    plot(f,P1);
end
