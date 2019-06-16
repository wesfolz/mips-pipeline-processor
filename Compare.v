`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:07:44 10/28/2013 
// Design Name: 
// Module Name:    Compare 
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
module Compare(	
		input signed [31:0] A,
		input signed [31:0] B,
		input [2:0] ALUOp,
		output Take_Branch
		);
		
		reg Compare;
		assign Take_Branch = Compare;
		
		
		always@(ALUOp,A,B) begin
		
			case(ALUOp)
				
				//beq
				3'b100: begin
					if(A==B)begin
						Compare <= 1;
					end
					else begin
						Compare <= 0;
					end
				end		
				
				//bne
				3'b101: begin
						if(A == B) begin 
							Compare <= 0;
						end
						else begin
							Compare <= 1;
						end
					end
						
			endcase
		
		end
		

		

endmodule
