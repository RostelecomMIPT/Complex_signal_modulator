script
clear all;
clc;

%входные данные
rng(0);
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
w = -50;
NumbOfSymbol = 2;

%алгоритм
InputBits = randi([0,1], 1, NumbOfSymbol*Nc*sqrt(Nsk) );
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk, Nfft);
[ IQ_F, IQ ] = ComplexIQ( MedSignalInF, w, Nfft, Nc );
IQ_Ts = AddTs (IQ, Nfft);
NFM
plot(abs(IQShifted));
scatterplot(IQShifted);
z=0;