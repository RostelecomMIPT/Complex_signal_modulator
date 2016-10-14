function [ AutoCorr ] = TimeSync( IQ_Ts_Unshifted, Nfft )
    for k = 1 : length(IQ_Ts_Unshifted) - Nfft/16 - Nfft
%         for l = 1 : Nfft/16
%             Up = Up + IQ_Ts_Unshifted(l + k - 1)*...
%                     (IQ_Ts_Unshifted(l + k - 1 + Nfft))';
%             Down1 = Down1 + IQ_Ts_Unshifted(l + k - 1)*...
%                         (IQ_Ts_Unshifted(l + k - 1))';
%             Down2 = Down2 + IQ_Ts_Unshifted(l + k - 1 + Nfft)*...
%                         (IQ_Ts_Unshifted(l + k - 1 + Nfft))';
%         end
        Up = sum (IQ_Ts_Unshifted(k : k + Nfft/16).*...
            conj(IQ_Ts_Unshifted(k + Nfft : k + Nfft + Nfft/16)));
        Down1 = sum(IQ_Ts_Unshifted(k : k + Nfft/16).*...
            conj(IQ_Ts_Unshifted(k : k + Nfft/16)));
        Down2 = sum(IQ_Ts_Unshifted(k + Nfft : k + Nfft + Nfft/16).*...
            conj(IQ_Ts_Unshifted(k + Nfft : k + Nfft + Nfft/16)));
        AutoCorr(k) = Up/sqrt(Down1*Down2);
    end
    plot(abs(AutoCorr))
    z=0;
end

