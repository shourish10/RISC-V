`include "program_counter.sv"
`include "mux.v"
`include "four_adder.v"
`include "gpr.v"
`include "sign_extension.v"
`include "extension_adder.v"
`include "alu.v"
`include "mux_3.v"
module datapath(input logic clk,rst,pc_src,reg_write,alu_src,input logic [1:0]imm_src,result_src,input logic [2:0]alu_ctrl,
  input logic [31:0]instr,
  input logic [31:0] read_data,
  output logic [31:0]pc,alu_result,regw_data,output logic zero,//reg_w_data is a gpr's wd, it comes from the data_mem mux and given to the gpr's wd
  output logic [31:0] mem_write_data);//for sw instructions the rd2 data will store in data_memory;


  logic [31:0]mux_to_pc,pc_out,ext_pc_adder_out, pc_four_adder_out,datamem_mux,rd1,rd2,extended_out,mux_alu_out,alu_out;

  assign pc=pc_out;
  assign alu_result=alu_out;
  assign regw_data=datamem_mux;
  assign mem_write_data=rd2;

  //pc
  pc p1 (.clk(clk), .rst(rst), .next_pc(mux_to_pc), .pc_out(pc_out));
  //pc mux
  muxx m_pc (.mux_a(pc_four_adder_out), .mux_b(ext_pc_adder_out), .sel(pc_src), .mux_out(mux_to_pc));
  //pc +4
  plus_four_adder p4(.a(pc_out), .four_out(pc_four_adder_out));
  //gpr
  gpr g1(.rs1(instr[19:15]), .rs2(instr[24:20]), .rd(instr[11:7]), .wd(datamem_mux), .clk(clk), .we(reg_write), .rd1(rd1), .rd2(rd2));
  //alu mux
  muxx m_alu(.mux_a(rd2), .mux_b(extended_out), .sel(alu_src), .mux_out(mux_alu_out));
  //sign extension
  sign_ext s1 (.sg(instr[31:7]), .ctrl(imm_src), .extended(extended_out));
  //sign extension adder
  adder a1 (.a(pc_out), .b(extended_out), .c(ext_pc_adder_out));
  //alu
  alu al1(.a(rd1), .b(mux_alu_out), .alu_ctrl(alu_ctrl), .result(alu_out), .zero_flag(zero));
  //data_mem_mux
  mux_3 m1(.a(alu_out), .b(read_data), .c(pc_four_adder_out), .sel(result_src), .y(datamem_mux));


endmodule
