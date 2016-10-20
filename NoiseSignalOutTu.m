function [ SignaNoiseTu ] = NoiseSignalOutTu( Signal ,SNR,deltaW,Nfft)
Signal=Shift(Signal,deltaW,Nfft);
NumbOfSumb=size(Signal,1);
SignalIN=[];
for k=1:NumbOfSumb  
    SignalIN=[SignalIN Signal(k,:) ];%сигнал в строгу преобразуем
end
  SignaNoiseTu = awgn(SignalIN,SNR,'measured');
end