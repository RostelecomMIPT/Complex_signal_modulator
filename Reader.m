function [ InputBits, AddZeroes ] = Reader ( FileNameInput, Nsk,...
    Index_Inform )
    InputFile = fopen(FileNameInput, 'r', 'b');
    ByteFile = (de2bi(fread(InputFile), 8, 'left-msb')).';
    fclose(InputFile);
    [Size1, Size2] = size(ByteFile);
    Size = Size1*Size2;
    InputBits = reshape(ByteFile, [1, Size]);
    k = mod(Size, length(Index_Inform)*log2(Nsk));
    if  k ~= 0
        AddZeroes = length(Index_Inform)*log2(Nsk) - k - 1;
        InputBits = [InputBits zeros(1,AddZeroes)];
    else
        AddZeroes = 0;
    end
    OutPut = fopen('OutPutFile.txt', 'w+');
    fwrite(OutPut, reshape(InputBits(1:end - AddZeroes),8, 4));
    fclose(OutPut);
end

