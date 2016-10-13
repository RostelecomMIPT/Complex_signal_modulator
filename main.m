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
wo = 0.1;
NumbOfSymbol = 2;

%алгоритм
InputBits = randi([0,1], 1, NumbOfSymbol*Nc*sqrt(Nsk) );
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk, Nfft);
[ NewIQ_F, NewIQ ] = ComplexIQ(MedSignalInF, w, Nfft, Nc);
IQShifted = Shift(NewIQ_F, wo, Nfft);
IQShifted_Ts = Ts(IQShifted, Nfft);
plot(abs(IQShifted));
scatterplot(IQShifted);
z=0;