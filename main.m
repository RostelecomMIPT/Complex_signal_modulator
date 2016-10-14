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
SNR = 0;
LevelOfIncreasing = 3;

%��������
InputBits = randi([0,1], 1, NumbOfSymbol*Nc*sqrt(Nsk) );
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk, Nfft);
[ SignalInF, Signal ] = SignalAndF( MedSignalInF, Nfft, Nc );
SignalTs = AddTs (Signal, Nfft);
IQ_Ts_Shift = Shift( SignalTs, w, Nfft );
IQ_Ts_Shift_Noise = awgn(IQ_Ts_Shift,SNR,'measured');
% plot(abs(IQ_Ts_Shift) - abs(IQ_Ts_Shift_Noise));
% hold on;
% plot(abs(IQ_Ts_Shift));
% plot(abs(IQ_Ts_Shift_Noise));
sdv = FindOfPhase(IQ_Ts_Shift_Noise, Nfft);
IQ_Ts_Unshifted = Shift(IQ_Ts_Shift_Noise, sdv, Nfft);
IQ_Ts_Unshifted(1:129) = [];
[AutoCorr, Position] = TimeSync(IQ_Ts_Unshifted, Nfft, LevelOfIncreasing);
% for k = 1 : NumbOfSymbol
%     scatterplot(fft(IQ_Ts_Unshifted(Nfft/8+ 1 + (k-1)*(Nfft+Nfft/8):k*(Nfft+Nfft/8))));
% end
z=0;
