script
clear all;
clc;

rng(0);
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 64;
Nfft = 1024;
Nc = 400;
w = 0.1;
SNR = 30;
LevelOfIncreasing = 3;
Ration_Of_Pilots = 0.1; 
AmpPilot = 10;
NumbOfSymbol = 8; % kratno 8
FileNameInput = 'TestScreen.png';
FileNameOutput = 'OutPutFile.png';
c1 = fopen(FileNameOutput,'w');
fclose(c1);

[ Index_Inform , Index_Pilot ] = FormIndex ( Nc, Ration_Of_Pilots );

Nc = Nc + 1;

% InputBits = randi([0,1], 1, (1 - Ration_Of_Pilots) *...
%                         NumbOfSymbol*Nc*log2(Nsk) );

InputBits = Reader (FileNameInput, Nsk, Index_Inform);
Bits = RSLOS(InputBits, Register);
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

MedFunc_TSync_FreqSync = ...
    FuncTs( IQ_Ts_Unshifted, Nfft , Index_Pilot, Nc,...
    PositionTs1 );
UsedF = -MedFunc_TSync_FreqSync(:,Index_Inform + 1);
OutputBits =  DeMapper(UsedF, Nsk);
OutpuBitsRSLOS = RSLOS(OutputBits, Register);     
Writer( FileNameOutput, OutpuBitsRSLOS );
z=0;
