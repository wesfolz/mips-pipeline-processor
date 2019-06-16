`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:03:41 10/07/2013 
// Design Name: 
// Module Name:    Top_Datapath_tb 
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
module Top_Datapath_tb();

	reg Clk;
	reg Reset;
	wire [31:0] Output1;
	wire [31:0] Output2;

	Top_Datapath u0(
		.Clk(Clk),
		.Reset(Reset),
		.Output1(Output1),
		.Output2(Output2)
		);
		
	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	#10;

	Reset <= 1;
	
	#10;
	
	Reset <= 0;

	
	
	end



endmodule
