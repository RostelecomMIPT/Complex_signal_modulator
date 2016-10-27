function [ MedF ] = FuncTs( IQ_Ts_Unshifted, Nfft, LevelOfIncreasing, ...
                                    Index_Pilot)
%     [ AbsAutoCorr, AutoCorr, PositionTs1 ] = FuncCorrelation(...
%         IQ_Ts_Unshifted, Nfft, LevelOfIncreasing );
    Fi =[];
    PositionTs1 = 1;
    for k = 1 : length(IQ_Ts_Unshifted)/(Nfft + Nfft/8)
        MedF(k, :) = fft(...
                IQ_Ts_Unshifted(...
                    (k - 1)*(Nfft + Nfft/8) + PositionTs1 :...
                    (k - 1)*(Nfft + Nfft/8) + Nfft + PositionTs1 - 1));
        MedF(:,1) = [];
        Ang(:) = angle(MedF(1,1:10:101));
        Fi = angle(MedF(k,1)) + ((2*pi + angle(MedF(k,11)) -...
            angle(MedF(k,1))) / (11 -1)) .* ( (1:11) - 1);
        MedF1(1,1:11) = MedF(1,1:11) .* exp(-1i*Fi(1:11));
%         for l = 2 : length(Index_Pilot) - 1
%             % y = y1 + (y2 - y1)*(x-x1)/(x2-x1)
%             Fi = [ Fi Fi(Index_Pilot(l) - 1) + (angle(MedF(k,Index_Pilot(l))) -...
%                     angle(MedF(k,Index_Pilot(l + 1)))) *...
%                  (Index_Pilot(l) : Index_Pilot(l + 1))/...
%                  (Index_Pilot(l) - Index_Pilot(l + 1)) + ...
%                  Index_Pilot(l + 1)*angle(MedF(k,Index_Pilot(l))) - ...
%                  Index_Pilot(l)*angle(MedF(k,Index_Pilot(l + 1)))];
%         end
%         Fi = [Fi zeros(1, Nfft - length(Fi))];
%         MedF(k,:) = MedF(k,:).*exp(-1i*Fi);
    end
end

