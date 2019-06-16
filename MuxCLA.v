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
module MuxCLA(
		output reg [31:0] out, 
		input [31:0] inA, 
		input [31:0] inB,
		input [2:0] sel,
		input double
		);

	always@(inA,inB,sel, double)begin
	
		if(sel==3'b000 || double == 1)begin
			out <= inB;
		end
		
		else begin
			out <= inA;
		end
		
	end



endmodule
