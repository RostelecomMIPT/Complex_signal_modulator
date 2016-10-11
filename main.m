script
clear all;
clc;

%������� ������
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
LevelOfIncreasing = 3;
SNR = 30;
NumbSymbol = 1;
rng(0);
w = -50;
wo = 1.9;

%��������
InputBits = randi([0,1],1,(Nc*sqrt(Nsk)*NumbSymbol));
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk,Nfft);
%:^ �� �������� ��������� 16-���
IQ_F = ComplexIQ_F(MedSignalInF,w,Nfft);
IQShifted = Shift(IQ_F, wo, Nfft);
plot(abs(IQShifted));
scatterplot(IQShifted);
z=0;