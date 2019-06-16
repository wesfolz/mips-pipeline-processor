`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:37 08/28/2013 
// Design Name: 
// Module Name:    adder4 
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

module Adder(a_in, b_in, sum_out);

	input [31:0] a_in;
	input [31:0] b_in;
	output [31:0] sum_out;
	wire [31:0]p,g,c;
	

   assign p[31:0]=a_in[31:0]^b_in[31:0];
   assign g[31:0]=a_in[31:0]&b_in[31:0];
   assign c[0]=g[0];
   assign c[31:1]=g[31:1]|(p[31:1]&c[31:0]);
   assign sum_out[0]=p[0];
   assign sum_out[31:1]=p[31:1]^c[31:0];

	
/*	
	always @ (a_in, b_in) begin
		sum_out <= CLA(a_in, b_in);
	end
	*/
/*
module Adder(a_in, b_in, sum_out);

	input [31:0] a_in;
	input [31:0] b_in;
	output reg [31:0] sum_out;
	
	always @ (a_in, b_in) begin
		sum_out <= a_in + b_in;
	end
	*/
endmodule
