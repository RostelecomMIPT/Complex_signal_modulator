function [ MedSignalInF ] = OpF( MedSignalInF )
    m=4;%через каждые m отсетов идет вспомогательная частота
    Amp=10;%амплитуда несущей частоты
    MedSignalInF=reshape(MedSignalInF,length(MedSignalInF)/m,m);
    for i=1:size(MedSignalInF,1)
       a(i)=Amp*(-1)^mod(i,2); 
    end
    a=a';
    MedSignalInF=[MedSignalInF a]';
    MedSignalInF=reshape(MedSignalInF,1,size(MedSignalInF,1)*size(MedSignalInF,2));

end