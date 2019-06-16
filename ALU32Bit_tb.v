`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
// 
//Wesley Folz
//Anthony Giang
//
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	
    /* Please fill in the implementation here... */
	 
	#100;
	A <= 32'h00000001;
	B <= 32'h00000002;
	#100;
	ALUControl <= 4'b0010; //add = 3
	#10;
	$display("ALUResult=%h", ALUResult);
	$display("Zero=%h", Zero);
	if(Zero != 1) begin
		$display("Passed!");
	end
	else begin
		$display("Failed");
	end
	
	#100;
	B <= 32'h00000001;
	#100;
	ALUControl <= 4'b0110; //subtract = 0
	#10;
	$display("ALUResult=%h", ALUResult);
	$display("Zero=%h", Zero);
	if(Zero == 1) begin
		$display("Passed!");
	end
	else begin
		$display("Failed");
	end

	#100;
	B <= 32'h00000002;
	ALUControl <= 4'b0111; //slt = 1
	#10;
	$display("ALUResult=%h", ALUResult);
	$display("Zero=%h", Zero);
	if(Zero != 1) begin
		$display("Passed!");
	end
	else begin
		$display("Failed");
	end

	
	#100;
	B <= 32'h00000001;
	ALUControl <= 4'b0000; //and = 1
	#100;
	$display("ALUResult=%h", ALUResult);
	$display("Zero=%h", Zero);
	if(Zero != 1) begin
		$display("Passed!");
	end
	else begin
		$display("Failed");
	end
	
	#100;
	B <= 32'h00000000;
	ALUControl <= 4'b0000; //and = 0
	#10;
	$display("ALUResult=%h", ALUResult);
	$display("Zero=%h", Zero);
	if(Zero == 1) begin
		$display("Passed!");
	end
	else begin
		$display("Failed");
	end
	
	#100;
	A <= 32'h00000000;
	ALUControl <= 4'b0001; //Or = 0
	#10;
	$display("ALUResult=%h", ALUResult);
	$display("Zero=%h", Zero);
	if(Zero == 1) begin
		$display("Passed!");
	end
	else begin
		$display("Failed");
	end
	
	#100;
	A <= 32'h00000001;
	ALUControl <= 4'b0001; //Or = 1
	#10;
	$display("ALUResult=%h", ALUResult);
	$display("Zero=%h", Zero);
	if(Zero != 1) begin
		$display("Passed!");
	end
	else begin
		$display("Failed");
	end
	
	end

endmodule

