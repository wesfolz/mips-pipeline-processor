`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:57:27 10/28/2013 
// Design Name: 
// Module Name:    OrGate 
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
module OrGate(
		input inA,
		input inB,
		output reg Out
		);	
		
		always@(inA,inB)begin
			if(inA | inB)begin
				Out <=1;
			end
			
			else begin
				Out <= 0;
			end
		end


endmodule
