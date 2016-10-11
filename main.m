script
clear all;
clc;

%������� ������
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 300;
LevelOfIncreasing = 3;
SNR = 30;
NumbSymbol = 1;
rng(0);
wo = -100;

%��������
InputBits = randi([0,1],1,(Nc*sqrt(Nsk)*NumbSymbol));
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk,Nfft);
%:^ �� �������� ��������� 16-���
IQ = ComplexIQ_F(MedSignalInF,wo,Nfft);
hold on;
plot(abs(IQ));
z=0;