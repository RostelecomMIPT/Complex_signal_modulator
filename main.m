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
wo = 0.2;

%алгоритм
InputBits = randi([0,1],1,(Nc*sqrt(Nsk)));
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk,Nfft);
%:^ из прошлого алгоритма 16-КАМ
IQ_F = ComplexIQ_F(MedSignalInF,w,Nfft);
IQShifted = Shift(IQ_F, wo, Nfft);
plot(abs(IQShifted));
scatterplot(IQShifted);
z=0;