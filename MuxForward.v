`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:35 10/28/2013 
// Design Name: 
// Module Name:    MuxForward 
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
module MuxForward(
		input [31:0] inA,
		input [31:0] inB,
		input [31:0] inC,
		input [31:0] inD,
		input [1:0] sel,
		output reg [31:0] Out
		);
    
			
	always @(sel, inA, inB, inC,inD)
		begin

			if(sel == 2'b01)begin
			Out <= inB;
			end
			
			else if(sel == 2'b10)begin
			Out <= inC;
			end
			
			else if(sel == 2'b11)begin
			Out <= inD;
			end
			
			else begin
			Out <= inA;
			end
			

		end


endmodule
