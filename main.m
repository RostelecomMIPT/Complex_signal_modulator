script
clear all;
clc;

%������� ������
rng(0);
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
w = 0.1;
NumbOfSymbol = 2;

%��������
InputBits = randi([0,1], 1, NumbOfSymbol*Nc*sqrt(Nsk) );
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk, Nfft);
[ IQ_F, IQ ] = ComplexIQ( MedSignalInF, w, Nfft, Nc );
IQ_Ts = AddTs (IQ, Nfft);
sdv = FindOfPhase(IQ_Ts, Nfft);
scatterplot(IQ_F);