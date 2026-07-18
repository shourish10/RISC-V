module alu_dec(input [1:0]ALUop,input [2:0]funct3,input funct75b,op5b,output reg [2:0]alu_ctrl);
wire Rtype_sub;
assign Rtype_sub=(funct75b & op5b)?1:0;
always@(*) begin
  case (ALUop) 
    //this is for lw,sw and beq 
    2'b00:alu_ctrl=3'b000;//lw
    2'b01:alu_ctrl=3'b000;//sw
    2'b10:alu_ctrl=3'b001;//beq
    default:case (funct3)
      //this is for r type or i type
      3'b000:alu_ctrl=(Rtype_sub)?3'b001:3'b000; //add or sub or addi
      3'b010:alu_ctrl=3'b101;//slt or slti
      3'b110:alu_ctrl=3'b011;//or /ori
      3'b111:alu_ctrl=3'b010;//and or andi
    endcase
  endcase
end
endmodule
