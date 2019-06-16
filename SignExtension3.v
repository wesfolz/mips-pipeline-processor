`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:59:07 12/05/2013 
// Design Name: 
// Module Name:    SignExtension3 
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
module SignExtension3(
		input [2:0] in, 
		output [31:0] out
		);	


/*
	always@(in) begin

		case(in)
		
		3'b001: begin
			assign output = 32'b00000000000000000000000000000001;
		end
		
		
		
		endcase
		
	end
	
	*/
	assign out = {{29{0}}, in[2:0]};
	
endmodule
