
// 3:1 MULTIPLEXER  (parametric width)
// s=00 → d0   s=01 → d1   s=1x → d2

module mux3 #(parameter WIDTH = 8) (
    input  logic [WIDTH-1:0] d0, d1, d2,
    input  logic [1:0]       s,
    output logic [WIDTH-1:0] y
);
    assign y = s[1] ? d2 : (s[0] ? d1 : d0);
endmodule
