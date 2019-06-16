`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:56 10/27/2013 
// Design Name: 
// Module Name:    Buffer_IFID 
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
module Buffer_IFID(
	input Clk,
   input [31:0] Instruction,
	input [31:0] PC_Next,
//	input IFFlush,
//	input IFIDWrite,
//	output reg IFID_Flush,
	output reg [31:0] IFID_Instruction,
	output reg [31:0] IFID_PC_Next
	);

	
	reg [31:0]IFID_Data[0:1];
//	reg regIFFlush;
	
//	assign IFID_Instruction = IFID_Data[0];
//	assign IFID_PC_Next = IFID_Data[1];
	
	
	always@(posedge Clk)begin
	
	/*
		if(IFFlush == 1)begin
			IFID_Data[0] <= 32'h00000000;
			IFID_Data[1] <= 32'h00000000;
			regIFFlush <= 1;
		
		end
		
		else begin
		
		*/
		/*
			if(IFIDWrite == 0)begin
				//it will do nothing
			end
			*/
			
		//	else begin
				IFID_Data[0] <= Instruction;
				IFID_Data[1] <= PC_Next;
			//	regIFFlush <= 0;
		//	end
			
	//	end
	end

//	always@(IFID_Data[0], IFID_Data[1],regIFFlush) begin
	always@(IFID_Data[0], IFID_Data[1]) begin

				IFID_Instruction <= IFID_Data[0];
				IFID_PC_Next <= IFID_Data[1];
//				IFID_Flush <= regIFFlush;
	end
		

	

endmodule
