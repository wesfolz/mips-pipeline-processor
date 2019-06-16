`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:44:17 10/07/2013 
// Design Name: 
// Module Name:    ALUControl_tb 
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
module ALUControl_tb();

	reg [4:0] ALUOp;
	reg [5:0] FunctionField;
	wire [5:0] ALUCtrl;


	ALUControl u0(
			.ALUOp(ALUOp),
			.ALUCtrl(ALUCtrl),
			.FunctionField(FunctionField)
	);


	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
	
	
	
	end



endmodule
