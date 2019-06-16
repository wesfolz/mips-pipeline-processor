`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - memory.v
// Description - 32-Bit wide instruction memory.
//
// 
//Wesley Folz
//Anthony Giang
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// memory.  The contents of the memory is the machine 
// language program to be run on your MIPS processor.
////////////////////////////////////////////////////////////////////////////////

 module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 
    output [31:0] Instruction;    // Instruction at memory location Address
	 
	 /* Please fill in the implementation here */
	 reg [31:0] memory[0:121]; 
	 reg [31:0] RegInstruction;
	 
	 assign Instruction = RegInstruction;
	 
	 initial begin


/*
		//optimized1
		memory[0] <= 32'h00002020;	//	vbsme:		add	$a0, $0, $0
		memory[1] <= 32'h20050010;	//					addi	$a1, $0, 16
		memory[2] <= 32'h20061010;	//			addi $a2, $0, 4112 #window[0]			TestCases 5,6,7,11,13
		memory[3] <= 32'h8c880004;	//					lw	$t0, 4($a0)
		memory[4] <= 32'h8c89000c;	//					lw	$t1, 12($a0)
		memory[5] <= 32'h01098822;	//					sub	$s1, $t0, $t1
		memory[6] <= 32'h8c880000;	//					lw	$t0, 0($a0)
		memory[7] <= 32'h8c890008;	//					lw	$t1, 8($a0)
		memory[8] <= 32'h01099022;	//					sub	$s2, $t0, $t1
		memory[9] <= 32'h00004020;	//					add	$t0, $0, $0
		memory[10] <= 32'h00004820;	//					add	$t1, $0, $0
		memory[11] <= 32'h00005020;	//					add	$t2, $0, $0
		memory[12] <= 32'h00005820;	//					add	$t3, $0, $0
		memory[13] <= 32'h00a07020;	//					add	$t6, $a1, $0
		memory[14] <= 32'h00c07820;	//					add	$t7, $a2, $0
		memory[15] <= 32'h00008020;	//					add	$s0, $0, $0
		memory[16] <= 32'h0000b020;	//					add	$s6, $0, $0
		memory[17] <= 32'h00009820;	//					add	$s3, $0, $0
		memory[18] <= 32'h12000012;	//	loop0:		 	$s0, $0, moveright
		memory[19] <= 32'h0800005f;	//					j	moveleft
		memory[20] <= 32'h1112007c;	//	rmovepointer:	beq	$t0, $s2, finish
		memory[21] <= 32'h21080001;	//						addi	$t0, $t0, 1
		memory[22] <= 32'h8c8d0004;	//						lw	$t5, 4($a0)
		memory[23] <= 32'h71a86802;	//						mul	$t5, $t5, $t0
		memory[24] <= 32'h01a96820;	//						add	$t5, $t5, $t1
		memory[25] <= 32'h000d6880;	//						sll	$t5, $t5, 2
		memory[26] <= 32'h00ad7020;	//						add	$t6, $a1, $t5
		memory[27] <= 32'h22100001;	//						addi	$s0, $s0, 1
		memory[28] <= 32'h08000012;	//						j	loop0
		memory[29] <= 32'h11120073;	//	lmovepointer:	beq	$t0, $s2, finish
		memory[30] <= 32'h21080001;	//						addi	$t0, $t0, 1
		memory[31] <= 32'h8c8d0004;	//						lw	$t5, 4($a0)
		memory[32] <= 32'h71a86802;	//						mul	$t5, $t5, $t0
		memory[33] <= 32'h000d6880;	//						sll	$t5, $t5, 2
		memory[34] <= 32'h00ad7020;	//						add	$t6, $a1, $t5
		memory[35] <= 32'h2210ffff;	//						addi	$s0, $s0, -1
		memory[36] <= 32'h08000012;	//						j	loop0
		
		//Compute SAD
		memory[37] <= 32'h8dcc0000;	//	moveright:		lw	$t4, 0($t6)		 				# loading value of frame
		memory[38] <= 32'h8ded0000;	//						lw	$t5, 0($t7)						# loading value of window
		memory[39] <= 32'h01ac6022;	//						sub	$t4, $t5, $t4				# t4 = a2 - a1, difference of window - frame
		memory[40] <= 32'h0180682a;	//						slt	$t5, $t4, $0
		memory[41] <= 32'h11a00001;	//						beq	$t5, $0, rnotnegative
		memory[42] <= 32'h000c6022;	//						sub	$t4, $0, $t4
		memory[43] <= 32'h0196b020;	//	rnotnegative:	add	$s6, $t4, $s6
		memory[44] <= 32'h8c8d000c;	//						lw	$t5, 12($a0)
		memory[45] <= 32'h21adffff;	//						addi	$t5, $t5, -1
		memory[46] <= 32'h11000000;	//						beq	$t0, $0, branch
		memory[47] <= 32'h11200007;	//	branch:			beq	$t1, $0, rcheckL
		memory[48] <= 32'h0276c02a;	//						slt	$t8, $s3, $s6
		memory[49] <= 32'h13000005;	//						beq	$t8, $0, rcheckL
		memory[50] <= 32'h01abc022;	//						sub	$t8, $t5, $t3
		memory[51] <= 32'b0000000000011000110000001000000;	//						sll	$t8, $t8, 2 h0018c100
		memory[52] <= 32'h01d87020;	//						add	$t6, $t6, $t8
		memory[53] <= 32'h01f87820;	//						add	$t7, $t7, $t8
		memory[54] <= 32'h01a05820;	//						add	$t3, $t5, $0
		memory[55] <= 32'h116d001c;	//	rcheckL:			beq	$t3, $t5, rloop2Increase
		memory[56] <= 32'h216b0001;	//						addi	$t3, $t3, 1
		memory[57] <= 32'h21ce0004;	//						addi	$t6, $t6, 4
		memory[58] <= 32'h21ef0004;	//						addi	$t7, $t7, 4
		memory[59] <= 32'h08000025;	//						j	moveright
		memory[60] <= 32'h15000004;	//	rloop1Increase:	bne	$t0, $0, rskip
		memory[61] <= 32'h15200003;	//							bne	$t1, $0, rskip
		memory[62] <= 32'h02c09820;	//							add	$s3, $s6, $0
		memory[63] <= 32'h0100a020;	//			add	$s4, $t0, $0
		memory[64] <= 32'h0120a820;	//			add	$s5, $t1, $0
		memory[65] <= 32'h02d3682a;	//	rskip:		slt	$t5, $s6, $s3
		memory[66] <= 32'h11a00003;	//			beq	$t5, $0, rskip2
		memory[67] <= 32'h02c09820;	//			add	$s3, $s6, $0
		memory[68] <= 32'h0100a020;	//			add	$s4, $t0, $0
		memory[69] <= 32'h0120a820;	//			add	$s5, $t1, $0
		memory[70] <= 32'h0000b020;	//	rskip2:		add	$s6, $0, $0
		memory[71] <= 32'h00c07820;	//			add	$t7, $a2, $0
		memory[72] <= 32'h00005020;	//			add	$t2, $0, $0
		memory[73] <= 32'h00005820;	//			add	$t3, $0, $0
		memory[74] <= 32'h00116820;	//			add	$t5, $0, $s1
		memory[75] <= 32'h112dffc8;	//			beq	$t1, $t5, rmovepointer
		//112dffca
		memory[76] <= 32'h21290001;	//			addi	$t1, $t1, 1
		memory[77] <= 32'h8c8d0000;	//			lw	$t5, 0($a0)
		memory[78] <= 32'h71a86802;	//			mul	$t5, $t5, $t0
		memory[79] <= 32'h01a96820;	//			add	$t5, $t5, $t1
		memory[80] <= 32'h000d6880;	//			sll	$t5, $t5, 2
		memory[81] <= 32'h01a57020;	//			add	$t6, $t5, $a1
		memory[82] <= 32'h00006020;	//			add	$t4, $0, $0
		memory[83] <= 32'h08000025;	//			j	moveright
		memory[84] <= 32'h8c8d0008;	//	rloop2Increase:	lw	$t5, 8($a0)
		memory[85] <= 32'h21adffff;	//			addi	$t5, $t5, -1
		memory[86] <= 32'h114dffe5;	//			beq	$t2, $t5, rloop1Increase
		//114dffe7
		memory[87] <= 32'h214a0001;	//			addi	$t2, $t2, 1
		memory[88] <= 32'h00005820;	//			add	$t3, $0, $0
		memory[89] <= 32'h02206820;	//			add	$t5, $s1, $0
		memory[90] <= 32'h21ad0001;	//			addi	$t5, $t5, 1
		memory[91] <= 32'h000d6880;	//			sll	$t5, $t5, 2
		memory[92] <= 32'h01cd7020;	//			add	$t6, $t6, $t5
		memory[93] <= 32'h21ef0004;	//			addi	$t7, $t7, 4
		memory[94] <= 32'h08000025;	//			j	moveright
		memory[95] <= 32'h8dcc0000;	//	moveleft:	lw	$t4, 0($t6)
		memory[96] <= 32'h8ded0000;	//			lw	$t5, 0($t7)
		memory[97] <= 32'h01ac6022;	//			sub	$t4, $t5, $t4
		memory[98] <= 32'h0180682a;	//			slt	$t5, $t4, $0
		memory[99] <= 32'h11a00001;	//			beq	$t5, $0, lnotnegative
		memory[100] <= 32'h000c6022;	//			sub	$t4, $0, $t4
		memory[101] <= 32'h0196b020;	//	lnotnegative:	add	$s6, $t4, $s6
		memory[102] <= 32'h8c8d000c;	//			lw	$t5, 12($a0)
		memory[103] <= 32'h21adffff;	//			addi	$t5, $t5, -1
		memory[104] <= 32'h0276c02a;	//			slt	$t8, $s3, $s6
		memory[105] <= 32'h13000005;	//			beq	$t8, $0, lcheckL
		memory[106] <= 32'h01abc022;	//			sub	$t8, $t5, $t3
		
		memory[107] <= 32'b0000000000011000110000001000000;	//			sll	$t8, $t8, 2 hello h0018c100
		memory[108] <= 32'h01d87020;	//			add	$t6, $t6, $t8
		memory[109] <= 32'h01f87820;	//			add	$t7, $t7, $t8
		memory[110] <= 32'h01a05820;	//			add	$t3, $t5, $0
		memory[111] <= 32'h116d0016;	//	lcheckL:	beq	$t3, $t5, lloop2Increase
		memory[112] <= 32'h21ce0004;	//			addi	$t6, $t6, 4
		memory[113] <= 32'h21ef0004;	//			addi	$t7, $t7, 4
		memory[114] <= 32'h216b0001;	//			addi	$t3, $t3, 1
		memory[115] <= 32'h0800005f;	//			j	moveleft
		memory[116] <= 32'h02d3682a;	//	lloop1Increase:	slt	$t5, $s6, $s3
		memory[117] <= 32'h11a00003;	//			beq	$t5, $0, lskip
		memory[118] <= 32'h02c09820;	//			add	$s3, $s6, $0
		memory[119] <= 32'h0100a020;	//			add	$s4, $t0, $0
		memory[120] <= 32'h0120a820;	//			add	$s5, $t1, $0
		memory[121] <= 32'h0000b020;	//	lskip:		add	$s6, $0, $0
		memory[122] <= 32'h00c07820;	//			add	$t7, $a2, $0
		memory[123] <= 32'h00005020;	//			add	$t2, $0, $0
		memory[124] <= 32'h00005820;	//			add	$t3, $0, $0
		memory[125] <= 32'h1120ff9f;	//			beq	$t1, $0, lmovepointer
		//1120ffa1
		memory[126] <= 32'h2129ffff;	//			addi	$t1, $t1, -1
		memory[127] <= 32'h8c8d0000;	//			lw	$t5, 0($a0)
		memory[128] <= 32'h71a86802;	//			mul	$t5, $t5, $t0
		memory[129] <= 32'h01a96820;	//			add	$t5, $t5, $t1
		memory[130] <= 32'h000d6880;	//			sll	$t5, $t5, 2
		memory[131] <= 32'h01a57020;	//			add	$t6, $t5, $a1
		memory[132] <= 32'h00006020;	//			add	$t4, $0, $0
		memory[133] <= 32'h0800005f;	//			j	moveleft
		memory[134] <= 32'h8c8d0008;	//	lloop2Increase:	lw	$t5, 8($a0)
		memory[135] <= 32'h21adffff;	//			addi	$t5, $t5, -1
		memory[136] <= 32'h114dffeb;	//			beq	$t2, $t5, lloop1Increase
		//114dffed
		memory[137] <= 32'h214a0001;	//			addi	$t2, $t2, 1
		memory[138] <= 32'h00005820;	//			add	$t3, $0, $0
		memory[139] <= 32'h02206820;	//			add	$t5, $s1, $0
		memory[140] <= 32'h21ad0001;	//			addi	$t5, $t5, 1
		memory[141] <= 32'h000d6880;	//			sll	$t5, $t5, 2
		memory[142] <= 32'h01cd7020;	//			add	$t6, $t6, $t5
		memory[143] <= 32'h21ef0004;	//			addi	$t7, $t7, 4
		memory[144] <= 32'h0800005f;	//			j	moveleft
		memory[145] <= 32'h00141020;	//	finish:		add	$v0, $0, $s4
		memory[146] <= 32'h00151820;	//			add	$v1, $0, $s5
		memory[147] <= 32'h08000093;   // J 147


/*
		//With Checking
		memory[0] = 32'h00002020;	//	vbsme:		add	$a0, $0, $0
		memory[1] = 32'h20050010;	//			addi	$a1, $0, 16
		memory[2] = 32'h20061010;	//			addi	$a2, $0, 4112
		memory[3] = 32'h2011001c;	//			addi	$s1, $0, 28
		
		
		//add here
		memory[4] = 32'b11000000000001000000000000001001;		//add	$t0, $0, $0,$t1, $0, $0	
//		memory[4] = 32'h00004020;	//			add	$t0, $0, $0
//		memory[5] = 32'h00004820;	//			add	$t1, $0, $0
		
		//add here
		memory[5] = 32'b11000000000001010000000000001011;		//add	$t2, $0, $0,add	$t3, $0, $0
//		memory[6] = 32'h00005020;	//			add	$t2, $0, $0
//		memory[7] = 32'h00005820;	//			add	$t3, $0, $0
		
		//add here
		memory[6] = 32'b11001010000001110001100000001111;	//add	$t6, $a1, $0,add	$t7, $a2, $0	
//		memory[8] = 32'h00a07020;	//			add	$t6, $a1, $0
//		memory[9] = 32'h00c07820;	//			add	$t7, $a2, $0
		
		//add here
		memory[7] = 32'b11000000000010000000000000010110;	//add	$s0, $0, $0,add	$s6, $0, $0	
//		memory[10] = 32'h00008020;	//			add	$s0, $0, $0
//		memory[11] = 32'h0000b020;	//			add	$s6, $0, $0
		
		
		memory[12] = 32'h00009820;	//			add	$s3, $0, $0
		memory[13] = 32'h12000012;	//	loop0:		beq	$s0, $0, moveright
		memory[14] = 32'h0800005a;	//			j	moveleft
		memory[15] = 32'h1111007b;	//	rmovepointer:	beq	$t0, $s1, finish
		memory[16] = 32'h21080001;	//			addi	$t0, $t0, 1
		memory[17] = 32'h8c8d0004;	//			lw	$t5, 4($a0)
		memory[18] = 32'h71a86802;	//			mul	$t5, $t5, $t0
		memory[19] = 32'h01a96820;	//			add	$t5, $t5, $t1
		memory[20] = 32'h000d6880;	//			sll	$t5, $t5, 2
		memory[21] = 32'h00ad7020;	//			add	$t6, $a1, $t5
		memory[22] = 32'h22100001;	//			addi	$s0, $s0, 1
		memory[23] = 32'h0800000d;	//			j	loop0
		memory[24] = 32'h11110072;	//	lmovepointer:	beq	$t0, $s1, finish
		memory[25] = 32'h21080001;	//			addi	$t0, $t0, 1
		memory[26] = 32'h8c8d0004;	//			lw	$t5, 4($a0)
		memory[27] = 32'h71a86802;	//			mul	$t5, $t5, $t0
		memory[28] = 32'h000d6880;	//			sll	$t5, $t5, 2
		memory[29] = 32'h00ad7020;	//			add	$t6, $a1, $t5
		memory[30] = 32'h2210ffff;	//			addi	$s0, $s0, -1
		memory[31] = 32'h0800000d;	//			j	loop0
		memory[32] = 32'h8dcc0000;	//	moveright:	lw	$t4, 0($t6)
		memory[33] = 32'h8ded0000;	//			lw	$t5, 0($t7)
		memory[34] = 32'h01ac6022;	//			sub	$t4, $t5, $t4
		memory[35] = 32'h0180682a;	//			slt	$t5, $t4, $0
		memory[36] = 32'h11a00001;	//			beq	$t5, $0, rnotnegative
		memory[37] = 32'h000c6022;	//			sub	$t4, $0, $t4
		memory[38] = 32'h0196b020;	//	rnotnegative:	add	$s6, $t4, $s6
		memory[39] = 32'h8c8d000c;	//			lw	$t5, 12($a0)
		memory[40] = 32'h21adffff;	//			addi	$t5, $t5, -1
		memory[41] = 32'h11000000;	//			beq	$t0, $0, branch
		memory[42] = 32'h11200007;	//	branch:		beq	$t1, $0, rcheckL
		memory[43] = 32'h0276c02a;	//			slt	$t8, $s3, $s6
		memory[44] = 32'h13000005;	//			beq	$t8, $0, rcheckL
		memory[45] = 32'h01abc022;	//			sub	$t8, $t5, $t3
		memory[46] = 32'h0018c100;	//			sll	$t8, $t8, 4
		
		//add here
		//memory[] = 32'b11011101100001110011111100001111;	//add	$t6, $t6, $t8,add	$t7, $t7, $t8
		memory[47] = 32'h01d87020;	//			add	$t6, $t6, $t8
		memory[48] = 32'h01f87820;	//			add	$t7, $t7, $t8
		
		memory[49] = 32'h01a05820;	//			add	$t3, $t5, $0
		memory[50] = 32'h116d001c;	//	rcheckL:	beq	$t3, $t5, rloop2Increase
		
		memory[51] = 32'h216b0001;	//			addi	$t3, $t3, 1
		memory[52] = 32'h21ce0004;	//			addi	$t6, $t6, 4
		
		memory[53] = 32'h21ef0004;	//			addi	$t7, $t7, 4
		memory[54] = 32'h08000020;	//			j	moveright
		memory[55] = 32'h15000004;	//	rloop1Increase:	bne	$t0, $0, rskip
		memory[56] = 32'h15200003;	//			bne	$t1, $0, rskip
		
		memory[57] = 32'h02c09820;	//			add	$s3, $s6, $0
		memory[58] = 32'h0100a020;	//			add	$s4, $t0, $0

		memory[59] = 32'h0120a820;	//			add	$s5, $t1, $0
		memory[60] = 32'h02d3682a;	//	rskip:		slt	$t5, $s6, $s3
		memory[61] = 32'h11a00003;	//			beq	$t5, $0, rskip2

		memory[62] = 32'h02c09820;	//			add	$s3, $s6, $0
		memory[63] = 32'h0100a020;	//			add	$s4, $t0, $0
		
		memory[64] = 32'h0120a820;	//			add	$s5, $t1, $0
		
		memory[65] = 32'h0000b020;	//	rskip2:		add	$s6, $0, $0
		memory[66] = 32'h00c07820;	//			add	$t7, $a2, $0
	
		memory[67] = 32'h00005020;	//			add	$t2, $0, $0
		memory[68] = 32'h00005820;	//			add	$t3, $0, $0
		
		memory[69] = 32'h00116820;	//			add	$t5, $0, $s1
		memory[70] = 32'h112dffc8;	//			beq	$t1, $t5, rmovepointer
		memory[71] = 32'h21290001;	//			addi	$t1, $t1, 1
		memory[72] = 32'h8c8d0000;	//			lw	$t5, 0($a0)
		memory[73] = 32'h71a86802;	//			mul	$t5, $t5, $t0
		memory[74] = 32'h01a96820;	//			add	$t5, $t5, $t1
		memory[75] = 32'h000d6880;	//			sll	$t5, $t5, 2
		
		memory[76] = 32'h01a57020;	//			add	$t6, $t5, $a1
		memory[77] = 32'h00006020;	//			add	$t4, $0, $0
		
		memory[78] = 32'h08000020;	//			j	moveright
		memory[79] = 32'h8c8d0008;	//	rloop2Increase:	lw	$t5, 8($a0)
		memory[80] = 32'h21adffff;	//			addi	$t5, $t5, -1
		memory[81] = 32'h114dffe5;	//			beq	$t2, $t5, rloop1Increase
		memory[82] = 32'h214a0001;	//			addi	$t2, $t2, 1
		
		memory[83] = 32'h00005820;	//			add	$t3, $0, $0
		memory[84] = 32'h02206820;	//			add	$t5, $s1, $0
		
		memory[85] = 32'h21ad0001;	//			addi	$t5, $t5, 1
		memory[86] = 32'h000d6880;	//			sll	$t5, $t5, 2
		memory[87] = 32'h01cd7020;	//			add	$t6, $t6, $t5
		memory[88] = 32'h21ef0004;	//			addi	$t7, $t7, 4
		memory[89] = 32'h08000020;	//			j	moveright
		memory[90] = 32'h8dcc0000;	//	moveleft:	lw	$t4, 0($t6)
		memory[91] = 32'h8ded0000;	//			lw	$t5, 0($t7)
		memory[92] = 32'h01ac6022;	//			sub	$t4, $t5, $t4
		memory[93] = 32'h0180682a;	//			slt	$t5, $t4, $0
		memory[94] = 32'h11a00001;	//			beq	$t5, $0, lnotnegative
		memory[95] = 32'h000c6022;	//			sub	$t4, $0, $t4
		memory[96] = 32'h0196b020;	//	lnotnegative:	add	$s6, $t4, $s6
		memory[97] = 32'h8c8d000c;	//			lw	$t5, 12($a0)
		memory[98] = 32'h21adffff;	//			addi	$t5, $t5, -1
		memory[99] = 32'h0276c02a;	//			slt	$t8, $s3, $s6
		memory[100] = 32'h13000005;	//			beq	$t8, $0, lcheckL
		memory[101] = 32'h01abc022;	//			sub	$t8, $t5, $t3
		memory[102] = 32'h0018c100;	//			sll	$t8, $t8, 4
		
		memory[103] = 32'h01d87020;	//			add	$t6, $t6, $t8
		memory[104] = 32'h01f87820;	//			add	$t7, $t7, $t8
		
		memory[105] = 32'h01a05820;	//			add	$t3, $t5, $0
		memory[106] = 32'h116d0016;	//	lcheckL:	beq	$t3, $t5, lloop2Increase
		memory[107] = 32'h21ce0004;	//			addi	$t6, $t6, 4
		memory[108] = 32'h21ef0004;	//			addi	$t7, $t7, 4
		memory[109] = 32'h216b0001;	//			addi	$t3, $t3, 1
		memory[110] = 32'h0800005a;	//			j	moveleft
		memory[111] = 32'h02d3682a;	//	lloop1Increase:	slt	$t5, $s6, $s3
		memory[112] = 32'h11a00003;	//			beq	$t5, $0, lskip
		
		memory[113] = 32'h02c09820;	//			add	$s3, $s6, $0
		memory[114] = 32'h0100a020;	//			add	$s4, $t0, $0
		
		memory[115] = 32'h0120a820;	//			add	$s5, $t1, $0
		
		memory[116] = 32'h0000b020;	//	lskip:		add	$s6, $0, $0
		memory[117] = 32'h00c07820;	//			add	$t7, $a2, $0
		
		memory[118] = 32'h00005020;	//			add	$t2, $0, $0
		memory[119] = 32'h00005820;	//			add	$t3, $0, $0
		
		memory[120] = 32'h1120ff9f;	//			beq	$t1, $0, lmovepointer
		memory[121] = 32'h2129ffff;	//			addi	$t1, $t1, -1
		memory[122] = 32'h8c8d0000;	//			lw	$t5, 0($a0)
		memory[123] = 32'h71a86802;	//			mul	$t5, $t5, $t0
		memory[124] = 32'h01a96820;	//			add	$t5, $t5, $t1
		memory[125] = 32'h000d6880;	//			sll	$t5, $t5, 2
		
		memory[126] = 32'h01a57020;	//			add	$t6, $t5, $a1
		memory[127] = 32'h00006020;	//			add	$t4, $0, $0
		
		memory[128] = 32'h0800005a;	//			j	moveleft
		memory[129] = 32'h8c8d0008;	//	lloop2Increase:	lw	$t5, 8($a0)
		memory[130] = 32'h21adffff;	//			addi	$t5, $t5, -1
		memory[131] = 32'h114dffeb;	//			beq	$t2, $t5, lloop1Increase
		memory[132] = 32'h214a0001;	//			addi	$t2, $t2, 1
		
		
		//new add instruction here
		memory[133] = 32'b11100010000001101000000000001011; //	add	$t5, $s1, $0, add	$t3, $0, $0
							

	//	memory[133] = 32'h00005820;	//			add	$t3, $0, $0
	//	memory[134] = 32'h02206820;	//			add	$t5, $s1, $0
		
		
		memory[134] = 32'h21ad0001;	//			addi	$t5, $t5, 1
		memory[135] = 32'h000d6880;	//			sll	$t5, $t5, 2
		memory[136] = 32'h01cd7020;	//			add	$t6, $t6, $t5
		memory[137] = 32'h21ef0004;	//			addi	$t7, $t7, 4
		memory[138] = 32'h0800005a;	//			j	moveleft
		memory[139] = 32'h00141020;	//	finish:		add	$v0, $0, $s4
		memory[140] = 32'h00151820;	//			add	$v1, $0, $s5
		memory[141] = 32'h0800008d;	//	label:		j	label
*/

	//works for competition testcase
	memory[0] = 32'b11000000000000100000000000010011;	//	vbsme:		nop //add $a0, $0, $0, add $s3, $0, $0 
	memory[1] = 32'h20050010;	//			addi	$a1, $0, 16
	memory[2] = 32'h20061010;	//			addi	$a2, $0, 4112
	memory[3] = 32'h2011001c;	//			addi	$s1, $0, 28
	memory[4] = 32'b11000000000001000000000000001001;	//			nop//add $t0, $0, $0,add $t1, $0, $0
	memory[5] = 32'b11000000000001010000000000001011;	//			nop//add $t2, $0, $0,add $t3, $0, $0
	memory[6] = 32'b11001010000001110001100000001111;	//add	$t6, $a1, $0,add	$t7, $a2, $0
	memory[7] = 32'b11000000000010000000000000010110;	//add	$s0, $0, $0,add	$s6, $0, $0
	memory[8] = 32'h12000010;	//	loop0:		beq	$s0, $0, moveright
	memory[9] = 32'h0800004c;	//			j	moveleft
	memory[10] = 32'h1111006d;	//	rmovepointer:	beq	$t0, $s1, finish
	memory[11] = 32'h21080001;	//			addi	$t0, $t0, 1
	memory[12] = 32'h8c8d0004;	//			lw	$t5, 4($a0)
	memory[13] = 32'h71a86802;	//			mul	$t5, $t5, $t0
	memory[14] = 32'h01a96820;	//			add	$t5, $t5, $t1
	memory[15] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[16] = 32'h22100001;	//			addi	$s0, $s0, 1
	memory[17] = 32'b00111100101011010111000000001000;	//			nop// addj $t6, $a1, $t5, loop0
	memory[18] = 32'h11110065;	//	lmovepointer:	beq	$t0, $s1, finish
	memory[19] = 32'h21080001;	//			addi	$t0, $t0, 1
	memory[20] = 32'h8c8d0004;	//			lw	$t5, 4($a0)
	memory[21] = 32'h71a86802;	//			mul	$t5, $t5, $t0
	memory[22] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[23] = 32'h2210ffff;	//			addi	$s0, $s0, -1
	memory[24] = 32'b00111100101011010111000000001000;	//			addj $t6, $a1, $t5, loop0
	memory[25] = 32'h8dcc0000;	//	moveright:	lw	$t4, 0($t6)
	memory[26] = 32'h8ded0000;	//			lw	$t5, 0($t7)
	memory[27] = 32'h01ac6022;	//			sub	$t4, $t5, $t4
	memory[28] = 32'h0180682a;	//			slt	$t5, $t4, $0
	memory[29] = 32'h11a00001;	//			beq	$t5, $0, rnotnegative
	memory[30] = 32'h000c6022;	//			sub	$t4, $0, $t4
	memory[31] = 32'h0196b020;	//	rnotnegative:	add	$s6, $t4, $s6
	memory[32] = 32'h8c8d000c;	//			lw	$t5, 12($a0)
	memory[33] = 32'h21adffff;	//			addi	$t5, $t5, -1
	memory[34] = 32'h11000000;	//			beq	$t0, $0, branch
	memory[35] = 32'h11200007;	//	branch:		beq	$t1, $0, rcheckL
	memory[36] = 32'h0276c02a;	//			slt	$t8, $s3, $s6
	memory[37] = 32'h13000005;	//			beq	$t8, $0, rcheckL
	memory[38] = 32'h01abc022;	//			sub	$t8, $t5, $t3
	memory[39] = 32'b0000000000011000110000001000000;	//			sll	$t8, $t8, 2
	memory[40] = 32'h01d87020;	//			add	$t6, $t6, $t8
	memory[41] = 32'h01f87820;	//			add	$t7, $t7, $t8
	memory[42] = 32'h01a05820;	//			add	$t3, $t5, $0
	memory[43] = 32'h116d0017;	//	rcheckL:	beq	$t3, $t5, rloop2Increase
	memory[44] = 32'h216b0001;	//			addi	$t3, $t3, 1
	memory[45] = 32'h21ce0004;	//			addi	$t6, $t6, 4
	memory[46] = 32'h21ef0004;	//			addi	$t7, $t7, 4
	memory[47] = 32'h08000019;	//			j	moveright
	memory[48] = 32'h15000003;	//	rloop1Increase:	bne	$t0, $0, rskip
	memory[49] = 32'h15200002;	//			bne	$t1, $0, rskip
	memory[50] = 32'b11101100000010011010000000010100;	//			add $s3, $s6, $0,add $s4, $t0, $0
	memory[51] = 32'h0120a820;	//			add	$s5, $t1, $0
	memory[52] = 32'h02d3682a;	//	rskip:		slt	$t5, $s6, $s3
	memory[53] = 32'h11a00002;	//			beq	$t5, $0, rskip2
	memory[54] = 32'b11101100000010011010000000010100;	//			add $s3, $s6, $0,add $s4, $t0, $0
	memory[55] = 32'h0120a820;	//			add	$s5, $t1, $0
	memory[56] = 32'b11000000000010110001100000001111;	//	rskip2:		add $s6, $0, $0,add $t7, $a2, $0
	memory[57] = 32'b11000000000001010000000000001011;	//			add $t2, $0, $0,add $t3, $0, $0
	memory[58] = 32'h00116820;	//			add	$t5, $0, $s1
	memory[59] = 32'h112dffce;	//			beq	$t1, $t5, rmovepointer
	//h112dffd0
	memory[60] = 32'h21290001;	//			addi	$t1, $t1, 1
	memory[61] = 32'h8c8d0000;	//			lw	$t5, 0($a0)
	memory[62] = 32'h71a86802;	//			mul	$t5, $t5, $t0
	memory[63] = 32'h01a96820;	//			add	$t5, $t5, $t1
	memory[64] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[65] = 32'h01a57020;	//			add	$t6, $t5, $a1
	memory[66] = 32'b00111100000000000110000000011001;	//	addj $t4, $0, $0, moveright
	memory[67] = 32'h8c8d0008;	//	rloop2Increase:	lw	$t5, 8($a0)
	memory[68] = 32'h21adffff;	//			addi	$t5, $t5, -1
	memory[69] = 32'h114dffea;	//			beq	$t2, $t5, rloop1Increase
	//h114dffec
	memory[70] = 32'h214a0001;	//			addi	$t2, $t2, 1
	memory[71] = 32'b11100010000001101000000000001011;	//			add $t5, $s1, $0,add $t3, $0, $0
	memory[72] = 32'h21ad0001;	//			addi	$t5, $t5, 1
	memory[73] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[74] = 32'h21ef0004;	//			addi	$t7, $t7, 4
	memory[75] = 32'b00111101110011010111000000011001;	//	addj $t6, $t6, $t5, moveright
	memory[76] = 32'h8dcc0000;	//	moveleft:	lw	$t4, 0($t6)
	memory[77] = 32'h8ded0000;	//			lw	$t5, 0($t7)
	memory[78] = 32'h01ac6022;	//			sub	$t4, $t5, $t4
	memory[79] = 32'h0180682a;	//			slt	$t5, $t4, $0
	memory[80] = 32'h11a00001;	//			beq	$t5, $0, lnotnegative
	memory[81] = 32'h000c6022;	//			sub	$t4, $0, $t4
	memory[82] = 32'h0196b020;	//	lnotnegative:	add	$s6, $t4, $s6
	memory[83] = 32'h8c8d000c;	//			lw	$t5, 12($a0)
	memory[84] = 32'h21adffff;	//			addi	$t5, $t5, -1
	memory[85] = 32'h0276c02a;	//			slt	$t8, $s3, $s6
	memory[86] = 32'h13000005;	//			beq	$t8, $0, lcheckL
	memory[87] = 32'h01abc022;	//			sub	$t8, $t5, $t3
	memory[88] = 32'b0000000000011000110000001000000;	//			sll	$t8, $t8, 2
	memory[89] = 32'h01d87020;	//			add	$t6, $t6, $t8
	memory[90] = 32'h01f87820;	//			add	$t7, $t7, $t8
	memory[91] = 32'h01a05820;	//			add	$t3, $t5, $0
	memory[92] = 32'h116d0012;	//	lcheckL:	beq	$t3, $t5, lloop2Increase
	memory[93] = 32'h21ce0004;	//			addi	$t6, $t6, 4
	memory[94] = 32'h21ef0004;	//			addi	$t7, $t7, 4
	memory[95] = 32'h216b0001;	//			addi	$t3, $t3, 1
	memory[96] = 32'h0800004c;	//			j	moveleft
	memory[97] = 32'h02d3682a;	//	lloop1Increase:	slt	$t5, $s6, $s3
	memory[98] = 32'h11a00002;	//			beq	$t5, $0, lskip
	memory[99] = 32'b11101100000010011010000000010100;	//			add $s3, $s6, $0,add $s4, $t0, $0
	memory[100] = 32'h0120a820;	//			add	$s5, $t1, $0
	memory[101] = 32'b11000000000010110001100000001111;	//	lskip:	add $s6, $0, $0,add $t7, $a2, $0
	memory[102] = 32'b11000000000001010000000000001011;	//			add $t2, $0, $0,add $t3, $0, $0
	memory[103] = 32'h1120ffaa;	//			beq	$t1, $0, lmovepointer
	//h1120ffac
	memory[104] = 32'h2129ffff;	//			addi	$t1, $t1, -1
	memory[105] = 32'h8c8d0000;	//			lw	$t5, 0($a0)
	memory[106] = 32'h71a86802;	//			mul	$t5, $t5, $t0
	memory[107] = 32'h01a96820;	//			add	$t5, $t5, $t1
	memory[108] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[109] = 32'h01a57020;	//			add	$t6, $t5, $a1
	memory[110] = 32'b00111100000000000110000001001100;	//			addj $t4, $0, $0, moveleft 
	memory[111] = 32'h8c8d0008;	//	lloop2Increase:	lw	$t5, 8($a0)
	memory[112] = 32'h21adffff;	//			addi	$t5, $t5, -1
	memory[113] = 32'h114dffef;	//			beq	$t2, $t5, lloop1Increase
	//h114dfff1
	memory[114] = 32'h214a0001;	//			addi	$t2, $t2, 1
	memory[115] = 32'b11100010000001101000000000001011;	//			add $t5, $s1, $0,add $t3, $0, $0
	memory[116] = 32'h21ad0001;	//			addi	$t5, $t5, 1
	memory[117] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[118] = 32'h21ef0004;	//			addi	$t7, $t7, 4
	memory[119] = 32'b00111101110011010111000001001100;	//			nop
	memory[120] = 32'b11000001010000010000001010100011;	//	finish:		add $v0, $0, $s4,add $v1, $0, $s5
	memory[121] = 32'h08000079;	//	label:		j	label

	


/*
	memory[0] = 32'b11000000000000100000000000010011;	//	vbsme:		nop //add $a0, $0, $0, add $s3, $0, $0 
	memory[1] = 32'h20050010;	//			addi	$a1, $0, 16
	memory[2] = 32'h20061010;	//			addi	$a2, $0, 4112
	memory[3] = 32'h2011001c;	//			addi	$s1, $0, 28
	memory[4] = 32'b11000000000001000000000000001001;	//			nop//add $t0, $0, $0,add $t1, $0, $0
	memory[5] = 32'b11000000000001010000000000001011;	//			nop//add $t2, $0, $0,add $t3, $0, $0
	memory[6] = 32'b11001010000001110001100000001111;	//add	$t6, $a1, $0,add	$t7, $a2, $0
	memory[7] = 32'b11000000000010000000000000010110;	//add	$s0, $0, $0,add	$s6, $0, $0
	memory[8] = 32'h12000010;	//	loop0:		beq	$s0, $0, moveright
	memory[9] = 32'h0800004c;	//			j	moveleft
	memory[10] = 32'h1111006d;	//	rmovepointer:	beq	$t0, $s1, finish
	memory[11] = 32'h21080001;	//			addi	$t0, $t0, 1
	memory[12] = 32'h8c8d0004;	//			lw	$t5, 4($a0)
	memory[13] = 32'h71a86802;	//			mul	$t5, $t5, $t0
	memory[14] = 32'h01a96820;	//			add	$t5, $t5, $t1
	memory[15] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[16] = 32'h22100001;	//			addi	$s0, $s0, 1
	memory[17] = 32'b00111100101011010111000000001000;	//			nop// addj $t6, $a1, $t5, loop0
	memory[18] = 32'h11110065;	//	lmovepointer:	beq	$t0, $s1, finish
	memory[19] = 32'h21080001;	//			addi	$t0, $t0, 1
	memory[20] = 32'h8c8d0004;	//			lw	$t5, 4($a0)
	memory[21] = 32'h71a86802;	//			mul	$t5, $t5, $t0
	memory[22] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[23] = 32'h2210ffff;	//			addi	$s0, $s0, -1
	memory[24] = 32'b00111100101011010111000000001000;	//			addj $t6, $a1, $t5, loop0
	memory[25] = 32'h8dcc0000;	//	moveright:	lw	$t4, 0($t6)
	memory[26] = 32'h8ded0000;	//			lw	$t5, 0($t7)
	memory[27] = 32'h01ac6022;	//			sub	$t4, $t5, $t4
	memory[28] = 32'h0180682a;	//			slt	$t5, $t4, $0
	memory[29] = 32'h11a00001;	//			beq	$t5, $0, rnotnegative
	memory[30] = 32'h000c6022;	//			sub	$t4, $0, $t4
	memory[31] = 32'h0196b020;	//	rnotnegative:	add	$s6, $t4, $s6
	memory[32] = 32'h8c8d000c;	//			lw	$t5, 12($a0)
	memory[33] = 32'h21adffff;	//			addi	$t5, $t5, -1
	memory[34] = 32'h11000000;	//			beq	$t0, $0, branch
	memory[35] = 32'h11200007;	//	branch:		beq	$t1, $0, rcheckL
	memory[36] = 32'h0276c02a;	//			slt	$t8, $s3, $s6
	memory[37] = 32'h13000005;	//			beq	$t8, $0, rcheckL
	memory[38] = 32'h01abc022;	//			sub	$t8, $t5, $t3
	memory[39] = 32'h0018c100;	//			sll	$t8, $t8, 4
	memory[40] = 32'h01d87020;	//			add	$t6, $t6, $t8
	memory[41] = 32'h01f87820;	//			add	$t7, $t7, $t8
	memory[42] = 32'h01a05820;	//			add	$t3, $t5, $0
	memory[43] = 32'h116d0017;	//	rcheckL:	beq	$t3, $t5, rloop2Increase
	memory[44] = 32'h216b0001;	//			addi	$t3, $t3, 1
	memory[45] = 32'h21ce0004;	//			addi	$t6, $t6, 4
	memory[46] = 32'h21ef0004;	//			addi	$t7, $t7, 4
	memory[47] = 32'h08000019;	//			j	moveright
	memory[48] = 32'h15000003;	//	rloop1Increase:	bne	$t0, $0, rskip
	memory[49] = 32'h15200002;	//			bne	$t1, $0, rskip
	memory[50] = 32'b11101100000010011010000000010100;	//			add $s3, $s6, $0,add $s4, $t0, $0
	memory[51] = 32'h0120a820;	//			add	$s5, $t1, $0
	memory[52] = 32'h02d3682a;	//	rskip:		slt	$t5, $s6, $s3
	memory[53] = 32'h11a00002;	//			beq	$t5, $0, rskip2
	memory[54] = 32'b11101100000010011010000000010100;	//			add $s3, $s6, $0,add $s4, $t0, $0
	memory[55] = 32'h0120a820;	//			add	$s5, $t1, $0
	memory[56] = 32'b11000000000010110001100000001111;	//	rskip2:		add $s6, $0, $0,add $t7, $a2, $0
	memory[57] = 32'b11000000000001010000000000001011;	//			add $t2, $0, $0,add $t3, $0, $0
	memory[58] = 32'h00116820;	//			add	$t5, $0, $s1
	memory[59] = 32'h112dffce;	//			beq	$t1, $t5, rmovepointer
	//h112dffd0
	memory[60] = 32'h21290001;	//			addi	$t1, $t1, 1
	memory[61] = 32'h8c8d0000;	//			lw	$t5, 0($a0)
	memory[62] = 32'h71a86802;	//			mul	$t5, $t5, $t0
	memory[63] = 32'h01a96820;	//			add	$t5, $t5, $t1
	memory[64] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[65] = 32'h01a57020;	//			add	$t6, $t5, $a1
	memory[66] = 32'b00111100000000000110000000011001;	//	addj $t4, $0, $0, moveright
	memory[67] = 32'h8c8d0008;	//	rloop2Increase:	lw	$t5, 8($a0)
	memory[68] = 32'h21adffff;	//			addi	$t5, $t5, -1
	memory[69] = 32'h114dffea;	//			beq	$t2, $t5, rloop1Increase
	//h114dffec
	memory[70] = 32'h214a0001;	//			addi	$t2, $t2, 1
	memory[71] = 32'b11100010000001101000000000001011;	//			add $t5, $s1, $0,add $t3, $0, $0
	memory[72] = 32'h21ad0001;	//			addi	$t5, $t5, 1
	memory[73] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[74] = 32'h21ef0004;	//			addi	$t7, $t7, 4
	memory[75] = 32'b00111101110011010111000000011001;	//	addj $t6, $t6, $t5, moveright
	memory[76] = 32'h8dcc0000;	//	moveleft:	lw	$t4, 0($t6)
	memory[77] = 32'h8ded0000;	//			lw	$t5, 0($t7)
	memory[78] = 32'h01ac6022;	//			sub	$t4, $t5, $t4
	memory[79] = 32'h0180682a;	//			slt	$t5, $t4, $0
	memory[80] = 32'h11a00001;	//			beq	$t5, $0, lnotnegative
	memory[81] = 32'h000c6022;	//			sub	$t4, $0, $t4
	memory[82] = 32'h0196b020;	//	lnotnegative:	add	$s6, $t4, $s6
	memory[83] = 32'h8c8d000c;	//			lw	$t5, 12($a0)
	memory[84] = 32'h21adffff;	//			addi	$t5, $t5, -1
	memory[85] = 32'h0276c02a;	//			slt	$t8, $s3, $s6
	memory[86] = 32'h13000005;	//			beq	$t8, $0, lcheckL
	memory[87] = 32'h01abc022;	//			sub	$t8, $t5, $t3
	memory[88] = 32'h0018c100;	//			sll	$t8, $t8, 4
	memory[89] = 32'h01d87020;	//			add	$t6, $t6, $t8
	memory[90] = 32'h01f87820;	//			add	$t7, $t7, $t8
	memory[91] = 32'h01a05820;	//			add	$t3, $t5, $0
	memory[92] = 32'h116d0012;	//	lcheckL:	beq	$t3, $t5, lloop2Increase
	memory[93] = 32'h21ce0004;	//			addi	$t6, $t6, 4
	memory[94] = 32'h21ef0004;	//			addi	$t7, $t7, 4
	memory[95] = 32'h216b0001;	//			addi	$t3, $t3, 1
	memory[96] = 32'h0800004c;	//			j	moveleft
	memory[97] = 32'h02d3682a;	//	lloop1Increase:	slt	$t5, $s6, $s3
	memory[98] = 32'h11a00002;	//			beq	$t5, $0, lskip
	memory[99] = 32'b11101100000010011010000000010100;	//			add $s3, $s6, $0,add $s4, $t0, $0
	memory[100] = 32'h0120a820;	//			add	$s5, $t1, $0
	memory[101] = 32'b11000000000010110001100000001111;	//	lskip:	add $s6, $0, $0,add $t7, $a2, $0
	memory[102] = 32'b11000000000001010000000000001011;	//			add $t2, $0, $0,add $t3, $0, $0
	memory[103] = 32'h1120ffaa;	//			beq	$t1, $0, lmovepointer
	//h1120ffac
	memory[104] = 32'h2129ffff;	//			addi	$t1, $t1, -1
	memory[105] = 32'h8c8d0000;	//			lw	$t5, 0($a0)
	memory[106] = 32'h71a86802;	//			mul	$t5, $t5, $t0
	memory[107] = 32'h01a96820;	//			add	$t5, $t5, $t1
	memory[108] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[109] = 32'h01a57020;	//			add	$t6, $t5, $a1
	memory[110] = 32'b00111100000000000110000000011001;	//			addj $t4, $0, $0, moveright
	memory[111] = 32'h8c8d0008;	//	lloop2Increase:	lw	$t5, 8($a0)
	memory[112] = 32'h21adffff;	//			addi	$t5, $t5, -1
	memory[113] = 32'h114dffef;	//			beq	$t2, $t5, lloop1Increase
	//h114dfff1
	memory[114] = 32'h214a0001;	//			addi	$t2, $t2, 1
	memory[115] = 32'b11100010000001101000000000001011;	//			add $t5, $s1, $0,add $t3, $0, $0
	memory[116] = 32'h21ad0001;	//			addi	$t5, $t5, 1
	memory[117] = 32'h000d6880;	//			sll	$t5, $t5, 2
	memory[118] = 32'h21ef0004;	//			addi	$t7, $t7, 4
	memory[119] = 32'b00111101110011010111000001001100;	//			nop
	memory[120] = 32'b11000001010000010000001010100011;	//	finish:		add $v0, $0, $s4,add $v1, $0, $s5
	memory[121] = 32'h08000079;	//	label:		j	label
	*/
	
	
	/*
		memory[0] = 32'b00100000000010000000000000000010;	//			addi	$t0, $0, 2	t0 = 2
		memory[1] = 32'b00100000000010010000000000000011;	//			addi	$t1, $0, 3	t1 = 3
		memory[2] = 32'b00100000000010100000000000000100;	//			addi	$t2, $0, 4	t2 = 4
		memory[3] = 32'b00100000000010110000000000000101;	//			addi	$t3, $0, 5	t3 = 5
		memory[4] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7	s0 = 7
		memory[5] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7	s0 = 7
		memory[6] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7	s0 = 7
		memory[7] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7	s0 = 7
		memory[8] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7	s0 = 7
		memory[9] = 32'b00100000000101000000000000000111;	//			addi $s4, $zero, 7, s4 = 7
		memory[10] = 32'b11010001010010001010100101110010;	//	s1 = t0+s4, s2 = t2+t3, s1 = 9 , s2 = 9 
		memory[11] = 32'b00000010001010001001100000100000;	//	add $s3, $s1, $t0, s3 = 5+2 = 7
		memory[12] = 32'b00000010001010011001100000100000;	//	add $s3, $s1, $t1, s3 = 
	//	memory[10] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7
	//	memory[11] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7
		memory[13] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7
		memory[14] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7
		memory[15] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7
		memory[16] = 32'b00111010001010001001001001010001;			// t0 = s1+4, t2 = s2 + 1, t0 = 13, t2 = 10
		memory[17] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7
		memory[18] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7
		memory[19] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7
		memory[20] = 32'b00100000000100000000000000000111;	//			addi 	$s0, $0, 7

*/
	 end
	 always@(Address) begin
	 
		RegInstruction <= memory[Address[9:2]];
	 
	 end
	 
		


endmodule
