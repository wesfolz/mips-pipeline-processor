`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:20:35 10/28/2013 
// Design Name: 
// Module Name:    Buffer_EXMEM 
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
module Buffer_EXMEM(
		input Clk,
		input IDEX_MemRead,
		input IDEX_MemtoReg,
	//	input IDEX_MemWrite,
		input IDEX_RegWrite,
		input [31:0] ALUResult,
	//	input [31:0] ALU_B,
		input [4:0] WriteReg,
		
		output EXMEM_MemRead,
		output EXMEM_MemtoReg,
	//	output EXMEM_MemWrite,
		output EXMEM_RegWrite,
		output [31:0] EXMEM_ALUResult,
	//	output [31:0] EXMEM_RD2,
		output [4:0] EXMEM_WriteReg,
		output [31:0] EXMEM_Instr,
		input [31:0] IDEX_Instr,
		input IDEX_Double,
		output EXMEM_Double,
		input [31:0] ALUResult2,
		output [31:0] EXMEM_ALU2,
		input IDEX_addi,
		output EXMEM_addi
		);
		
		
		reg EXMEM_Ctrl[0:2];
		reg [31:0] EXMEM_Data;
		reg [4:0] EXMEM_RDReg;
		reg [31:0] EXMEM_InstrReg;
		reg Double;
		reg [31:0]ALU2;
		reg addi;
		
		assign EXMEM_MemRead = EXMEM_Ctrl[0];
		assign EXMEM_MemtoReg = EXMEM_Ctrl[1];
//		assign EXMEM_MemWrite = EXMEM_Ctrl[2];
		assign EXMEM_RegWrite = EXMEM_Ctrl[2];
		assign EXMEM_ALUResult = EXMEM_Data;
	//	assign EXMEM_RD2 = EXMEM_Data[1];
		assign EXMEM_WriteReg = EXMEM_RDReg;		
		assign EXMEM_Instr = EXMEM_InstrReg;
		assign EXMEM_Double = Double;
		assign EXMEM_ALU2 = ALU2;
		assign EXMEM_addi = addi;
		
	always@(posedge Clk)begin	

			EXMEM_Ctrl[0] <= IDEX_MemRead;
			EXMEM_Ctrl[1] <= IDEX_MemtoReg;
		//	EXMEM_Ctrl[2] <= IDEX_MemWrite;
			EXMEM_Ctrl[2] <= IDEX_RegWrite;
			EXMEM_Data <= ALUResult;
	//		EXMEM_Data[1] <= ALU_B;
			EXMEM_RDReg <= WriteReg;
			EXMEM_InstrReg <= IDEX_Instr;
			Double <= IDEX_Double;
			ALU2 = ALUResult2;
			addi = IDEX_addi;


end		
 
endmodule
