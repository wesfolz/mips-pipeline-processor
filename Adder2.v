`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:09:25 12/04/2013 
// Design Name: 
// Module Name:    Adder2 
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
module Adder2(A, B, ALUResult);

	input [31:0] A;
	input [31:0] B;
	output [31:0] ALUResult;
	wire [31:0]p,g,c;
	
   assign p[31:0]=A[31:0]^B[31:0];
   assign g[31:0]=A[31:0]&B[31:0];
   assign c[0]=g[0];
   assign c[31:1]=g[31:1]|(p[31:1]&c[31:0]);
   assign ALUResult[0]=p[0];
   assign ALUResult[31:1]=p[31:1]^c[31:0];

	
/*	
	always @ (a_in, b_in) begin
		sum_out <= CLA(a_in, b_in);
	end
	*/
/*
	input signed [31:0] A;
	input signed [31:0] B;
	output reg [31:0] ALUResult;
	
	always@(A,B)begin
	
		ALUResult <= A + B;
	
	end
	
		*/
	
	
	
endmodule


