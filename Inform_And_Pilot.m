function [ MedSignalInF, Signal ] = Inform_And_Pilot( InformF, Index_Inform,...
                                            Index_Pilot, Nfft )
        Signal = [];
        for k = 1 : length(InformF)/length(Index_Inform)
            MedSignalInF(k,Index_Inform) = InformF((k-1)*...
                length(Index_Inform) + 1: k*length(Index_Inform));
            MedSignalInF(k,Index_Pilot) = 3;
        end
        MedSignalInF = [ zeros(length(InformF)/length(Index_Inform), 1)...
            MedSignalInF zeros(length(InformF)/length(Index_Inform),...
            Nfft - max(Index_Pilot) - 1)];
        for k = 1 : length(InformF)/length(Index_Inform)  
            Signal = [Signal ifft(MedSignalInF(k,:))];
        end
end

