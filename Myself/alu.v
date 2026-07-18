module alu(input [31:0]a,b, input[2:0]alu_ctrl, output reg [31:0]result,output zero_flag);
always@(*) begin
case(alu_ctrl) 
3'b000:result=a+b; //add 
3'b001:result=a-b; //sub
3'b010:result=a&b; //and , for and,or,slt we have to check funct3  for and =111
3'b011:result=a|b; //or for or=110 and for slt =010
// for now we dk xor funct3 value so keep it as a comment 3'b100:result=a^b; //xor
//3'b101:result=(a<b)?32'd1:32'd0;
3'b101:result=($signed(a)<$signed(b))?32'd1:32'd0;//slt(set less than) in this when rs1<rs2 then rd becomes 1 otherwise 0
/*we should not keep unsigned coz in unsigned a=-2=>111111_31(1's)0 when comparing it becomes a very big number and b=3=>0000__11 and it compares (a<b)very big number < with 3 it results false , but in real -2<3 is true , thats why we should keep $signed*/                 

//3'b110:result= a<<b[4:0];//left shift (4:0) coz we have 32 bit wide 
//3'b111:result=a>>b[4:0]; //right shift
default:result=32'd0;
endcase
end

assign zero_flag=(result==32'd0)?1:0; //in beq we perform sub operator instead comparator so when rs1 aand rs2 becomes equal the zero flag goes high and the value cmng from the sign exte is added with the current addr and it is given to the adder , the o/p of adder becomes effective adder and pc will go to that address
endmodule
