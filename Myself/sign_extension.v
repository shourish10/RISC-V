module sign_ext(input [31:7]sg, input  [1:0]ctrl, output reg [31:0]extended);
always@(*) begin
case(ctrl)
2'b00:extended={{20{sg[31]}},sg[31:20]}; //I-type
2'b01:extended={{20{sg[31]}},sg[31:25],sg[11:7]};//S-type
2'b10:extended={{19{sg[31]}},sg[31],sg[7],sg[30:25],sg[11:8],1'b0};//B-type
//3'b011:extended={{12{sg[24]}},sg[24:5]};//U-type
2'b11:extended={{12{sg[31]}}, sg[19:12],sg[20],sg[30:21],1'b0};//J-type doubt
default:extended=32'd0;
endcase
end
endmodule

//doubt

/*
module sign_ext(input [24:0]sg, input  [2:0]ctrl, output reg [31:0]extended);
always@(*) begin
case(ctrl)
3'b000:extended={{20{sg[24]}},sg[24:13]}; //I-type
3'b001:extended={{20{sg[24]}},sg[24:18],sg[4:0]};//S-type
3'b010:extended={{19{sg[24]}},sg[24],sg[22:16],sg[4:1],sg[23],1'b0};//B-type
3'b011:extended={{12{sg[24]}},sg[24:5]};//U-type
3'b100:extended={{12{sg[24]}}, sg[24],sg[14:5],sg[15],sg[23:16]};//J-type doubt
default:extended=32'd0;
endcase
end
endmodule
*/
