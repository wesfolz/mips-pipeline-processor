`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:58:17 10/07/2013 
// Design Name: 
// Module Name:    ShiftLeft2Cat
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
module ShiftLeft2Cat(inSh, out);
	 
	 input [10:0] inSh;
	// input [3:0] inPC;
	 output reg [31:0] out;
	 reg [31:0] temp;

	always@(inSh)begin
		temp <= {{21{inSh[10]}}, inSh[10:0]};		
	end
	
	always@(temp)begin
		out <= temp << 2;
	end

endmodule
