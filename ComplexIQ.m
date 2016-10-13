function [ NewIQ_F, NewIQ ] = ComplexIQ( MedSignalInF, wo, Nfft, Nc )
    MedSignalInFBySymbol = zeros( length(MedSignalInF)/Nc , Nfft ); 
    for k = 1: length(MedSignalInF)/Nc
        for l = 2 : Nc
            MedSignalInFBySymbol(k,l) = MedSignalInF((l-1) + (k-1)*Nc);
        end
        IQ(k,:) = ifft(MedSignalInFBySymbol(k,:), Nfft);
        I(k,:) = real(IQ(k,:));
        Q(k,:) = imag(IQ(k,:));
    end
    for k = 1:Nfft
        NewI(:,k) = I(:,k)*cos(2*pi*wo*(k-1)/Nfft) - Q(:,k)*sin(2*pi*wo*(k-1)/Nfft);
        NewQ(:,k) = Q(:,k)*cos(2*pi*wo*(k-1)/Nfft) + I(:,k)*sin(2*pi*wo*(k-1)/Nfft);
    end
    NewIQBySymbol = complex(NewI,NewQ);
    NewIQ = NewIQBySymbol(1, 1:Nfft);
    for k = 1 : length(MedSignalInF)/Nc
        NewIQ_F(k,:) = fft(NewIQBySymbol((k, :), Nfft);% фурье образ 
    end
    if (length(MedSignalInF)/Nc) > 1
        for k = 2 : length(MedSignalInF)/Nc
            NewIQ = [ NewIQ NewIQBySymbol(k, :) ];%complex signal
        end
    end
    %Смещённый сигнал, который уже комлпкксный(мы его и хотели
end

