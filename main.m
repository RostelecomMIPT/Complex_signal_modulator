script
clc;
clear all;
%������� ������
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
LevelOfIncreasing = 3;
SNR = 100;
NumbSymbol = 4;
rng(0);
deltaW=0.1;%����� �� �������.
SizeOfZI=128;
InputBits = randi([0,1],1,(Nc*sqrt(Nsk)*NumbSymbol));
%������ ��������
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk);
MedSignalInF=OpF(MedSignalInF);%���������� ��������������� �����
Signal = QModul(MedSignalInF , Nc, Nfft,deltaW);%��������� ������ � t � �������� ���
SignalOutWN=NoiseSignalOutTu(Signal,SNR,deltaW,Nfft);%������������� ����� ��� � �����
FunctionOfCorrelation  = FindDeltaF( SignalOutWN, Nfft,SizeOfZI );%



