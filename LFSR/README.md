
The "Verilog Codes" folder contains 3 different codes corresponding to the LFSR p-bit implementation that was synthesized into SPICE to simulate along with the stochastic magnetic tunnel junction. 
The LFSR.sv file is the bare-bones 32-bit Linear Feedback Shift Register. 
LUT_bias.sv corresponds to a hyperbolic tangent look-up table with an input precision of 8 bits (s43 representation). 
pbit.sv compares the 32-bit output from both the previous modules to determine the output state of the p-bit.

These codes are synthesized into SPICE using Synopsys Design Compiler and Calibre V2LVS tools.
