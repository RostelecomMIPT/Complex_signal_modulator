script
clear all;
clc;

%входные данные
rng(0);
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
w = 0.1;
NumbOfSymbol = 2;

%алгоритм
InputBits = randi([0,1], 1, NumbOfSymbol*Nc*sqrt(Nsk) );
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk, Nfft);
[ SignalInF, Signal ] = SignalAndF( MedSignalInF, Nfft, Nc );
SignalTs = AddTs (Signal, Nfft);
IQ_Ts_Shift = Shift( SignalTs, w, Nfft );
sdv = FindOfPhase(IQ_Ts_Shift, Nfft);
scatterplot(SignalInF(1,:));