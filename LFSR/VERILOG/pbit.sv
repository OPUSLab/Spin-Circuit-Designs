`timescale 1ns / 1ps
module pbit ( GE, clk, LUT_out, LFSR_out, s_out);

input GE; // global enable
input clk;

output reg s_out; 

input [31:0] LUT_out;
input [31:0] LFSR_out;


always @ (posedge clk) begin
    if (GE ==1'b1) 
       s_out = (LUT_out >LFSR_out) ? 1'b1 : 1'b0 ;
    end
endmodule 
