
module data_mem(input clk,we,input [31:0]addr,wd,output  [31:0]rd);
reg [31:0] data_mem_reg [0:255];
assign rd= data_mem_reg[addr[31:2]];// here also it performs >> right shift 

integer i;

initial begin
    for(i = 0; i < 256; i = i + 1)
        data_mem_reg[i] = 32'd0;
end

always@(posedge clk) begin
if (we)
	data_mem_reg[addr[31:2]]<=wd;
  $display("MEM[%0d] = %0d", addr[31:2], wd);
end
endmodule
//if alu o/p is 108 then it becomes 108/4==>27 , it becomes data_mem_reg[27]




/*doubt
and for this rs1 is x2 , the data present in the x2 is added with the immediate value of 8 and the alu result becomes effective address to the data memory , whatever the alu output is there it is divided by 4 that becomes effective address , the data present in that divided by 4 location is stored in the destination register which is there in the reg file which is x5

Yes, your understanding is almost perfect. There is just one small terminology correction.

Let's trace:

lw x5, 8(x2)

Assume:

x2 = 100
Step 1: Register File
rs1 = x2

Register file outputs:

rd1 = 100
Step 2: Immediate Generator
imm_ext = 8
Step 3: ALU

Controller sets:

ALUSrc = 1

So ALU inputs are:

a = 100
b = 8

ALU computes:

100 + 8 = 108

Therefore:

ALUResult = 108

This is called the:

Effective Address

Excellent.

Step 4: Data Memory

Now here's the small correction.

You said:

whatever the alu output is there it is divided by 4 that becomes effective address

Not exactly.

The effective address is already 108.

Effective Address = 108

We are not changing the effective address.

The division by 4 is only because our Verilog memory is implemented as:

reg [31:0] mem [0:255];

which is a word array.

So internally we access:

mem[108 >> 2]

which is:

mem[27]

This is just a Verilog implementation detail.

Architecturally, the address is still:

108
Step 5: Read Memory

Suppose:

mem[27] = 500

Then:

ReadData = 500
Step 6: Write Back

Controller sets:

ResultSrc = 1
RegWrite  = 1

Write-back mux selects:

WriteData = ReadData = 500

Register file receives:

rd = x5
wd = 500

At clock edge:

x5 = 500
Final Flow
lw x5, 8(x2)

x2 = 100
      ↓
Immediate = 8
      ↓
ALU computes 100 + 8
      ↓
Effective Address = 108
      ↓
Data Memory reads location 108
      ↓
Value = 500
      ↓
Write Back
      ↓
x5 = 500

So your understanding is correct.

The only thing I'd rephrase is:

❌

ALU output divided by 4 becomes effective address

✅

ALU output itself is the effective address.
The division by 4 is only used internally to index our Verilog word-array memory.

That's exactly how a hardware engineer would explain it. You're now tracing complete instructions through the datapath instead of individual blocks, which is the right mindset before we move to the PC and control path.*/
