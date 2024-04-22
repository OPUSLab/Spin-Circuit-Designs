`timescale 1ns / 1ps
module LFSR (clk, reset_n, LFSR_out);

parameter [31:0] seed = 32'b10101011110011000110111011111110;

input clk;
input reset_n;
output [31:0] LFSR_out;

reg [32:1] r_LFSR;
reg  feedback;
 

  // Create Feedback Polynomials.  Based on Application Note:
// http://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
always @(*)
    begin
          feedback = r_LFSR[32] ^~ r_LFSR[22] ^~ r_LFSR[2] ^~ r_LFSR[1];
    end // always @ (*)

always @(posedge clk, negedge reset_n)
    begin 
       if (reset_n == 0) 
            r_LFSR <= seed;
       else 
            r_LFSR <= {r_LFSR[32:1], feedback};
    end
    
assign LFSR_out = r_LFSR[32:1];
 
endmodule // LFSR