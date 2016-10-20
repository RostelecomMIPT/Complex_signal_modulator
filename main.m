script
clc;
clear all;
%входные данные
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
LevelOfIncreasing = 3;
SNR = 100;
NumbSymbol = 4;
rng(0);
deltaW=0.1;%сдвиг по частоте.
SizeOfZI=128;
InputBits = randi([0,1],1,(Nc*sqrt(Nsk)*NumbSymbol));
%начала операций
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk);
MedSignalInF=OpF(MedSignalInF);%добавление вспомогательных астот
Signal = QModul(MedSignalInF , Nc, Nfft,deltaW);%построили сигнал в t и сдвинули его
SignalOutWN=NoiseSignalOutTu(Signal,SNR,deltaW,Nfft);%Моделирование среды Шум и сдвиг
FunctionOfCorrelation  = FindDeltaF( SignalOutWN, Nfft,SizeOfZI );%



