script
clear all;
clc;

%������� ������
rng(0);
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 500;
w = 0.1;
NumbOfSymbol = 5;
SNR = 100;
LevelOfIncreasing = 3;
Ration_Of_Pilots = 0.1; 

%��������
InputBits = randi([0,1], 1, (1 - Ration_Of_Pilots) *...
                        NumbOfSymbol*Nc*sqrt(Nsk) );
Bits = RSLOS(InputBits, Register);
[ Index_Inform , Index_Pilot ] = FormIndex ( Nc, Ration_Of_Pilots );

Nc = Nc + 1;
InformF = Mapper(Bits, Nsk, Nfft);
MedSignalInF = Inform_And_Pilot ( InformF, Index_Inform, Index_Pilot ); 
[ SignalInF, Signal ] = SignalAndF( MedSignalInF, Nfft, Nc );
SignalTs = AddTs (Signal, Nfft);
IQ_Ts_Shift = Shift( SignalTs, w, Nfft );
IQ_Ts_Shift_Noise = awgn(IQ_Ts_Shift,SNR,'measured');
% ���� - ������ � �����������
% ���� - ������ � �������������. ������ �������� �� �������

IQ_Ts_Shift_Noise(1:500) = [];

[ AbsAutoCorr, AutoCorr, PositionTs1 ] = FuncCorrelation(...
        IQ_Ts_Shift_Noise, Nfft, LevelOfIncreasing );

PhaseFreq = FindOfPhase(AutoCorr, Nfft, PositionTs1);
IQ_Ts_Unshifted = Shift(IQ_Ts_Shift_Noise, PhaseFreq, Nfft);
Position = FuncCorrelation(IQ_Ts_Unshifted, Nfft);
for k = 1 : NumbOfSymbol - 1
    scatterplot(fft(IQ_Ts_Unshifted(Nfft/8+ 1 + (k-1)*(Nfft+Nfft/8):k*(Nfft+Nfft/8))));
end
z=0;
