# RISC-V
cpu from scratch
building cpu from scatch 
basically it has (pc,instr mem,reg file,imm generator,alu,data mem and muxes)
**program counter (pc)** which is used to fetch the next instruction ,it gives the address to the instruction memory , basically address is a 32 bit , but in the design we neglect last two bits in the addr to match the index of the instruction memory.
(basically it is a byte addressable processor) ,**instruction memory** contains the machine code which is (function 3, function 7 , rd,rs1,rs2,immediate value and opcode)these values are depends on the type of the Instruction Set like (R-Type,I-type,S-type,B-type,J-type....).
Machine code is given to the **register file** (which is ntg but it contains 32 general purpose registers and each reg is 32 bit wide), it contains a1 a2 a3 (adresses) and rd1,rd2 (reading out) and wd (writing in) wd is controlled by regsrc (enable pin) based on the machine code cpu decides what operation to do like r,i,s,b,j types.
we have immediate generator beacause we have I,S,B type instructions , for this instructions instead of rs2 it has an constant value (offset value) , it may not be 32 bit wide , without 32 bit wide if we do addition or subraction we get wrong value , to overcome that we perform sign extension to make it 32 bit wide.
to perform operation we use alu where it performs arithmentic and logical operations (in design to control what operation to do we use alu ctrl and it is done by the case statement)
**data memory** this is used only when lw (load word) or sw(store word) instructions occurs , in load word ALU output becomes effective address to the data memory , from that address location the data is loaded into the register file based on the destination reg (rd) and in the store word there is no rd in machine code so  the alu output becomes effective address and whatever the data is there in rd2 it is given to the wd (writing in [in data mem]) by enabling the memsrc (enable pin)
it have two** adders ** first one is it just simply add +4 to the current address to get fetch next address and second is used like in j type instructions to jump whereever we want and it acts like it takes inputs from current address and output of immediate generator , based on the mux it gives to the pc


RISC-V Single-Cycle CPU from Scratch
Description

This project implements a 32-bit Single-Cycle RISC-V CPU from scratch using Verilog HDL. The processor follows a simplified RISC-V architecture and is designed to help understand the internal working of a CPU, including instruction fetching, decoding, execution, memory access, and write-back stages.

The CPU is built using fundamental hardware blocks such as:

Program Counter (PC)
Instruction Memory
Register File
Immediate Generator
Arithmetic Logic Unit (ALU)
Data Memory
Control Unit
ALU Control Unit
Multiplexers
Adders

The processor supports different RISC-V instruction formats including:

R-Type
I-Type
S-Type
B-Type
J-Type

The primary goal of this project is to learn processor architecture, RTL design, and computer organization concepts by implementing a working RISC-V CPU from scratch.

Architecture Overview
Program Counter (PC)

The Program Counter stores the address of the current instruction.

The PC provides the instruction address to the Instruction Memory.
Since the processor is byte-addressable, addresses are 32 bits wide.
The last two address bits are ignored while indexing Instruction Memory because each instruction occupies 4 bytes (32 bits).
The PC is updated every clock cycle.
Instruction Memory

Instruction Memory stores the machine code instructions.

Each instruction contains fields such as:

opcode
rd (destination register)
rs1 (source register 1)
rs2 (source register 2)
funct3
funct7
immediate value

The instruction format depends on the instruction type:

R-Type
I-Type
S-Type
B-Type
J-Type

The fetched instruction is decoded and sent to other processor blocks.

Register File

The Register File consists of:

32 General Purpose Registers
Each register is 32 bits wide

Ports:

Inputs
A1 (Read Address 1)
A2 (Read Address 2)
A3 (Write Address)
WD3 (Write Data)
WE3 (Write Enable)
Outputs
RD1 (Read Data 1)
RD2 (Read Data 2)

The CPU reads operands from the register file and writes results back into registers after execution.

Immediate Generator

Certain instruction types use immediate values instead of a second source register.

Supported instruction types:

I-Type
S-Type
B-Type
J-Type

Since immediate fields are smaller than 32 bits, the Immediate Generator performs sign extension to convert them into 32-bit values before they are used by the ALU.

This ensures correct arithmetic and address calculations.

Arithmetic Logic Unit (ALU)

The ALU performs arithmetic and logical operations such as:

Addition
Subtraction
AND
OR
XOR
Comparisons

The operation performed by the ALU is determined by the ALU Control Unit.

The ALU Control Unit decodes instruction fields and generates the appropriate control signal using combinational logic (case statements).

Data Memory

Data Memory is used only by:

Load Word (LW)
Store Word (SW)
Load Word (LW)
ALU calculates the effective memory address.
Data Memory reads data from that address.
The data is written back to the destination register (rd).
Store Word (SW)
ALU calculates the effective memory address.
Data from RD2 is sent to Data Memory.
Memory Write Enable is asserted.
The value is stored at the calculated address.
Adders

The design contains two adders.

PC + 4 Adder

Calculates:

PC + 4

This generates the address of the next sequential instruction.

Branch/Jump Adder

Calculates:

PC + Immediate

Used for:

Branch Instructions
Jump Instructions (JAL)

The output is selected through a multiplexer and can become the next PC value.

Multiplexers

Multiplexers are used throughout the datapath for selecting:

ALU operands
Write-back data
Next Program Counter value

Control signals determine which path is selected during instruction execution.
