`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:40:18 10/08/2013 
// Design Name: 
// Module Name:    SignExtender5to32 
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
module SignExtender5to32(in, out);

    input [4:0] in;

    output [31:0] out;


	assign out = {{27{in[4]}}, in[4:0]};


endmodule
