script
clear all;
clc;

rng(0);
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 4;
Nfft = 1024;
Nc = 400;
w = 0;
SNR = 20;
LevelOfIncreasing = 3;
Ration_Of_Pilots = 0.1; 
AmpPilot = 2;
NumbOfSymbol = 8; % kratno 8
FileNameInput = 'TestScreen.png'; %'TestScreen.png';
FileNameOutput = 'OutPutFile.png';
AddZeroes = 0;
% a1 = fopen(FileNameInput,'r');
% a2 = fopen(FileNameOutput, 'w');
% a3 = fread(a1);
% fwrite(a2, a3);
% fclose('all');

[ Index_Inform , Index_Pilot ] = FormIndex ( Nc, Ration_Of_Pilots );

InputBits = randi( [0,1], 1, (1 - Ration_Of_Pilots) *...
                        NumbOfSymbol*Nc*log2(Nsk) );

Nc = Nc + 1;
% [ InputBits, AddZeroes ] = Reader (FileNameInput, Nsk, Index_Inform);
Bits = RSLOS( InputBits, Register );
InformF = Mapper(Bits, Nsk);
[MedSignalInF, Signal] = Inform_And_Pilot(...
                InformF, Index_Inform, Index_Pilot, Nfft, AmpPilot ); 
SignalTs = AddTs (Signal, Nfft);





t1 = 1;
a1 = 1;
t2 = 20;
a2 = 2;
t3 = 30;
a3 = 3;
t4 = 40;
a4 = 0;
t5 = 5;
a5 = 0;
SignalTs1 = SignalTs(1:Nfft);
SignalTs2 = SignalTs(t1 + 1:Nfft+t1);
SignalTs3 = SignalTs(t2 + 1:Nfft+t2);
SignalTs4 = SignalTs(t3 + 1:Nfft+t3);
SignalTs5 = SignalTs(t4 + 1:Nfft+t4);
SignalTs6 = SignalTs(t5 + 1:Nfft+t5);
Signal = SignalTs1 + SignalTs2.*a1 + a2*SignalTs3 +...
    a3*SignalTs4 + a4*SignalTs5 + a5*SignalTs6;
Fur = fft(Signal(1:1024));
%hold on;
plot(10*log10(abs(Fur)));





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
UsedF = MedFunc_TSync_FreqSync(:,Index_Inform + 1);
OutputBits =  DeMapper(UsedF, Nsk);
OutpuBitsRSLOS = RSLOS(OutputBits, Register);     
Writer( FileNameOutput, OutpuBitsRSLOS, AddZeroes );
z=0;
