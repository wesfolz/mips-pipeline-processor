`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:43:44 10/24/2013 
// Design Name: 
// Module Name:    Forwarding_Unit 
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
module Forwarding_Unit(
		input [4:0] IDEX_RS,
		input [4:0] IDEX_RT,
		input [4:0] EXMEM_RD,
		input [4:0] MEMWB_RD,
		input MEMWB_RegWrite,
		input EXMEM_RegWrite,
		output reg [1:0] ForwardRS,
		output reg [1:0] ForwardRT,
		input [4:0] IFID_RS,
		input [4:0] IFID_RT,
		output reg [1:0]ForwardRegRS,
		output reg [1:0]ForwardRegRT,
		input [4:0] WriteReg,
		input IDEX_RegWrite,
		input EXMEM_MemRead,
		input IFID_Branch
		);	 
	 

	always@(IDEX_RS, IDEX_RT, IFID_RS, IFID_RT, MEMWB_RegWrite, EXMEM_RegWrite, EXMEM_RD, MEMWB_RD,EXMEM_MemRead,IDEX_RegWrite,IFID_Branch,WriteReg)begin

		if(IDEX_RegWrite != 1 && MEMWB_RegWrite != 1) begin
			ForwardRegRS <= 2'b00;
			ForwardRegRT <= 2'b00;
		
		end
		
		if(MEMWB_RegWrite!=1 && EXMEM_RegWrite!=1) begin
			ForwardRS <= 2'b00;
			ForwardRT <= 2'b00;
		end

		if(EXMEM_MemRead==1)begin
			if(EXMEM_RD== IDEX_RS)begin
				ForwardRS <= 2'b11;
			end
			
			if(EXMEM_RD == IDEX_RT)begin
				ForwardRT <= 2'b11;
			end
		
			if(IFID_Branch == 1)begin
			
				if(EXMEM_RD == IFID_RS)begin
					ForwardRegRS <= 2'b11;
				end
				
				if(EXMEM_RD == IFID_RT)begin
					ForwardRegRT <= 2'b11;
				end
			
			
			
			end
			

		
		end
		
		
		

		if(MEMWB_RegWrite==1)begin
			if(MEMWB_RD != 0)begin
						
						
				if(IDEX_RT == MEMWB_RD)begin
					ForwardRT <= 2'b10;
				end
				
				else if(IDEX_RT != EXMEM_RD || EXMEM_RegWrite!=1)begin
					ForwardRT <= 2'b00;
				end
				

				if(IDEX_RS == MEMWB_RD)begin
					ForwardRS <= 2'b01;
				end
						
				else if(IDEX_RS != EXMEM_RD || EXMEM_RegWrite!=1)begin
					ForwardRS <= 2'b00;
				end
				
				
				
				if(IFID_RS == MEMWB_RD)begin
					ForwardRegRS <= 2'b01;
				end
				
				else if(IFID_RS != WriteReg || IDEX_RegWrite!=1) begin
					ForwardRegRS <= 2'b00;
				end
				
				if(IFID_RT == MEMWB_RD)begin
					ForwardRegRT <= 2'b01;
				end
				
				else if(IFID_RT != WriteReg || IDEX_RegWrite!=1) begin
					ForwardRegRT <= 2'b00;
				end
				
				
			end
			else begin
				if(IDEX_RS != EXMEM_RD || EXMEM_RegWrite!=1) begin
					ForwardRS <= 2'b00;
				end
				
				if(IDEX_RT != EXMEM_RD || EXMEM_RegWrite!=1) begin
					ForwardRT <= 2'b00;
				end
				
			end
			
		end
		

		 if(EXMEM_RegWrite==1 && EXMEM_MemRead != 1)begin
			if(EXMEM_RD != 0)begin
			
				if(IDEX_RT == EXMEM_RD)begin
					ForwardRT <= 2'b01;
				end
			
				else if (IDEX_RT != MEMWB_RD || MEMWB_RegWrite != 1)begin
					ForwardRT <= 2'b00;
				end
			
				if(IDEX_RS == EXMEM_RD)begin
					ForwardRS <= 2'b10;
				end
				
				else if (IDEX_RS != MEMWB_RD || MEMWB_RegWrite != 1)begin
					ForwardRS <= 2'b00;
				end
/*				
				if(IFID_RS == EXMEM_RD)begin
					ForwardRegRS <= 2'b10;
				end
				
				else if(IFID_RS != MEMWB_RD || MEMWB_RegWrite != 1) begin
					ForwardRegRS <= 2'b00;
				end
				
				if(IFID_RT == EXMEM_RD)begin
					ForwardRegRT <= 2'b01;
				end
				
				else if(IFID_RT != MEMWB_RD || MEMWB_RegWrite != 1) begin
					ForwardRegRT <= 2'b00;
				end
	*/			
				
			end
			else begin
				if(IDEX_RS != MEMWB_RD || MEMWB_RegWrite != 1) begin
					ForwardRS <= 2'b00;
				end
				
				if(IDEX_RT != MEMWB_RD || MEMWB_RegWrite != 1) begin
					ForwardRT <= 2'b00;
				end
				
			end
			
			
		end
		
		if(IDEX_RegWrite == 1) begin
			
			if(WriteReg != 0) begin
				
				if(IFID_RS == WriteReg)begin
					ForwardRegRS <= 2'b10;
				end
				
				else if(IFID_RS != MEMWB_RD || MEMWB_RegWrite != 1) begin
					ForwardRegRS <= 2'b00;
				end
				
				if(IFID_RT == WriteReg)begin
					ForwardRegRT <= 2'b10;
				end
				
				else if(IFID_RT != MEMWB_RD || MEMWB_RegWrite != 1) begin
					ForwardRegRT <= 2'b00;
				end
			
			end
			
			else begin
				if(IFID_RS != MEMWB_RD || MEMWB_RegWrite != 1) begin
					ForwardRegRS <= 2'b00;
				end
				
				if(IFID_RT != MEMWB_RD || MEMWB_RegWrite != 1) begin
					ForwardRegRT <= 2'b00;
				end
				
			end
		
		
		end
		
		
	
	end
	
	


endmodule
