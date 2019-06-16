`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - PCAdder.v
// Description - 32-Bit program counter (PC) adder.
// 
// 
//Wesley Folz
//Anthony Giang
//
// INPUTS:-
// PCResult: 32-Bit input port.
// 
// OUTPUTS:-
// PCAddResult: 32-Bit output port.
//
// FUNCTIONALITY:-
// Design an incrementor (or a hard-wired ADD ALU whose first input is from the 
// PC, and whose second input is a hard-wired 4) that computes the current 
// PC + 4. The result should always be an increment of the signal 'PCResult' by 
// 4 (i.e., PCAddResult = PCResult + 4).
////////////////////////////////////////////////////////////////////////////////
module PCAdder(PCResult, PCAddResult);

    input [31:0] PCResult;

    output [31:0] PCAddResult;

    /* Please fill in the implementation here... */
	 
	reg [31:0] PCAdd;
//	 assign PCAddResult = PCAdd;
	 
	wire [31:0]p,g,c;
	

   assign p[31:0]=PCResult[31:0]^4;
   assign g[31:0]=PCResult[31:0]&4;
   assign c[0]=g[0];
   assign c[31:1]=g[31:1]|(p[31:1]&c[31:0]);
   assign PCAddResult[0]=p[0];
   assign PCAddResult[31:1]=p[31:1]^c[31:0];
	 
/*	 
	 always@(PCResult) begin
			PCAdd <= PCResult + 4;
	end

	*/
	
endmodule
