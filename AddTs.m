function [ Signal_Ts ] = AddTs( Signal, Nfft )
    Signal_Ts = [ Signal(Nfft-Nfft/8 + 1 : Nfft) Signal(1:Nfft) ];
    if length(Signal)/Nfft > 1
        for k = 2 : length(Signal)/Nfft
            Signal_Ts = [ Signal_Ts ...
                      Signal( (k*Nfft - Nfft/8 + 1) : k*Nfft)...
                      Signal( (k-1)*Nfft + 1 : k*Nfft) ];
        end
    end
end

