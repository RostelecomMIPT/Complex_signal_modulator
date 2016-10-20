function [ Signal ] = QModul( MedSignalInF , Nc, Nfft,deltaW )
    
NumbSymbol=length(MedSignalInF)/Nc   
MedSignalInFBySymbol=reshape(MedSignalInF,Nc,NumbSymbol)
MedSignalInFBySymbol=MedSignalInFBySymbol'

 
    zeroo = zeros (NumbSymbol, Nfft-Nc-1);
    SignalF = [zeros(NumbSymbol,1) MedSignalInFBySymbol zeroo]/sqrt(Nfft);

    for k = 1:NumbSymbol
        Signal(k,:) = ifft(SignalF(k,:));
    end;
    Signal=[Signal(:,Nfft-127:Nfft) Signal ];%добавление защитного интервала
    

 
end

