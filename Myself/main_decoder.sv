module main_dec(input [6:0]op,output logic [1:0]aluop,output logic branch,jump,mem_write,alu_src,reg_write,output logic [1:0]result_src,imm_src);
logic [10:0]out;
assign {reg_write,imm_src,alu_src,mem_write,result_src,branch,aluop,jump}=out;//here out has data in case whenever on of it called through op then the data in the out will assign respectively
always@(*) begin
  case(op)
    7'd3:out =11'b1_00_1_0_01_0_00_0;//lw
    7'd35:out =11'b0_01_1_1_00_0_01_0;//sw. actually it is 7'd35:out =11'b0_01_1_1_xx_0_01_0;//sw in result_src we keep 00 because in sw write is enabled in data memory so there is no read from data mem even if we give 00 to result_mux it will not get anything 

    7'd51:out =11'b1_xx_0_0_00_0_11_0;//r-type
    7'd99:out =11'b0_10_0_0_xx_1_10_0;//beq
    7'd19:out =11'b1_00_1_0_00_0_11_0;//i-type
    7'd111:out =11'b1_11_x_0_10_0_xx_1;//jal
    default:out =11'bxxxxxxxxxxx;
  endcase
end
endmodule
