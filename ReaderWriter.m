function [ InputBits, Trigger ] = ReaderWriter ( FileNameInput, Nc,...
    Nsk, NumbOfSymbol, Trigger )
    LengthOfBuffer = Nc*log2(Nsk)*NumbOfSymbol;
    InputFile = fopen(FileNameInput,'r');
    ByteFile = (de2bi( fread( InputFile, LengthOfBuffer/8 ))).';
    fclose(InputFile);
    [Size1, Size2] = size(ByteFile);
    Size = Size1*Size2;
    InputBits = reshape(ByteFile, [1, Size]);
    % создание массива битов из Н-ОФДМ символов
    if mod(Size, LengthOfBuffer) ~= 0
        InputBits = [InputBits zeros(1,LengthOfBuffer - mod(Size, LengthOfBuffer))];
        Trigger = 1;
    end
end

