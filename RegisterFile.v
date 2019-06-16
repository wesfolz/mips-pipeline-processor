`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 2
//
//
// Student(s) Name and Last Name: Anthony Giang, Wesley Folz
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
//////////////////////////////////////////////////////////////////////////////////
module RegisterFile(
	input [4:0] ReadRegister1,
	input [4:0] ReadRegister2,
	input [4:0] WriteRegister,
	input [31:0] WriteData, 
	input RegWrite, 
	input Clk, 
	output reg [31:0] ReadData1, 
	output reg [31:0] ReadData2,
	output [31:0] Output1,
	output [31:0] Output2,
	input [4:0] ReadRegister1B,
	input [4:0] ReadRegister2B,
	input [4:0] WriteRegister2,
	input [31:0] WriteData2,
	input Double,
	input MEMWB_Double,
	output reg [31:0] ReadData1B,
	output reg [31:0] ReadData2B,
	input addi,
	input MEMWB_addi
		);
	
	reg[31:0] regfile[0:31];
	
	
	assign Output1 = regfile[2];
	assign Output2 = regfile[3];
	
	always@(posedge Clk) begin
		regfile[00000] <= 0; //zero register

		if(RegWrite == 1)begin
			regfile[WriteRegister] <= WriteData;
		end
	
		if(MEMWB_Double == 1 || MEMWB_addi == 1)begin
			regfile[WriteRegister2] <= WriteData2;
		end
	
	
	end

	always@(negedge Clk) begin
		 ReadData1 <= regfile[ReadRegister1];
		 ReadData2 <= regfile[ReadRegister2];
		 
		 if(Double==1 || addi == 1) begin
			 ReadData1B <= regfile[ReadRegister1B];
			 ReadData2B <= regfile[ReadRegister2B];
			 
		 end
		 
		 
	end



	


endmodule
