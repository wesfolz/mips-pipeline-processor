`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - ProgramCounter_tb.v
// Description - Test the 'ProgramCounter.v' module.
// 
//Wesley Folz
//Anthony Giang
//
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter_tb(); 

	reg [31:0] Address;
	reg Reset, Clk;

	wire [31:0] PCResult;

    ProgramCounter u0(
        .Address(Address), 
        .PCResult(PCResult), 
        .Reset(Reset), 
        .Clk(Clk)
    );

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
    /* Please fill in the implementation here... */
	#10;
	Reset <= 1;
	Address <= 32'h00000002;
	
	#10;
	
	Reset <= 0;
	
	#20;
	Address <= 5;
	
	#20;
	Reset <= 1;
	
	end

endmodule

