function [ Index_Inform , Index_Pilot ] = FormIndex( Nc, Ration_Of_Pilots )
    Index_Pilot = [1 Nc + 1];
    Step = Nc * Ration_Of_Pilots;
    Index_Pilot = 1:Step:Nc;
    Index_Inform = 1 : Nc;
    Index_Inform = Index_Inform - Index_Pilot;
end