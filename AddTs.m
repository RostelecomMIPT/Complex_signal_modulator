function [ IQ_Ts ] = AddTs( IQ, Nfft )
    IQ_Ts = [ IQ(Nfft-Nfft/8 + 1 : Nfft) IQ(1:Nfft) ];
    if length(IQ)/Nfft > 1
        for k = 2 : length(IQ)/Nfft
            IQ_Ts = [ IQ_Ts ...
                      IQ( (k*Nfft - Nfft/8 + 1) : k*Nfft)...
                      IQ( (k-1)*Nfft + 1 : k*Nfft) ];
        end
    end
end

