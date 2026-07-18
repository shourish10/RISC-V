`timescale 1ns/1ps

`include "top.sv"

module top_tb;

logic clk;
logic rst;

top dut(
    .clk(clk),
    .rst(rst)
);

// Clock
always #5 clk = ~clk;

// Reset
initial begin
    clk = 0;
    rst = 1;

    #20;
    rst = 0;
end

// Monitor
initial begin

$display("\nTime\tPC\tInstr\t\tALUAddr\t\tWriteData\tReadData\tMemWrite");
$display("----------------------------------------------------------------------------");

$monitor("%0t\t%h\t%h\t%h\t%h\t%h\t%b",
        $time,
        dut.pc,
        dut.instr,
        dut.data_addr,
        dut.write_data,
        dut.read_data,
        dut.mem_write);

end

// Finish
initial begin

#200;

$display("\nSimulation Finished\n");

$finish;

end

endmodule
