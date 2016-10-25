function [ IQ_Ts_Shift ] = Shift( SignalTs, w, Fi, Nfft )
        I = real(SignalTs);
        Q = imag(SignalTs);    
    for k = 1:length(SignalTs)
        NewI(k) = I(k)*cos(2*pi*w*(k-1)/Nfft + Fi) -...
                Q(k)*sin(2*pi*w*(k-1)/Nfft + Fi);
        NewQ(k) = Q(k)*cos(2*pi*w*(k-1)/Nfft + Fi) +...
                I(k)*sin(2*pi*w*(k-1)/Nfft + Fi);
    end
    IQ_Ts_Shift = complex(NewI, NewQ);
end