function [ IQ_F ] = ComplexIQ_F( MedSignalInF,wo,Nfft )
    IQ = ifft(MedSignalInF,Nfft);
    I = real(IQ);
    Q = imag(IQ);
    for k = 1:Nfft
        NewI(k) = I(k)*cos(2*pi*wo*(k-1)/Nfft) - Q(k)*sin(2*pi*wo*(k-1)/Nfft);
        NewQ(k) = Q(k)*cos(2*pi*wo*(k-1)/Nfft) + I(k)*sin(2*pi*wo*(k-1)/Nfft);
    end
    NewIQ = complex(NewI,NewQ);
    IQ_F = fft(NewIQ,Nfft);
end

