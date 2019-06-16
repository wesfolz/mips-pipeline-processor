`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:26 10/28/2013 
// Design Name: 
// Module Name:    Mux_PC 
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
module Mux_PC(
		output reg [31:0] out, 
		input [31:0] inA, 
		input [31:0] inB,
		input sel
		);

	always@(inA,inB,sel)begin
	
		if(sel==1)begin
			out <= inB;
		end
		
		else begin
			out <= inA;
		end
		
	end



endmodule
