`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:41:57 10/08/2013 
// Design Name: 
// Module Name:    SignExtender5to32_tb 
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
module SignExtender5to32_tb();

    reg [4:0] in;

    wire [31:0] out;
	 
	SignExtender5to32 u0(
				.in(in),
				.out(out)
				);
	 
	 initial begin
	 
		in <= 5'b00010;
		
		$display("%s", out);
	 
	 end
	 

endmodule
