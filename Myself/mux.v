module muxx(input [31:0]mux_a,mux_b,input sel,output reg [31:0]mux_out);
always@(*) begin
mux_out = sel?mux_b:mux_a;
end

endmodule
