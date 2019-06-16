`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:57:09 12/05/2013 
// Design Name: 
// Module Name:    SignExtension2 
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
module SignExtension2(
		input [15:0]in, 
		output reg [31:0] out,
		input [2:0]inB,
		input Sel
		);


	
	always@(in,inB,Sel)begin
	
	if(Sel == 1) begin
		out <= {{29{0}}, inB[2:0]};
	end
	
	
	else begin
		out <= {{16{in[15]}}, in[15:0]};
	end
	
	end
	



	

	


endmodule
