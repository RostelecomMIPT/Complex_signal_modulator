function [ SignalInF ] = Inform_And_Pilot( InformF, Index_Inform,...
                                            Index_Pilot )
    InformBySymbol = reshape (InformF, length(InformF)/length(Index_Inform),...
        length(Index_Inform));
    SignalInF = [];
    for k = 1 : length(InformF)/length(Index_Inform)
        MedSignalInF(k, Index_Inform(:)) = InformBySymbol(k,:);
        for l = 1 : length (Index_Pilot) 
            switch mod(l,2)
                case 1
                    MedSignalInF(k, Index_Pilot(:)) = 3 * exp(0);
                case 0
                    MedSignalInF(k, Index_Pilot(:)) = 3 * exp(0);
            end
        end
        SignalInF = [ SignalInF MedSignalInF(k,:)];
    end
end

