function [ SignaNoiseTu ] = NoiseSignalOutTu( Signal ,SNR,deltaW,Nfft)
Signal=Shift(Signal,deltaW,Nfft);
NumbOfSumb=size(Signal,1);
SignalIN=[];
for k=1:NumbOfSumb  
    SignalIN=[SignalIN Signal(k,:) ];%������ � ������ �����������
end
  SignaNoiseTu = awgn(SignalIN,SNR,'measured');
end