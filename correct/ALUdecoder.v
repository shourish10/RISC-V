
// ALU DECODER
// ALUControl encoding:
//   000=ADD  001=SUB  010=AND  011=OR  101=SLT

module aludec (
    input  logic       opb5,
    input  logic [2:0] funct3,
    input  logic       funct7b5,
    input  logic [1:0] ALUOp,
    output logic [2:0] ALUControl
);
    logic RtypeSub;
    assign RtypeSub = funct7b5 & opb5; // true for R-type SUB

    always_comb
        case (ALUOp)
        2'b00: ALUControl = 3'b000; // addition  (lw/sw)
        2'b01: ALUControl = 3'b001; // subtraction (beq)
        default: case (funct3)      // R-type or I-type ALU
            3'b000: ALUControl = RtypeSub ? 3'b001 : 3'b000; // sub/add/addi
            3'b010: ALUControl = 3'b101; // slt / slti
            3'b110: ALUControl = 3'b011; // or  / ori
            3'b111: ALUControl = 3'b010; // and / andi
            default: ALUControl = 3'bxxx;
        endcase
        endcase
endmodule
