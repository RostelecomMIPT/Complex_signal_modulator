function [ InputBits ] = ReaderWriter ( FileNameInput, Nc, Nsk, NumbOfSymbol )
    LengthOfBuffer = Nc*log2(Nsk)*NumbOfSymbol;
    InputFile = fopen(FileNameInput,'r');
    ByteFile = (de2bi( fread( InputFile ))).';
    fclose(InputFile);
    [SizeOfFile1, SizeOfFile2] = size(ByteFile);
    SizeOfFile = SizeOfFile1*SizeOfFile2;
    Bits = reshape(ByteFile, [1, SizeOfFile]);
    % создание массива битов из Н-ОФДМ символов
    if mod(SizeOfFile, LengthOfBuffer) ~= 0
        Bits = [Bits zeros(1,LengthOfBuffer - mod(SizeOfFile, LengthOfBuffer))];
    end
    InputBits = reshape(Bits, LengthOfBuffer, length(Bits)/LengthOfBuffer).';
end

