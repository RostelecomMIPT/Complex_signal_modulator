function [ IQ_F ] = Shift( IQ, w, Nfft )
    MedIQ = ifft(IQ,Nfft);
    I = real(MedIQ);
    Q = imag(MedIQ);
    for k = 1:Nfft
        NewI(k) = I(k)*cos(2*pi*w*(k-1)/Nfft) - Q(k)*sin(2*pi*w*(k-1)/Nfft);
        NewQ(k) = Q(k)*cos(2*pi*w*(k-1)/Nfft) + I(k)*sin(2*pi*w*(k-1)/Nfft);
    end
    NewIQ = complex(NewI,NewQ);
    IQ_F = fft(NewIQ,Nfft);
end

