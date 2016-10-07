script
clear all;
clc;

%входные данные
Nfft = 1024;
wo = 50;

%сам алгоритм
F = zeros(1, Nfft/2);
for k = 2+100:Nfft/8+100
    F(k) = k/4;
end
IQ = ifft(F,Nfft/2);
I = real(IQ);
Q = imag(IQ);
NewI = I*cos(wo) - Q*sin(wo);
NewQ = - I*cos(wo) + Q*sin(wo) ;
NewIQ = NewI + 1i*NewQ;
NewF = fft(NewIQ,Nfft/2);
plot(F);
hold on;
plot(abs(NewF));
z=0;
