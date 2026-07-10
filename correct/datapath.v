
// DATAPATH
// Harris & Harris Ch.7 — Single-Cycle RISC-V
`include"flopr.v"
`include"adder.v"
`include"mux2.v"
`include"regfile.v"
`include"extend.v"
`include"alu.v"
`include"mux3.v"
module datapath (
    input  logic        clk, reset,
    input  logic [1:0]  ResultSrc,
    input  logic        PCSrc, ALUSrc, RegWrite,
    input  logic [1:0]  ImmSrc,
    input  logic [2:0]  ALUControl,
    output logic        Zero,
    output logic [31:0] PC,
    input  logic [31:0] Instr,
    output logic [31:0] ALUResult, WriteData,
    input  logic [31:0] ReadData
);
    logic [31:0] PCNext, PCPlus4, PCTarget;
    logic [31:0] ImmExt;
    logic [31:0] SrcA, SrcB;
    logic [31:0] Result;

    // PC logic
    flopr  #(32) pcreg       (clk, reset, PCNext, PC);
    adder         pcadd4      (PC, 32'd4,  PCPlus4);
    adder         pcaddbranch (PC, ImmExt, PCTarget);
    mux2  #(32)  pcmux       (PCPlus4, PCTarget, PCSrc, PCNext);

    //  Register file 
    regfile rf (clk, RegWrite,
                Instr[19:15], Instr[24:20], Instr[11:7],
                Result, SrcA, WriteData);

    //  Immediate extension 
    extend ext (Instr[31:7], ImmSrc, ImmExt);

    //  ALU
    mux2  #(32) srcbmux (WriteData, ImmExt, ALUSrc, SrcB);
    alu          alu     (SrcA, SrcB, ALUControl, ALUResult, Zero);

    //  Result mux: ALU result / Load data / PC+4 (JAL) 
    mux3  #(32) resultmux (ALUResult, ReadData, PCPlus4, ResultSrc, Result);
endmodule
