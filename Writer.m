function [ ] = Writer( FileNameOutput, OutpuBitsRSLOS, AddZeroes )
    OutpuBitsRSLOS = OutpuBitsRSLOS(1:end - AddZeroes);
    OutputBitsByBytes =...
        (reshape(OutpuBitsRSLOS, 8, length(OutpuBitsRSLOS)/8)).';
    OutputBytes = bi2de(OutputBitsByBytes, 'right-msb');
    OutputFile = fopen( FileNameOutput, 'w+');
    fwrite(OutputFile, OutputBytes);
    fclose(OutputFile);
end

