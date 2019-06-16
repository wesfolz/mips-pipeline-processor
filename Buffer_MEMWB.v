`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:20:43 10/28/2013 
// Design Name: 
// Module Name:    Buffer_MEMWB 
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
module Buffer_MEMWB(
		input Clk,
		input EXMEM_MemtoReg,
		input EXMEM_RegWrite,
		input [31:0] DMReadData,
		input [31:0] EXMEM_ALUResult,
		input [4:0] EXMEM_WriteReg,
		
		output MEMWB_MemtoReg,
		output MEMWB_RegWrite,
		output [31:0] MEMWB_DMReadData,
		output [31:0] MEMWB_ALUResult,
		output [4:0] MEMWB_WriteReg,	
		input [31:0] EXMEM_Instr,
		output [31:0] MEMWB_Instr,
		input EXMEM_Double,
		output MEMWB_Double,
		input [31:0] EXMEM_ALU2,
		output [31:0] MEMWB_ALU2,
		input EXMEM_addi,
		output MEMWB_addi
		);
		
		
		reg [31:0]MEMWB_Data[0:1];
		reg MEMWB_Ctrl[0:1];
		reg [4:0]MEMWB_RD;
		reg [31:0] MEMWB_InstrReg;
		reg Double;
		reg [31:0] ALU2;
		reg addi;

		assign MEMWB_MemtoReg = MEMWB_Ctrl[0];
		assign MEMWB_RegWrite = MEMWB_Ctrl[1];
		assign MEMWB_DMReadData = MEMWB_Data[0];
		assign MEMWB_ALUResult = MEMWB_Data[1];
		assign MEMWB_WriteReg = MEMWB_RD;
		assign MEMWB_Instr = MEMWB_InstrReg;
		assign MEMWB_Double = Double;
		assign MEMWB_ALU2 = ALU2;
		assign MEMWB_addi = addi;

		always@(posedge Clk)begin

			
			MEMWB_Ctrl[0] <= EXMEM_MemtoReg;
			MEMWB_Ctrl[1] <= EXMEM_RegWrite;
			MEMWB_Data[0] <= DMReadData;
			MEMWB_Data[1] <= EXMEM_ALUResult;
			MEMWB_RD <= EXMEM_WriteReg;
			MEMWB_InstrReg <= EXMEM_Instr;
			Double <= EXMEM_Double;
			ALU2 <= EXMEM_ALU2;
			addi <= EXMEM_addi;
	
		end

endmodule
