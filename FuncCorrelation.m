function [ AbsAutoCorr, AutoCorr, PositionTs ] = FuncCorrelation(...
        IQ_Ts_Shift_Noise, Nfft, LevelOfIncreasing )
    for k = 1 : length(IQ_Ts_Shift_Noise) - Nfft/16 - Nfft
        Up = sum (...
                IQ_Ts_Shift_Noise(...
                    k : k + Nfft/16).*...
                conj(...
                    IQ_Ts_Shift_Noise(...
                        k + Nfft : k + Nfft + Nfft/16)));
        Down1 = sum(...
                IQ_Ts_Shift_Noise(k : k + Nfft/16).*...
                conj(...
                    IQ_Ts_Shift_Noise(k : k + Nfft/16)));
        Down2 = sum(...
                IQ_Ts_Shift_Noise(k + Nfft : k + Nfft + Nfft/16).*...
                conj(...
                    IQ_Ts_Shift_Noise(k + Nfft : k + Nfft + Nfft/16)));
        AutoCorr(k) = Up/sqrt(Down1*Down2);
    end
    AbsAutoCorr = abs(AutoCorr);
%     plot(AutoCorr);
%     hold on;
    for k =1 : fix(length(IQ_Ts_Shift_Noise)/(Nfft + Nfft/8)) - 1
        PositionTs(k) = FindTs(...
                AbsAutoCorr(...
                    (k-1)*(Nfft + Nfft/8) + 1 : k*(Nfft + Nfft/8)), LevelOfIncreasing);
    end
    PositionTs = fix(sum(PositionTs(:))/...
        (fix(length(IQ_Ts_Shift_Noise)/(Nfft + Nfft/8)) - 1));
%     plot(Position, AutoCorr(Position),'*');
end
