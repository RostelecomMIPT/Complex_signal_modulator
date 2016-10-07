script
clear all;
clc;

%входные данные
Nfft = 1024;
wo = -pi/100;

%сам алгоритм
%создание фурье-образа. Не симмитричный
F = zeros(1, Nfft/2);
for k = 2+100:Nfft/8+100
    F(k) = 10 + 1i*10;
end
plot(abs(F));
IQ = ifft(F,Nfft/2);
for wo=-40:1:-30
    for k=1:Nfft/2
        NewIQ(k) = IQ(k)*exp(1i*wo*k);
    end
    NewF = fft(NewIQ,Nfft/2);
    hold on;
    plot(abs(NewF));
end
z=0;
