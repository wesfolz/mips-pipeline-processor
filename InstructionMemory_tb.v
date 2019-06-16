`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - InstructionMemory_tb.v
// Description - Test the 'InstructionMemory_tb.v' module.
// 
//Wesley Folz
//Anthony Giang
//
////////////////////////////////////////////////////////////////////////////////

module InstructionMemory_tb(); 

    wire [31:0] Instruction;

    reg [31:0] Address;

	InstructionMemory u0(
		.Address(Address),
        .Instruction(Instruction)
	);

	initial begin
	
    /* Please fill in the implementation here... */
	 
	#50;
	Address <= 3;
	 
	 
	#50;
	Address <= 5;
	
 end

endmodule

