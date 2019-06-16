`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:03:31 10/07/2013 
// Design Name: 
// Module Name:    Top_Datapath 
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
module Top_Datapath(Clk,Reset,Output1,Output2);

	 input Clk, Reset;
	 
	 output [31:0] Output1;
	 output [31:0] Output2;

		wire [31:0] Next_Instr;
	//	wire PCWrite;
		wire [31:0] PCResult;
		wire [31:0] PC_Next;
		wire [31:0] Instruction;

		wire [31:0] IFID_PC_Next;
		wire [31:0] IFID_Instruction;
	//	wire IFFlush;
		wire Double;

		wire PC_J_Branch;
		wire Jump, Branch, RegWrite, MemWrite, MemRead, MemtoReg, Zero, AndGateOutput, ALUSrc;  //Control Signals
		wire JaL;
		wire [31:0] mux_j_out;
		wire [4:0] mux_jr_out;
		wire [2:0] ALUOp; 
		wire [31:0] ReadData1;
		wire [31:0] ReadData2;
		wire [31:0] SEInstr;
		wire [31:0] Shamt;
	//	wire IFIDWrite;
		wire [31:0] JumpAddress;
	//	wire NoOp;
		wire JR;
		wire [1:0] RegDst;
		wire Take_Branch;
	//	wire Flush_Ctrl;
//		wire IDFlush;
		wire [31:0] AddResult;
		wire [31:0] Mux_4_Output;
		wire [31:0] JAddr;
		wire [31:0] J_B;
		wire [31:0] SEInstrSLL2;
		wire [31:0] fullInstruction;


		wire IFID_JaL, IFID_Jump, IFID_Branch, IFID_MemRead, IFID_MemtoReg, IFID_MemWrite, IFID_ALUSrc, IFID_RegWrite;
	//	wire [2:0] IFID_ALUOp;
		wire [1:0] IFID_RegDst;
		
		wire [31:0] RD1;
		wire [31:0] RD2;
		wire [31:0] IDEX_Instr;
		wire IDEX_MemRead;
		wire IDEX_MemtoReg;
		wire [2:0] IDEX_ALUOp;
		wire IDEX_MemWrite;
		wire IDEX_ALUSrc;
		wire IDEX_RegWrite;
		wire [1:0] IDEX_RegDst;
		wire [31:0] IDEX_ReadData1;
		wire [31:0] IDEX_ReadData2;
		wire [31:0] IDEX_Shamt;
		wire [31:0] IDEX_SEInstr;
		wire nop;

		wire [1:0]ForwardRegRS;
		wire [1:0]ForwardRegRT;
		wire [1:0] ForwardRS;
		wire [1:0] ForwardRT;
		wire [4:0] WriteReg;
		wire [2:0] ALUCtrl;
		wire [31:0] Shamt_ForwardRS;
		wire [31:0] SEInstr_ForwardRT;
		wire Shift;
		wire [31:0] ALU_A;
		wire [31:0] ALU_B;
		wire [31:0] ALUResult;
		
		wire EXMEM_MemRead;
		wire EXMEM_MemtoReg;
		wire EXMEM_MemWrite;
		wire EXMEM_RegWrite;
		wire [31:0] EXMEM_ALUResult;
		wire [31:0] EXMEM_RD2;
		wire [4:0] EXMEM_WriteReg;
		wire [31:0] DMReadData;
		wire [31:0] EX_MEMRD2;
		wire [4:0] IDEX_WriteReg;
		
		wire MEMWB_RegWrite;
		wire MEMWB_MemtoReg;
		wire [31:0] MEMWB_DMRD;
		wire [31:0] MEMWB_ALUResult;
		wire [4:0] MEMWB_WriteReg;
		wire [31:0] WriteData;
		
		wire [4:0] WriteReg2;
		wire [31:0] PCJB_Instr;

		wire [4:0] Reg1;
		wire [4:0] Reg2;
		wire [31:0] EXMEM_Instr;
		wire [31:0] MEMWB_Instr;
		wire [31:0] MEMWB_ALU2;
		wire IDEX_Double;
		wire EXMEM_Double;
		wire MEMWB_Double;
		wire [31:0] ALUResult2;
		wire [31:0] ReadData2B;
		wire [31:0] ReadData1B;
		wire [31:0] IDEXRD1B;
		wire [31:0] IDEXRD2B;
		wire [31:0] EXMEM_ALU2;
		//wire [31:0] MEMWB_ALU2;
		wire D_addi;
		wire [2:0] Imm;
		wire [31:0] SEInstr2;
		wire IDEX_addi;
		wire [31:0] IDEX_SEInstr2;
		wire [31:0] ALU_B_2;
		wire MEMWB_addi;
		wire [4:0] WriteReg3;
		wire EXMEM_addi;
		wire [4:0] Reg1_2;
		wire [4:0] Reg2_2;
		
		wire [31:0] AddOut;
		wire [31:0] AddCla;
		
/////////////////////////////////////////////////////////////

	ProgramCounter PC(
		.Address(PC_Next),    
		.PCResult(PCResult),
	//	.PCWrite(PCWrite),
		.Reset(Reset), 
		.Clk(Clk)
	);
		
	Mux_PC Mux_PC(
		.out(PCJB_Instr), 
		.inA(PCResult), 
		.inB(J_B),
		.sel(PC_J_Branch)
		);
		
		
	PCAdder Add(
		.PCResult(PCJB_Instr), 
		.PCAddResult(PC_Next)
		);
		

	InstructionMemory IM(
		.Address(PCJB_Instr), 
		.Instruction(Instruction)
	);
	

////////////// Buffer IF/ID ///////////////////////////////////	
	
	Buffer_IFID IFID(
	.Clk(Clk),
   .Instruction(Instruction),
	.PC_Next(PC_Next),
//	.IFIDWrite(IFIDWrite),
	.IFID_Instruction(IFID_Instruction),
	.IFID_PC_Next(IFID_PC_Next)	
	);
	
///////////////////////////////////////////////////////////	

/*
	Hazard_Detection_Unit Hazard(
		.IFID_RS(IFID_Instruction[25:21]),
		.IFID_RT(IFID_Instruction[20:16]),
		.IDEX_RT(IDEX_Instr[20:16]),
		.IDEX_MemRead(IDEX_MemRead),
		.PCWrite(PCWrite),
		.IFIDWrite(IFIDWrite),
		.NoOp(NoOp),
		.IFID_Branch(IFID_Branch),
		.WriteReg(WriteReg)
		);
*/


	ShiftLeft2Cat SLL2CC(
		.inSh(IFID_Instruction[10:0]),
		.out(JumpAddress)
	);
	

	Control Ctrl(
		.Instruction(IFID_Instruction[31:26]),
		.RegDst(RegDst),
		.Jump(Jump),
		.Branch(Branch),
		.MemRead(MemRead),
		.MemtoReg(MemtoReg),
		.ALUOp(ALUOp),
	//	.MemWrite(MemWrite),
		.RegWrite(RegWrite),
		.ALUSrc(ALUSrc),
		.Double(Double),
		.D_addi(D_addi)
    );
	 
	

	Mux5Bit2To1B Mux_Register1(
	.out(Reg1), 
	.inA(IFID_Instruction[25:21]), 
	.inB(IFID_Instruction[29:25]),
	.sel(Double)
	);
		
	Mux5Bit2To1B Mux_Register2(
	.out(Reg2), 
	.inA(IFID_Instruction[20:16]), 
	.inB(IFID_Instruction[24:20]),
	.sel(Double)
	);	
	

	
	Mux5Bit2To1B Mux_Register1_2(
	.out(Reg1_2), 
	.inA(IFID_Instruction[14:10]), 
	.inB(IFID_Instruction[12:8]),
	.sel(D_addi)
	);
		
	Mux5Bit2To1B Mux_Register2_2(
	.out(Reg2_2), 
	.inA(IFID_Instruction[9:5]), 
	.inB(IFID_Instruction[7:3]),
	.sel(D_addi)
	);	
		

	Mux5Bit2To1B Mux_0_2(
		.out(WriteReg3), 
		.inA(MEMWB_Instr[4:0]), 
		.inB(MEMWB_Instr[7:3]),
		.sel(MEMWB_addi)
		);	
			

	RegisterFile RF(
		.ReadRegister1(Reg1),
		.ReadRegister2(Reg2),
		.WriteRegister(MEMWB_WriteReg),
		.WriteData(WriteData),  
		.RegWrite(MEMWB_RegWrite), 
		.Clk(Clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2),
		.Output1(Output1),
		.Output2(Output2),
		.ReadRegister1B(Reg1_2),
		.ReadRegister2B(Reg2_2),
		.WriteRegister2(WriteReg3),
		.WriteData2(MEMWB_ALU2),
		.Double(Double),
		.MEMWB_Double(MEMWB_Double),
		.ReadData1B(ReadData1B),
		.ReadData2B(ReadData2B),
		.addi(D_addi),
		.MEMWB_addi(MEMWB_addi)
		);
		
		/*
	MuxForwardReg MuxRegRS(
		.out(RD1), 
		.inA(ReadData1), 
		.inB(WriteData), 
		.sel(ForwardRegRS)
		);
	
	
	MuxForwardReg MuxRegRT(
		.out(RD2), 
		.inA(ReadData2), 
		.inB(WriteData), 
		.sel(ForwardRegRT)
		);
		*/
		
		
		//EXMEM_ALUResult
	MuxForward MuxRegRS(
		.inA(ReadData1),
		.inB(WriteData),
		.inC(AddOut),
		.inD(DMReadData),
		.sel(ForwardRegRS),
		.Out(RD1)
		);
		
	MuxForward MuxRegRT(
		.inA(ReadData2),
		.inB(WriteData),
		.inC(AddOut),
		.inD(DMReadData),
		.sel(ForwardRegRT),
		.Out(RD2)
		);	
		
		
		Mux5Bit2To1 Mux_0(
		.out(WriteReg), 
		.inA(IFID_Instruction[20:16]), 
		.inB(IFID_Instruction[15:11]),
		.sel(RegDst)
		);	
		
		Mux5Bit2To1B Mux_WriteReg(
		.out(WriteReg2), 
		.inA(WriteReg), 
		.inB(IFID_Instruction[19:15]),
		.sel(Double)
		);	
		
/*		
	Mux_Imm Mux_Imm1(
		.A(IFID_Instruction[15:0]),
		.B(IFID_Instruction[15:13]),
		.Out(Imm),
		.Sel(D_addi)
		);
	*/	

	SignExtension2 SE_16_32(
		.in(IFID_Instruction[15:0]), 
		.out(SEInstr),
		.inB(IFID_Instruction[15:13]),
		.Sel(D_addi)
		);

	SignExtension3 SE_16_32_2(
		.in(IFID_Instruction[2:0]), 
		.out(SEInstr2)
		);	
		
		
	SignExtender5to32 SE5_32(
		.in(IFID_Instruction[10:6]),
		.out(Shamt)
	);	

	ShiftLeft2 SLL2(
		.in(SEInstr), 
		.out(SEInstrSLL2)
		);
		

		
	Compare Compare(
		.A(RD1),
		.B(RD2),
		.ALUOp(ALUOp),
		.Take_Branch(Take_Branch)
		);
		
	
	AndGate And(
		.in1(Branch),
		.in2(Take_Branch),
		.out(BranchTaken)
		);	
		
	OrGate Or_J(
		.inA(Jump),
		.inB(BranchTaken),
		.Out(PC_J_Branch)
		);	
		

	Adder Add_Branch(
		.a_in(IFID_PC_Next), 
		.b_in(SEInstrSLL2), 
		.sum_out(AddResult)
		);



	Mux32Bit2To1 Mux_4(
		.out(Mux_4_Output), 
		.inA(PC_Next), 
		.inB(AddResult), 
		.sel(BranchTaken)
	);
	

	
	Mux32Bit2To1 Mux_5(
		.out(J_B), 
		.inA(Mux_4_Output), 
		.inB(JumpAddress), 
		.sel(Jump)
	);	

		
		
////////////// BUFFER ID/EX /////////////////////////////////		
		
	Buffer_IDEX IDEX(
		.Clk(Clk),
		.IFID_Instruction(IFID_Instruction),
		.IFID_MemRead(MemRead),
		.IFID_MemtoReg(MemtoReg),
		.IFID_ALUOp(ALUOp),
	//	.IFID_MemWrite(MemWrite),
		.IFID_ALUSrc(ALUSrc),
		.IFID_RegWrite(RegWrite),
//		.IFID_RegDst(IFID_RegDst),
		.ReadData1(RD1),
		.ReadData2(RD2),
		.Shamt(Shamt),
		.SEInstr(SEInstr),
		.IDEX_Instruction(IDEX_Instr),
		.IDEX_MemRead(IDEX_MemRead),
		.IDEX_MemtoReg(IDEX_MemtoReg),
		.IDEX_ALUOp(IDEX_ALUOp),
	//	.IDEX_MemWrite(IDEX_MemWrite),
		.IDEX_ALUSrc(IDEX_ALUSrc),
		.IDEX_RegWrite(IDEX_RegWrite),
//		.IDEX_RegDst(IDEX_RegDst),
		.IDEX_ReadData1(IDEX_ReadData1),
		.IDEX_ReadData2(IDEX_ReadData2),
		.IDEX_Shamt(IDEX_Shamt),
		.IDEX_SEInstr(IDEX_SEInstr),
		.WriteReg(WriteReg2),
		.IDEX_WriteReg(IDEX_WriteReg),
		.Double(Double),
		.IDEX_Double(IDEX_Double),
		.ReadData1B(ReadData1B),
		.ReadData2B(ReadData2B),
		.IDEX_RD1B(IDEXRD1B),
		.IDEX_RD2B(IDEXRD2B),
		.D_addi(D_addi),
		.IDEX_addi(IDEX_addi),
		.SEInstr2(SEInstr2),
		.IDEX_SEInstr2(IDEX_SEInstr2)
    );
	
	
////////////////////////////////////////////////////////////
	

	
	ALUControl ALUC(
		.ALUOp(IDEX_ALUOp),
		.ALUCtrl(ALUCtrl),
		.FunctionField(IDEX_Instr[5:0]),
		.shift(Shift),
		.Double(IDEX_Double)
    );
	 
	 MuxForward Mux_RS(
		.inA(IDEX_ReadData1),
		.inB(WriteData),
		.inC(EXMEM_ALUResult),
		.inD(DMReadData),
		.sel(ForwardRS),
		.Out(Shamt_ForwardRS)
		);
		
	MuxForward Mux_RT(
		.inA(IDEX_ReadData2),
		.inB(EXMEM_ALUResult),
		.inC(WriteData),
		.inD(DMReadData),
		.sel(ForwardRT),
		.Out(SEInstr_ForwardRT)
		);
	 
	 
	Mux32Bit2To1 Mux_1(
		.out(ALU_A), 
		.inA(Shamt_ForwardRS), 
		.inB(IDEX_Shamt), 
		.sel(Shift)
	);
	 
	Mux32Bit2To1 Mux_2(
		.out(ALU_B), 
		.inA(SEInstr_ForwardRT), 
		.inB(IDEX_SEInstr),
		.sel(IDEX_ALUSrc)
		);


	ALU32Bit ALU(
		.ALUCtrl(ALUCtrl), 
		.A(ALU_A), 
		.B(ALU_B), 
		.ALUResult(ALUResult)
		);
		
	Adder2 AddCLA(
		.A(ALU_A), 
		.B(ALU_B), 
		.ALUResult(AddCla)
		);	
		
	MuxCLA Mux_CLA(
		.out(AddOut), 
		.inA(ALUResult), 
		.inB(AddCla),
		.sel(ALUCtrl),
		.double(IDEX_Double)
		);
		
	Mux32Bit2To1 Mux_2_2(
		.out(ALU_B_2), 
		.inA(IDEXRD2B), 
		.inB(IDEX_SEInstr2),
		.sel(IDEX_addi)
		);	
		
	Adder2 ALU2(
		.A(IDEXRD1B), 
		.B(ALU_B_2), 
		.ALUResult(ALUResult2)
		);	
		
		
	Forwarding_Unit Forward(
		.IDEX_RS(IDEX_Instr[25:21]),
		.IDEX_RT(IDEX_Instr[20:16]),
		.EXMEM_RD(EXMEM_WriteReg),
		.MEMWB_RD(MEMWB_WriteReg),
		.MEMWB_RegWrite(MEMWB_RegWrite),
		.EXMEM_RegWrite(EXMEM_RegWrite),
		.ForwardRS(ForwardRS),
		.ForwardRT(ForwardRT),
		.IFID_RS(Reg1),
		.IFID_RT(Reg2),
		.ForwardRegRS(ForwardRegRS),
		.ForwardRegRT(ForwardRegRT),
		.WriteReg(IDEX_WriteReg),
		.IDEX_RegWrite(IDEX_RegWrite),
		.EXMEM_MemRead(EXMEM_MemRead),
		.IFID_Branch(Branch)
		);
		
		
////////////////// Buffer EX/MEM /////////////////////////		
		
		
		Buffer_EXMEM EXMEM(
			.Clk(Clk),
			.IDEX_MemRead(IDEX_MemRead),
			.IDEX_MemtoReg(IDEX_MemtoReg),
		//	.IDEX_MemWrite(IDEX_MemWrite),
			.IDEX_RegWrite(IDEX_RegWrite),
			.ALUResult(AddOut),
		//	.ALU_B(SEInstr_ForwardRT),
			.WriteReg(IDEX_WriteReg),
			.EXMEM_MemRead(EXMEM_MemRead),
			.EXMEM_MemtoReg(EXMEM_MemtoReg),
		//	.EXMEM_MemWrite(EXMEM_MemWrite),
			.EXMEM_RegWrite(EXMEM_RegWrite),
			.EXMEM_ALUResult(EXMEM_ALUResult),
	//		.EXMEM_RD2(EXMEM_RD2),
			.EXMEM_WriteReg(EXMEM_WriteReg),
			.EXMEM_Instr(EXMEM_Instr),
			.IDEX_Instr(IDEX_Instr),
			.IDEX_Double(IDEX_Double),
			.EXMEM_Double(EXMEM_Double),
			.ALUResult2(ALUResult2),
			.EXMEM_ALU2(EXMEM_ALU2),
			.IDEX_addi(IDEX_addi),
			.EXMEM_addi(EXMEM_addi)
			);
			
		
///////////////////////////////////////////////
		
		

	DataMemory DM(
		.Address(EXMEM_ALUResult), 
//		.WriteData(EXMEM_RD2), 
//		.Clk(Clk), 
//		.MemWrite(EXMEM_MemWrite), 
		.MemRead(EXMEM_MemRead), 
		.ReadData(DMReadData)
		);


///// Buffer MEM/WB //////////////////////


	Buffer_MEMWB MEMWB(
		.Clk(Clk),
		.EXMEM_MemtoReg(EXMEM_MemtoReg),
		.EXMEM_RegWrite(EXMEM_RegWrite),
		.DMReadData(DMReadData),
		.EXMEM_ALUResult(EXMEM_ALUResult),
		.EXMEM_WriteReg(EXMEM_WriteReg),
		.MEMWB_MemtoReg(MEMWB_MemtoReg),
		.MEMWB_RegWrite(MEMWB_RegWrite),
		.MEMWB_DMReadData(MEMWB_DMRD),
		.MEMWB_ALUResult(MEMWB_ALUResult),
		.MEMWB_WriteReg(MEMWB_WriteReg),
		.EXMEM_Instr(EXMEM_Instr),
		.MEMWB_Instr(MEMWB_Instr),
		.EXMEM_Double(EXMEM_Double),
		.MEMWB_Double(MEMWB_Double),
		.EXMEM_ALU2(EXMEM_ALU2),
		.MEMWB_ALU2(MEMWB_ALU2),
		.EXMEM_addi(EXMEM_addi),
		.MEMWB_addi(MEMWB_addi)
		);


//////////////////////////////////////

		
	Mux32Bit2To1 Mux_3(
		.out(WriteData), 
		.inA(MEMWB_ALUResult), 
		.inB(MEMWB_DMRD), 
		.sel(MEMWB_MemtoReg)
	);
	

	
	 
endmodule



