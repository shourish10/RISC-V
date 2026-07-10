
// TESTBENCH — RISC-V Single-Cycle Processor
// Harris & Harris, Digital Design and Computer Architecture
// RISC-V Edition, Chapter 7
//
// Test program (riscvtest.mem) exercises:
//   addi, or, and, add, beq (not-taken), slt, beq (taken),
//   slt, add, sub, sw, lw, add, jal, add, sw, beq (loop)
//
// Expected outcome: mem[100] == 25  →  "Simulation PASSED"


`timescale 1ns/1ps
`include"top.v"
module testbench;
    
    // Signals
   
    logic        clk;
    logic        reset;
    logic [31:0] WriteData, DataAdr;
    logic        MemWrite;

    
    // Instantiate DUT
   
    top dut (
        .clk       (clk),
        .reset     (reset),
        .WriteData (WriteData),
        .DataAdr   (DataAdr),
        .MemWrite  (MemWrite)
    );

    
    // Clock: 10 ns period  (100 MHz)
    
    initial clk = 0;
    always #5 clk = ~clk;

   
    // Reset: assert for first two full cycles
   
    initial begin
        reset = 1;
        #22;
        reset = 0;
    end

   
    // Simulation timeout guard — prevents infinite hang
   
    initial begin
        #5000;
        $display("TIMEOUT: simulation exceeded 5000 ns without result.");
        $finish;
    end

    
    // Result check — sample on every falling edge while
    // MemWrite is asserted.
    //   Success : DataAdr == 100 && WriteData == 25
    //   Progress: DataAdr == 96  (intermediate sw, ignore)
    //   Failure : anything else
    
    always @(negedge clk) begin
        if (MemWrite) begin
            if (DataAdr === 32'd100 && WriteData === 32'd25) begin
                $display("");
               
                $display("  Simulation PASSED — mem[100] = 25 ");
              
                $display("");
                $finish;
            end else if (DataAdr !== 32'd96) begin
                $display("");
                
                $display("   Simulation FAILED                               ");
                $display("   Expected  : DataAdr=100, WriteData=25           ");
                $display("   Got       : DataAdr=%0d, WriteData=%0d          ",
                         DataAdr, WriteData);
                
                $finish;
            end
        end
    end

   
    

endmodule
