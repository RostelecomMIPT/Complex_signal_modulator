script
clear all;
clc;

%входные данные
rng(0);
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 400;
w = 0.1;
NumbOfSymbol = 5;
SNR = 100;
LevelOfIncreasing = 3;
Ration_Of_Pilots = 0.1; 

%алгоритм
InputBits = randi([0,1], 1, (1 - Ration_Of_Pilots) *...
                        NumbOfSymbol*Nc*log2(Nsk) );
Bits = RSLOS(InputBits, Register);
[ Index_Inform , Index_Pilot ] = FormIndex ( Nc, Ration_Of_Pilots );

Nc = Nc + 1;
InformF = Mapper(Bits, Nsk);
[MedSignalInF, Signal] = Inform_And_Pilot(...
                InformF, Index_Inform, Index_Pilot, Nfft ); 
SignalTs = AddTs (Signal, Nfft);
IQ_Ts_Shift = Shift( SignalTs, w, Nfft );
IQ_Ts_Shift_Noise = awgn(IQ_Ts_Shift, SNR, 'measured');
% Выше - модуль с модулятором
% Ниже - модуль с демодулятором. Сигнал приходит на приёмник

IQ_Ts_Shift_Noise(1:500) = [];
%Грубый поиск середины защитного интервала
[ AbsAutoCorr, AutoCorr, PositionTs1 ] = FuncCorrelation(...
        IQ_Ts_Shift_Noise, Nfft, LevelOfIncreasing );
%Частотная синхронизация
PhaseFreq =  FindOfPhase(AutoCorr, Nfft, PositionTs1);
IQ_Ts_Unshifted = Shift(IQ_Ts_Shift_Noise, PhaseFreq, Nfft);
w = 0;
%далее поиск точной позиции ОФДМ-символа
MedFunc_TSync_FreqSync = ...
    FuncTs( IQ_Ts_Unshifted, Nfft, LevelOfIncreasing , Index_Pilot, Nc,...
    PositionTs1 );
z=0;
