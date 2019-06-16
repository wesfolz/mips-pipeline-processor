`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// ADD  | 0010
// SUB  | 0110
// AND  | 0000
// OR   | 0001
// SLT  | 0111
//
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
// 
//Wesley Folz
//Anthony Giang
//
////////////////////////////////////////////////////////////////////////////////
module ALU32Bit(ALUCtrl, A, B, ALUResult);




	input [2:0] ALUCtrl; // control bits for ALU operation
	input signed [31:0] A, B;	    // inputs

	output[31:0] ALUResult;	// answer


	 
	 reg [31:0] ALUtemp;
	 assign ALUResult = ALUtemp;
	 
	always@(ALUCtrl, A, B) begin
	
		case(ALUCtrl)
		
	
	//			3'b000: ALUtemp <= A + B;		//add, addi (done with carry lookahead adder)
	
				3'b001: ALUtemp <= A - B;		//sub

				//slt, slti
				3'b010: begin	
							if(A < B) begin
								ALUtemp <= 32'h00000001;
							end
							else begin
								ALUtemp <= 32'h00000000;
							end
						end		

		
				//mul
				3'b011: ALUtemp <= A * B;					
	
				//sll
				3'b100: ALUtemp <= B << A;	
	
			endcase
		
		end
	
		
	
	
	
endmodule

