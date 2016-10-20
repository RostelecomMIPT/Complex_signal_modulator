function [ SignalOut ] = Shift( Signal, Nfft,DeltaW )
Nfft=1024;
NumbSymbol=size(Signal,1)
    for n=1:NumbSymbol
        for k=1:Nfft+128
            I(n,k)=real(Signal(n,k))*cos(2*pi*DeltaW*(k-1)/Nfft)-imag(Signal(n,k))*sin(2*pi*DeltaW*(k-1)/Nfft);
            Q(n,k)=imag(Signal(n,k))*cos(2*pi*DeltaW*(k-1)/Nfft)+real(Signal(n,k))*sin(2*pi*DeltaW*(k-1)/Nfft);
        end;
    end
 SignalOut=I+1i*Q;   
 
end