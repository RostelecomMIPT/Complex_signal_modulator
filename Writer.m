function [ ] = Writer( FileNameOutput, OutpuBitsRSLOS )
    OutputFile = fopen( FileNameOutput, 'a+');
    fwrite(OutputFile, OutpuBitsRSLOS);
    fclose(OutputFile);
end

