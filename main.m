script
clear all;
clc;

%входные данные
rng(0);
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 64;
Nfft = 1024;
Nc = 400;
w = 0;
SNR = 30;
LevelOfIncreasing = 3;
Ration_Of_Pilots = 0.1; 
AmpPilot = 10;
NumbOfSymbol = 8; % должно быть кратное 8 из-за бит->байт
FileNameInput = 'TestScreen.png';
FileNameOutput = 'OutPutFile.png';
Trigger = 0; % Тригер на выход из внешнего цикла. Равносилен концу файла
%алгоритм


[ Index_Inform , Index_Pilot ] = FormIndex ( Nc, Ration_Of_Pilots );

Nc = Nc + 1;

% InputBits = randi([0,1], 1, (1 - Ration_Of_Pilots) *...
%                         NumbOfSymbol*Nc*log2(Nsk) );

% Считываение с файла. Пример растровое изображение *.PNG
while Trigger == 0 
    InputBits = ReaderWriter (FileNameInput, (1-Ration_Of_Pilots)*(Nc-1),...
        Nsk, NumbOfSymbol);
    Bits = RSLOS(InputBits, Register);
    InformF = Mapper(Bits, Nsk);
    [MedSignalInF, Signal] = Inform_And_Pilot(...
                    InformF, Index_Inform, Index_Pilot, Nfft, AmpPilot ); 
    SignalTs = AddTs (Signal, Nfft);
    % Выше - модуль с модулятором


    % Ниже - Модуль связанный со средой и приёмником/источников
    IQ_Ts_Shift = Shift( SignalTs, w, Nfft );
    IQ_Ts_Shift_Noise = awgn(IQ_Ts_Shift, SNR, 'measured' );


    % Ниже - модуль с демодулятором. Сигнал приходит на приёмник
    IQ_Ts_Shift_Noise = [IQ_Ts_Shift_Noise(1:Nfft+Nfft/8)...
        IQ_Ts_Shift_Noise...
        IQ_Ts_Shift_Noise(end - Nfft - Nfft/8 + 1 : end) ];
    IQ_Ts_Shift_Noise(1:500) = [];
    IQ_Ts_Shift_Noise(end - 499:end) = [];
    IndexShiftBegin = Nfft + Nfft/8 - 500;
    IndexShiftEnd = length(IQ_Ts_Shift_Noise) - (Nfft + Nfft/8 - 500);
    % Грубый поиск середины защитного интервала
    [ AbsAutoCorr, AutoCorr, PositionTs1 ] = FuncCorrelation(...
            IQ_Ts_Shift_Noise, Nfft, LevelOfIncreasing );
    %Частотная синхронизация
    PhaseFreq =  FindOfPhase(AutoCorr, Nfft, PositionTs1);
    IQ_Ts_Unshifted = Shift(IQ_Ts_Shift_Noise, PhaseFreq, Nfft);
    %далее поиск точной позиции ОФДМ-символа
    MedFunc_TSync_FreqSync = ...
        FuncTs( IQ_Ts_Unshifted, Nfft , Index_Pilot, Nc,...
        PositionTs1 );
    UsedF = MedFunc_TSync_FreqSync(:,2:Nc+1);
    % Демапер
    OutputBits = DeMapper (UsedF, Index_Inform, Nsk);
    % Дерандомизатор
    OutpuBitsRSLOS = RSLOS(OutputBits, Register);
    % Сохранение файла
end
z=0;
