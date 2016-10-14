function [ AutoCorr ] = TimeSync( IQ_Ts_Unshifted, Nfft )
    MedIQ = IQ_Ts_Unshifted;
    for k = 1 : length(MedIQ) - Nfft/8 - Nfft
        Up = 0;
        Down1 = 0;
        Down2 = 0;
        for l = 1 : Nfft/16
            Up = Up + MedIQ(l + k - 1)*...
                    (MedIQ(l + k - 1 + Nfft))';
            Down1 = Down1 + MedIQ(l + k - 1)*...
                        (MedIQ(l + k - 1))';
            Down2 = Down2 + MedIQ(l + k - 1 + Nfft)*...
                        (MedIQ(l + k - 1 + Nfft))';
        end
        AutoCorr(k) = Up/sqrt(Down1*Down2);
    end
    plot(abs(AutoCorr))
    z=0;
end

