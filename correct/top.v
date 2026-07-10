
// TOP-LEVEL WRAPPER  (processor + imem + dmem)
// Harris & Harris Ch.7 — Single-Cycle RISC-V
`include"singlecycle.v"
`include"imem.v"
`include"dmem.v"
module top (
    input  logic        clk, reset,
    output logic [31:0] WriteData, DataAdr,
    output logic        MemWrite
);
    logic [31:0] PC, Instr, ReadData;

    riscvsingle rvsingle (clk, reset, PC, Instr,
                          MemWrite, DataAdr, WriteData, ReadData);
    imem imem (PC, Instr);
    dmem dmem (clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule
