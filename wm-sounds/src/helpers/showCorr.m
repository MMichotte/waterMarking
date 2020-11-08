function showCorr(sig1,sig2)
    [c,lags] = xcorr(sig1,sig2);
    figure();
    stem(lags,c);
end