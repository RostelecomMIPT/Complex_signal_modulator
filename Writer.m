function [ ] = Writer( FileNameOutput, OutpuBitsRSLOS, AddZeroes )
    OutputFile = fopen( FileNameOutput, 'a+');
    fwrite(OutputFile, OutpuBitsRSLOS(1:end - AddZeroes));
    fclose(OutputFile);
end

