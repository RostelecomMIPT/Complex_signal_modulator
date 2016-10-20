function [ AutoCorr, Position ] = TimeSync( IQ_Ts_Unshifted, Nfft,...
                                    LevelOfIncreasing )
    for k = 1 : length(IQ_Ts_Unshifted) - Nfft/16 - Nfft
        Up = sum (IQ_Ts_Unshifted(k : k + Nfft/16).*...
            conj(IQ_Ts_Unshifted(k + Nfft : k + Nfft + Nfft/16)));
        Down1 = sum(IQ_Ts_Unshifted(k : k + Nfft/16).*...
            conj(IQ_Ts_Unshifted(k : k + Nfft/16)));
        Down2 = sum(IQ_Ts_Unshifted(k + Nfft : k + Nfft + Nfft/16).*...
            conj(IQ_Ts_Unshifted(k + Nfft : k + Nfft + Nfft/16)));
        AutoCorr(k) = Up/sqrt(Down1*Down2);
    end
    plot(abs(AutoCorr));
    hold on;
    AbsAutoCorr = abs(AutoCorr);
    for k = 1 : fix(length(IQ_Ts_Unshifted)/(Nfft + Nfft/8)) - 1
        MedPosition(k) = FindTs(AbsAutoCorr((k-1)*(Nfft + Nfft/8) + 1 :...
               k*(Nfft + Nfft/8)), LevelOfIncreasing, Nfft);
        plot((k-1)*(Nfft + Nfft/8) + MedPosition,...
            AbsAutoCorr((k-1)*(Nfft + Nfft/8) + MedPosition),'*');
    end
    Position = fix(sum(MedPosition)/...
        (fix(length(IQ_Ts_Unshifted)/(Nfft + Nfft/8)) - 1));
    plot(Position, AbsAutoCorr(Position),'*');
end

