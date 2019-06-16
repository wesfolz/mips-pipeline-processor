`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - pc_register.v
// Description - 32-Bit program counter (PC) register.
//
// 
//Wesley Folz
//Anthony Giang
//
// INPUTS:-
// Address: 32-Bit address input port.
// Reset: 1-Bit input control signal.
// Clk: 1-Bit input clock signal.
//
// OUTPUTS:-
// PCResult: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design a program counter register that holds the current address of the 
// instruction memory.  This module should be updated at the positive edge of 
// the clock. The contents of a register default to unknown values or 'X' upon 
// instantiation in your module. Hence, please add a synchronous 'Reset' 
// signal to your PC register to enable global reset of your datapath to point 
// to the first instruction in your instruction memory (i.e., the first address 
// location, 0x00000000H).
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter(Address, PCResult, Reset, Clk);

	input [31:0] Address;
	input Reset, Clk;
//	input PCWrite;

	output [31:0] PCResult;


	 reg [31:0] Result;
	 
	 assign PCResult = Result;
	 
	 
	 always@(posedge Clk)begin
		
		if(Reset == 1)begin
			Result <= 32'h00000000;
		end
/*
		//PCWrite = 1 means the Program counter will act normally, = 0 means it will stall
		else if(PCWrite == 0) begin
				
		end
	*/
		else begin
				Result <= Address;
		end
	
	
	 end
	 
	 

endmodule

