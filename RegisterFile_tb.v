`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 2
// Module - RegisterFile.v
//
// Student(s) Name and Last Name: Anthony Giang, Wesley Folz
//
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

	reg [4:0] ReadRegister1;
	reg [4:0] ReadRegister2;
	reg [4:0] WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite;
	reg Clk;

	wire [31:0] ReadData1;
	wire [31:0] ReadData2;

	integer i;

	RegisterFile u0(
		.ReadRegister1(ReadRegister1), 
		.ReadRegister2(ReadRegister2), 
		.WriteRegister(WriteRegister), 
		.WriteData(WriteData), 
		.RegWrite(RegWrite), 
		.Clk(Clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin

		#10; 
		RegWrite <= 1;

    /* Please fill in the implementation here... */
		for(i=0; i<=31; i=i+1)begin
			#20;
			WriteRegister <= i; 
			WriteData <= i;
		end
		
		#10;
		RegWrite <= 0;
		
		for(i=0; i<=31; i=i+1)begin
			#20;
			ReadRegister1 <= i; 
			ReadRegister2 <= i + 1;
			#10;
			$display("ReadData1=%h, ReadData2=%h", ReadData1, ReadData2);
		end
		
	end

endmodule

