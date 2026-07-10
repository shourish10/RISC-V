
// INSTRUCTION MEMORY  (64 × 32-bit words, word-addressed)
// Loads program from riscvtest.mem at simulation start.

module imem (
    input  logic [31:0] a,
    output logic [31:0] rd
);
    logic [31:0] RAM [0:63];

    initial $readmemh("riscvtest.mem", RAM, 0, 63);

    assign rd = RAM[a[31:2]];   // word-aligned fetch
endmodule
