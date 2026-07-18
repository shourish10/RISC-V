`include "single_cycle.sv"
`include "instruction_mem.v"
`include "data_memory.v"
module top (
  input logic clk,rst);
  //internal signals
  logic [31:0]instr,read_data;
  logic [31:0]data_addr,write_data;//data_addr== addr to the data_mem, write_data == the data we want to write
  logic [31:0]pc;//pc is going from single cycle to instr_mem (which is inst_addr)
  logic mem_write;//mem_write is connected from controller to the data_memory for we(write enable)

  single_cycle s1 (.clk(clk), .rst(rst), .instr(instr), .read_data(read_data), .pc(pc), .alu_result(data_addr), .write_data(write_data), .mem_write(mem_write));

  instr_mem imem(.inst_addr(pc), .instr(instr));

  data_mem dmem (.clk(clk), .we(mem_write), .addr(data_addr), .wd(write_data), .rd(read_data));

  endmodule
 

