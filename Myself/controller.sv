`include "main_decoder.sv"
`include "alu_decoder.v"
module controller (input logic zero,input logic [6:0]instr_op,input logic [2:0]funct3,input logic funct75,output logic branch,jump,mem_write,alu_src,reg_write,output logic [1:0]result_src,imm_src,output logic [2:0]alu_control,output logic pc_src);
//internal wire main dec ---> alu decoder
logic [1:0]alu_op;

main_dec m1 (.op(instr_op), .aluop(alu_op), .branch(branch), .jump(jump), .mem_write(mem_write), .alu_src(alu_src), .reg_write(reg_write), .result_src(result_src), .imm_src(imm_src));

alu_dec a1(.ALUop(alu_op), .funct3(funct3), .funct75b(funct75), .op5b(instr_op[5]), .alu_ctrl(alu_control));

assign pc_src=(zero&branch)|jump;

endmodule
