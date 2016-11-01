function [ Index_Inform , Index_Pilot ] = FormIndex( Nc, Ration_Of_Pilots )
    Step = 1 /(Ration_Of_Pilots);
    Index_Pilot = 1: Step :Nc + 1 ;
    Index_Inform = [];
    for k = 2 : Nc
        if (k ~= Index_Pilot(:))
            Index_Inform = [Index_Inform k ];
        end
    end
end