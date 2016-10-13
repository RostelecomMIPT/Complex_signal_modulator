function [ sdv ] = FindOfPhase( IQ_Ts, Nfft )
    for k = 1 : ( length(IQ_Ts)/(Nfft + Nfft/8) )
        for l = 1 : Nfft/8
            MedMultiplicationBySymbol(k, l) = IQ_Ts(...
                                            (k-1)*(Nfft + 1) + l ) *...
                                        conj(...
                                        IQ_Ts( k*(Nfft+ Nfft/8) - Nfft/8 + l ));
        end
    end
    MultiplicationBySymbol = sum(MedMultiplicationBySymbol,2);
    for k = 1 : ( length(IQ_Ts)/(Nfft + Nfft/8) )
        sdv(k) = angle(MultiplicationBySymbol(k))   
    end
    z = 0;
end

