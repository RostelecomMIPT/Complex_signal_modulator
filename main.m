script
clear all;
clc;

rng(0);
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 400;
w = 0;
SNR = 200;
LevelOfIncreasing = 3;
Ration_Of_Pilots = 0.1; 
AmpPilot = 5;
NumbOfSymbol = 8; % kratno 8
FileNameInput = '12345678'; %'TestScreen.png';
FileNameOutput = 'OutPutFile';
% a1 = fopen(FileNameInput,'r');
% a2 = fopen(FileNameOutput, 'w');
% a3 = fread(a1);
% fwrite(a2, a3);
% fclose('all');

[ Index_Inform , Index_Pilot ] = FormIndex ( Nc, Ration_Of_Pilots );

% InputBits = randi( [0,1], 1, (1 - Ration_Of_Pilots) *...
%                         NumbOfSymbol*Nc*log2(Nsk) );

Nc = Nc + 1;
[ InputBits, AddZeroes ] = Reader (FileNameInput, Nsk, Index_Inform);
Bits = RSLOS( InputBits, Register );
InformF = Mapper(Bits, Nsk);
[MedSignalInF, Signal] = Inform_And_Pilot(...
                InformF, Index_Inform, Index_Pilot, Nfft, AmpPilot ); 
SignalTs = AddTs (Signal, Nfft);


IQ_Ts_Shift = Shift( SignalTs, w, Nfft );
IQ_Ts_Shift_Noise = awgn(IQ_Ts_Shift, SNR, 'measured' );

IQ_Ts_Shift_Noise = [IQ_Ts_Shift_Noise(1:Nfft+Nfft/8)...
    IQ_Ts_Shift_Noise...
    IQ_Ts_Shift_Noise(end - Nfft - Nfft/8 + 1 : end) ];
IQ_Ts_Shift_Noise(1:500) = [];
IQ_Ts_Shift_Noise(end - 499:end) = [];
IndexShiftBegin = Nfft + Nfft/8 - 500;
IndexShiftEnd = length(IQ_Ts_Shift_Noise) - (Nfft + Nfft/8 - 500);

[ AbsAutoCorr, AutoCorr, PositionTs1 ] = FuncCorrelation(...
        IQ_Ts_Shift_Noise, Nfft, LevelOfIncreasing );

PhaseFreq =  FindOfPhase(AutoCorr, Nfft, PositionTs1);
IQ_Ts_Unshifted = Shift(IQ_Ts_Shift_Noise, PhaseFreq, Nfft);

IQ_Ts_Unshifted(1:PositionTs1) = [];

MedFunc_TSync_FreqSync = ...
    FuncTs( IQ_Ts_Unshifted, Nfft , Index_Pilot, Nc);
UsedF = -MedFunc_TSync_FreqSync(:,Index_Inform + 1);
OutputBits =  DeMapper(UsedF, Nsk);
OutpuBitsRSLOS = RSLOS(OutputBits, Register);     
Writer( FileNameOutput, OutpuBitsRSLOS, AddZeroes );
z=0;
