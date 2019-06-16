`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
// 
//Wesley Folz
//Anthony Giang
//
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
    /* Please fill in the implementation here... */
	#10;
	//writes 3 into address of 3
	WriteData <= 32'h00000003;
	MemWrite <= 1;
	MemRead <= 0;
	Address <= 3;
	
	#10;
	MemWrite <= 0;
	MemRead <= 1;
	
	#10;
	//writes 5 into address of 7
	WriteData <= 32'h00000005;
	MemWrite <= 1;
	MemRead <= 0;
	
	Address <= 7;
	
	#10;
	MemWrite <= 0;
	MemRead <= 1;

	#10;
	WriteData <= 32'h00000007;
	MemWrite <= 1;
	MemRead <= 0;
	
	Address <= 8;

	#10;
	MemWrite <= 0;
	MemRead <= 1;
	
	
	end
	 
	 
endmodule

