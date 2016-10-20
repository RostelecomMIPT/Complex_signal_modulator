function [ SignalOut ] = FindDeltaF( SignalOut, Nfft,SizeOfZI )
for 











Mult=[];
SumOfMult=[];
Sdv=[];
   for k=1:SizeOfZI
       Mult(1,k)=(SignalOut(1,k)*conj(SignalOut(1,Nfft+k)));
       Mult1(1,k)=(SignalOut(1,k)*conj(SignalOut(1,k)));
       Mult2(1,k)=(SignalOut(1,Nfft+k)*conj(SignalOut(1,Nfft+k)));
   end
   
SumOfMult=sum(Mult(1,:))/(sqrt(sum(Mult1(1,:)))*sqrt(sum(Mult2(1,:))));
Sdv = angle(SumOfMult)/(2*pi);

scatterplot(ifft(SignalOut));

SignalOut=Shift(SignalOut,Nfft,Sdv);

SignalOut=SignalOut(:,129:1152);
for k = 1:size(SignalOut,1)
        SignalF(k,:) = fft(SignalOut(k,:));
end;
plot(abs(SignalF))
    scatterplot(SignalF(1,1:100))

end