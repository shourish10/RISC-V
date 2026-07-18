/*
module gpr(input [4:0] rs1,rs2,rd,input [31:0]wd,input clk, we,output [31:0] rd1,rd2);
reg [31:0] gprs [31:0]; //we have 32 gprs and each has a 32 bits wide
assign rd1=gprs[rs1];
assign rd2=gprs[rs2];
always@(posedge clk) begin
if (we)
gprs[rd]<=wd;
end
endmodule 
 */
// we should check x0 reg always , because in the risc v isa it is hard wired to 0 to help like immideaite loads like add x2,x0,24 like in this situations we use x0 register whre its value is 0 always


/*
module gpr(input [4:0] rs1,rs2,rd,input [31:0]wd,input clk, we,output [31:0] rd1,rd2);
reg [31:0] gprs [31:0]; //we have 32 gprs and each has a 32 bits wide
assign rd1=(rs1==0)?32'h0:gprs[rs1];
assign rd2=(rs2==0)?32'h0:gprs[rs2];
always@(posedge clk) begin
if (we && rd!=5'd0)
gprs[rd]<=wd;
end
endmodule
*/

module gpr(
    input  [4:0] rs1, rs2, rd,
    input  [31:0] wd,
    input  clk, we,
    output [31:0] rd1, rd2
);

reg [31:0] gprs [31:0];
integer i;

//-----------------------------
// Register File Initialization
//-----------------------------
initial begin
    // Initialize all registers to 0
    for(i = 0; i < 32; i = i + 1)
        gprs[i] = 32'd0;

    // Initialize a few registers for simulation
    gprs[5] = 32'd10;    // x5
    gprs[6] = 32'd20;    // x6
    gprs[9] = 32'd100;   // x9 (base address for sw)
end

// x0 is always hardwired to zero
assign rd1 = (rs1 == 5'd0) ? 32'd0 : gprs[rs1];
assign rd2 = (rs2 == 5'd0) ? 32'd0 : gprs[rs2];

// Register write
always @(posedge clk) begin
    if (we && rd != 5'd0)
        gprs[rd] <= wd;
end

endmodule
