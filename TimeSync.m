function [ Positions ] = TimeSync( IQ_Ts_Unshifted, Nfft )
    MedIQ = [ zeros(1,Nfft/16) IQ_Ts_Unshifted zeros(1,Nfft/16)];
    for k = 1 : length(MedIQ) - Nfft - Nfft/16
        Up(k) = MedIQ(k)*MedIQ(k + Nfft);
        Down1 = MedIQ(k);
        Down2 = MedIQ(k + Nfft);
        for l = 2 : Nfft/16
            Up(k) = Up(k) + MedIQ(l + k - 1)*...
                    MedIQ(l + Nfft + k - 1);
            Down1 = Down1 + MedIQ(l + k - 1)*...
                        MedIQ(l + k - 1);
            Down2 = Down2 + MedIQ(l + Nfft + k - 1)*...
                        MedIQ(l + Nfft + k - 1);
            AutoCorr(k) = Up(k)/sqrt(Down1*Down2);
        end
    end
    plot(abs(AutoCorr));
    z=0;
end

