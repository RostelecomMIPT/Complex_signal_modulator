function [ AutoCorr, Position ] = TimeSync( IQ_Ts_Unshifted, Nfft )
    for k = 1 : length(IQ_Ts_Unshifted) - Nfft/16 - Nfft
        Up = sum (IQ_Ts_Unshifted(k : k + Nfft/16).*...
            conj(IQ_Ts_Unshifted(k + Nfft : k + Nfft + Nfft/16)));
        Down1 = sum(IQ_Ts_Unshifted(k : k + Nfft/16).*...
            conj(IQ_Ts_Unshifted(k : k + Nfft/16)));
        Down2 = sum(IQ_Ts_Unshifted(k + Nfft : k + Nfft + Nfft/16).*...
            conj(IQ_Ts_Unshifted(k + Nfft : k + Nfft + Nfft/16)));
        AutoCorr(k) = abs(Up/sqrt(Down1*Down2));
    end
%     plot(AutoCorr);
%     hold on;
    for k = 1 : fix(length(IQ_Ts_Unshifted)/(Nfft + Nfft/8)) - 1
        [ EmptyAmp, Position(k)] = max(...
            AutoCorr(...
            (k-1)*(Nfft + Nfft/8) + 1 : k*(Nfft + Nfft/8) + 1));
    end
    Position = fix(sum(Position)/...
        (fix(length(IQ_Ts_Unshifted)/(Nfft + Nfft/8)) - 1));
%     plot(Position, AutoCorr(Position),'*');
end

