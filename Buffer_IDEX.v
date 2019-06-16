`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:20:21 10/28/2013 
// Design Name: 
// Module Name:    Buffer_IDEX 
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
module Buffer_IDEX(
		input Clk,
		input [31:0] IFID_Instruction,
		input IFID_MemRead,
		input IFID_MemtoReg,
		input [2:0] IFID_ALUOp,
		input IFID_ALUSrc,
		input IFID_RegWrite,
		input [31:0] ReadData1,
		input [31:0] ReadData2,
		input [31:0] Shamt,
		input [31:0] SEInstr,
		output [31:0] IDEX_Instruction,
		output IDEX_MemRead,
		output IDEX_MemtoReg,
		output [2:0] IDEX_ALUOp,
		output IDEX_ALUSrc,
		output IDEX_RegWrite,
		output [31:0] IDEX_ReadData1,
		output [31:0] IDEX_ReadData2,
		output [31:0] IDEX_Shamt,
		output [31:0] IDEX_SEInstr,
		input [4:0] WriteReg,
		output [4:0] IDEX_WriteReg,
		
		input Double,
		output IDEX_Double,
		input [31:0] ReadData1B,
		input [31:0] ReadData2B,
		output [31:0] IDEX_RD1B,
		output [31:0] IDEX_RD2B,
    	input D_addi,
		output IDEX_addi,
		input [31:0] SEInstr2,
		output [31:0] IDEX_SEInstr2
    );
	 
	 
	 reg [31:0] IDEX_Data[0:4];
	 reg IDEX_Ctrl[0:3];
//	 reg [1:0]IDEX_RDReg;
	 reg [2:0]IDEX_ALU;
	 reg [4:0] WriteRegBuffer;
	 reg DoubleReg;
	 reg [31:0] Reads[0:1];
	 reg D_addiReg;
	 reg [31:0] SEInstr2Reg;
	 
	 
	assign IDEX_Instruction = IDEX_Data[0];
	assign IDEX_ReadData1 = IDEX_Data[1];
	assign IDEX_ReadData2 = IDEX_Data[2];
	assign IDEX_Shamt = IDEX_Data[3];
	assign IDEX_SEInstr = IDEX_Data[4];
	assign IDEX_MemRead = IDEX_Ctrl[0];
	assign IDEX_MemtoReg = IDEX_Ctrl[1];
//	assign IDEX_MemWrite = IDEX_Ctrl[2];
	assign IDEX_ALUSrc = IDEX_Ctrl[2];
	assign IDEX_RegWrite = IDEX_Ctrl[3];
//	assign IDEX_RegDst = IDEX_RDReg;
	assign IDEX_ALUOp = IDEX_ALU;
	assign IDEX_WriteReg = WriteRegBuffer;
	assign IDEX_Double = DoubleReg;
	assign IDEX_RD1B = Reads[0];
	assign IDEX_RD2B = Reads[1];
	assign IDEX_addi = D_addiReg;
	assign IDEX_SEInstr2 = SEInstr2Reg;
	 
	always@(posedge Clk)begin	 

			IDEX_Data[0] <= IFID_Instruction;
			IDEX_Data[1] <= ReadData1;
			IDEX_Data[2] <= ReadData2;
			IDEX_Data[3] <= Shamt;
			IDEX_Data[4] <= SEInstr;
			IDEX_Ctrl[0] <= IFID_MemRead;
			IDEX_Ctrl[1] <= IFID_MemtoReg;
	//		IDEX_Ctrl[2] <= IFID_MemWrite;
			IDEX_Ctrl[2] <= IFID_ALUSrc;
			IDEX_Ctrl[3] <= IFID_RegWrite;
	//		IDEX_RDReg <= IFID_RegDst;
			IDEX_ALU <= IFID_ALUOp;
			WriteRegBuffer <= WriteReg;
			DoubleReg <= Double;
			Reads[0] <= ReadData1B;
			Reads[1] <= ReadData2B;
			D_addiReg <= D_addi;
			SEInstr2Reg <= SEInstr2;
			
	end


endmodule
