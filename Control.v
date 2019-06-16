`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:40 10/07/2013 
// Design Name: 
// Module Name:    Control 
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
module Control(Instruction, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, RegWrite, ALUSrc,Double,D_addi);

		input [5:0] Instruction;
		output reg Jump, Branch, MemRead, MemtoReg, RegWrite;
		output reg ALUSrc;
		output reg [2:0] ALUOp;
		output reg [1:0] RegDst;
		output reg Double;
		output reg D_addi;

	 
	always@(Instruction) begin
	
			if( Instruction[5:4] == 2'b11 )begin
					RegDst <= 2'b01;
					Jump <= 0;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 0;
					ALUOp <= 3'b000;
					ALUSrc <= 0;
					RegWrite <= 1;
					Double <= 1;
			end
	
	
			else begin
				Double <= 0;
			end
		
			case(Instruction)
				
				//Daddi
				6'b001110: begin //addi
					RegDst <= 2'b00;
					Jump <= 0;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 0;
					ALUOp <= 3'b010; 
					ALUSrc <= 1;
					RegWrite <= 1;
					D_addi <= 1;
				end
				
				
				//addj
				6'b001111: begin
					RegDst <= 2'b01;		
					Jump <= 1;
					Branch <= 0;
					MemRead <= 0;		
					MemtoReg <= 0;		
					ALUOp <= 3'b111; 
					ALUSrc <= 0;		
					RegWrite <= 1;
					D_addi <= 0;					
				end
				
				

				
				6'b00000:begin		//R Type no shamt(add, and, sub, nor, or, slt, sllv, srav, srlv, xor) , JR
					RegDst <= 2'b01;
					Jump <= 0;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 0;
					ALUOp <= 3'b000;
				//	MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 1;
					D_addi <= 0;
				end
			
	
				6'b001000: begin //addi
					RegDst <= 2'b00;
					Jump <= 0;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 0;
					ALUOp <= 3'b010; 
				//	MemWrite <= 0;
					ALUSrc <= 1;
					RegWrite <= 1;
					D_addi <= 0;
				end
					
				6'b011100: begin //mul
					RegDst <= 2'b01;
					Jump <= 0;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 0;
					ALUOp <= 3'b001; 
				//	MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 1;
					D_addi <= 0;
				end
				
				
				//////////////////
				
				
				//lw
				6'b100011: begin
					RegDst <= 2'b00;
					Jump <= 0;
					Branch <= 0;
					MemRead <= 1;
					MemtoReg <= 1;
					ALUOp <= 3'b011; 
				//	MemWrite <= 0;
					ALUSrc <= 1;
					RegWrite <= 1;
					D_addi <= 0;
				end
			
				//beq
				6'b000100: begin
					RegDst <= 2'b01;
					Jump <= 0;
					Branch <= 1;
					MemRead <= 0;
					MemtoReg <= 0;
					ALUOp <= 3'b100; 
			//		MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					D_addi <= 0;
				end
				
				
				//bne
				6'b000101: begin
					RegDst <= 2'b01;
					Jump <= 0;
					Branch <= 1;
					MemRead <= 0;
					MemtoReg <= 0;
					ALUOp <= 3'b101; 
				//	MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					D_addi <= 0;
				end
			
			
				//j
				6'b000010: begin
					RegDst <= 2'b01;		//don't care
					Jump <= 1;
					Branch <= 0;
					MemRead <= 0;		//don't care
					MemtoReg <= 0;		//don't care
					ALUOp <= 3'b111; //don't care
			//		MemWrite <= 0;
					ALUSrc <= 0;		//don't care
					RegWrite <= 0;
					D_addi <= 0;
				end
			
				
			endcase



	end





endmodule
