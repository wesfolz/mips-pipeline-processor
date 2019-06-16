`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:43 12/04/2013 
// Design Name: 
// Module Name:    Mux5Bit2To1B 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Mux5Bit2To1B(out, inA, inB, sel);

    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;
	 
always @(sel, inA, inB) begin
		
		if(sel == 1)begin
		out <= inB;
		end

		else begin
		out <= inA;
		end


	end

endmodule
