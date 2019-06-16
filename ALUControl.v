`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:54 10/07/2013 
// Design Name: 
// Module Name:    ALUControl 
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
module ALUControl(ALUOp, ALUCtrl, FunctionField, shift,Double);

	input [2:0] ALUOp; 
	input [5:0] FunctionField;
	output reg [2:0] ALUCtrl;
	output reg shift;
	input Double;

	always@(FunctionField, ALUOp) begin
		shift <= 0;
	if(ALUOp == 3'b000) begin

		if(Double==1)begin
			ALUCtrl <= 3'b000;
		end

		else begin

			case(FunctionField)

			6'b100000: ALUCtrl <= 3'b000;		//add
		
			6'b100010: ALUCtrl <= 3'b001;		//sub	
		
		

			
			6'b000000: begin
						ALUCtrl <= 3'b100;		//sll	
						shift <= 1;
			end
			
		//	6'b000100: ALUCtrl <= 5'b01011;		//sllv
			
			6'b101010: ALUCtrl <= 3'b010;		//slt
		/*		
			6'b000011: begin 
						ALUCtrl <= 5'b00111;		//sra	
						shift <= 1;
			end
			6'b000111: ALUCtrl <= 5'b01000;		//srav
			
			6'b000010: begin
						ALUCtrl <= 5'b01111;		//srl
						shift <= 1;
			end
			6'b000110: ALUCtrl <= 5'b01111;		//srlv

			6'b100110: ALUCtrl <= 5'b01001;		//xor
				
			*/
			

			endcase
		end
	end
	
	else if(ALUOp == 3'b001) begin
		if(FunctionField == 6'b000010) begin
			ALUCtrl <= 3'b011;		//mul
		end
	end
	
	else begin

		case(ALUOp) 
	//		4'b0001: ALUCtrl <= 5'b00000;		//andi
			3'b010: ALUCtrl <= 3'b000;		//addi
		//	4'b0011: ALUCtrl <= 5'b00100;		//ori
		//	4'b0100: ALUCtrl <= 5'b00110;		//slti
		//	4'b0101: ALUCtrl <= 5'b01001;		//xori
			
			
			3'b011: ALUCtrl <= 3'b000; //lw, sw (alu will add)

			3'b111: ALUCtrl <= 3'b000; //addj (alu will add)




		endcase
	end
		
end


endmodule

