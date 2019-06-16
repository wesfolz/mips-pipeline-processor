`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - PCAdder_tb.v
// Description - Test the 'PCAdder.v' module.
// 
//Wesley Folz
//Anthony Giang
//
////////////////////////////////////////////////////////////////////////////////

module PCAdder_tb();

    reg [31:0] PCResult;

    wire [31:0] PCAddResult;

    PCAdder u0(
        .PCResult(PCResult), 
        .PCAddResult(PCAddResult)
    );

	initial begin
	
    /* Please fill in the implementation here... */
	 
	 #10;
	 PCResult <= 0;
	 $display("PCAddResult=%h", PCAddResult);
	 #10;
	 PCResult <= 1;
	 $display("PCAddResult=%h", PCAddResult);
	 
	 #10;
	 PCResult <= 5;
	 $display("PCAddResult=%h", PCAddResult);
	 
	 #10;
	 PCResult <= 10;
	 $display("PCAddResult=%h", PCAddResult);
	
	end

endmodule

