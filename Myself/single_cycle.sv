`include "datapath.sv"
`include "controller.sv"
module single_cycle (input logic clk,rst,
  input logic [31:0]instr,read_data,output logic [31:0]pc,alu_result,write_data,output logic mem_write);//mem_write comming from the controller
  //alu_result= address to the data_mem and write data comes from the rd2
  //read data comes from the data_mem to gpr

  logic pc_src,alu_src,reg_write,zero;
  logic [1:0]result_src,imm_src;
  logic [2:0]alu_control;
  logic jump,branch;

  datapath dat1 (.clk(clk), .rst(rst), .pc_src(pc_src), .reg_write(reg_write), .alu_src(alu_src), .imm_src(imm_src), .result_src(result_src), .alu_ctrl(alu_control), .instr(instr), .pc(pc), .alu_result(alu_result), .regw_data(), .mem_write_data(write_data), .zero(zero),.read_data(read_data));
//here regw_data is unconnected coz it is already used internally , coz regw_data gets from o/p of data_mem_mux in single cycle internal is not exist                                             

  controller co1 (.zero(zero), .instr_op(instr[6:0]), .funct3(instr[14:12]), .funct75(instr[30]), .mem_write(mem_write), .alu_src(alu_src), .reg_write(reg_write), .result_src(result_src), .imm_src(imm_src), .alu_control(alu_control), .pc_src(pc_src), .branch(branch), .jump(jump));
  endmodule
