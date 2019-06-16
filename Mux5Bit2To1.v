`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 1
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux5Bit2To1(out, inA, inB, sel);

    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
	 reg [4:0] ra;
    input [1:0] sel;
	 
always @(sel, inA, inB) begin
		ra <= 5'b11111;

		if(sel == 2'b00)begin
		out <= inA;
		end

		else if(sel == 2'b01)begin
		out <= inB;
		end
		
		else if(sel == 2'b10) begin //jal
			out <= ra;
		end

	end

endmodule
