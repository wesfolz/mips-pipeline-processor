`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:06:17 12/05/2013 
// Design Name: 
// Module Name:    Mux_Imm 
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
module Mux_Imm(
		input [15:0] A,
		input [2:0] B,
		output reg [15:0] Out,
		input Sel
		);

		always@(A,B,Sel)begin
		
		if(Sel == 1)begin
			Out <= B;
		end
		
		else begin
			Out <= A;
		end	
		
		
		
		end


endmodule
