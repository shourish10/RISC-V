# Create work library
vlib work

# Compile the testbench (includes all RTL files)
vlog tb.sv

# Start simulation
vsim top_tb

# Add all signals recursively
add wave -r *

# Useful radix
radix hex

# Run the complete simulation
run -all
