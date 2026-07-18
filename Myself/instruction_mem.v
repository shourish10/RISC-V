module instr_mem (input [31:0]inst_addr,
		  output [31:0]instr);
//it is like a rom so we need an memory , and for this we dont need any clk
//we have to store the machine code in the mem, based on the PC addr we have to pass through the instr output 
//software people will take care of that and they provide an program.mem file where we can access the machine code directly by using $readmemh system task

reg [31:0] mem [0:255];

integer i;

initial begin

    for(i = 2; i < 256; i = i + 1)
        mem[i] = 32'h00000013;   // addi x0,x0,0 (NOP)

    mem[0] = 32'b0000000_00110_00101_110_00100_0110011; // or x4,x5,x6//in gpr x5=10,x6=20 so x4 becomes 
    mem[1] = 32'b0000000_00110_01001_010_01000_0100011; // sw x6,8(x9)

end

assign instr=mem[inst_addr[31:2]];
//here we neglected last two bits of addr (which is mem[0] which is 32 bits but we only consider 31:2 to make it divisible by 4 which makes pc=4 == mem[1])coz our PC will increment by 4 for every cycle if we directly slice like that we will lose mem[1],2,3 and mem[5],6,7 ,. like that also our PC will increment by 4 na for divisible by 4 we get 00 for last two bits , so if we neglect taht 2 we dont affect that much by using (a>>2)1000>>2 = 0010, 8/4=2
endmodule






