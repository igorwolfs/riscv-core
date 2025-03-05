`timescale 1ns/10ps
`include "define.vh"

module core_calu (
	input [6:0] 		OPCODE,
	input [2:0] 		FUNCT3,
	input [6:0] 		FUNCT7,
	input [31:0] 		IMM,
	// REGISTER READ / WRITES
	output [31:0]		ALU_IMM, // If the alu is an immediate instruction, it sets the second ALU immediate
	output [3:0]		OPCODE_ALU
);

	// Create the immediate based on ALU logic
	assign ALU_IMM 	  = (FUNCT3 != `FUNCT3_SR) ? IMM : ({27'b0, IMM[4:0]});

	assign OPCODE_ALU = ((FUNCT3 == `FUNCT3_ADD) & (!FUNCT7)) ? ALU_CODE_SUM :
						((FUNCT3 == `FUNCT3_ADD) & (FUNCT7)) ? ALU_CODE_SUB :
						(FUNCT3 == `FUNCT3_XOR) ? ALU_CODE_XOR :
						(FUNCT3 == `FUNCT3_OR) ? ALU_CODE_OR :
						(FUNCT3 == `FUNCT3_AND) ? ALU_CODE_AND :
						 (FUNCT3 == `FUNCT3_SLL) ? ALU_CODE_SLL :
						 ((FUNCT3 == `FUNCT3_SR) & (!FUNCT7)) ? ALU_CODE_SRL :
						 ((FUNCT3 == `FUNCT3_SR) & (FUNCT7)) ? ALU_CODE_SRA :
						 (FUNCT3 == `FUNCT3_SLT) ? ALU_CODE_SLT :
						 (FUNCT3 == `FUNCT3_SLTU) ? ALU_CODE_SLTU :
						`ALU_CODE_INVALID;
endmodule

/**
NOTE:
- We can in fact just have
	- is_immediate output from the alu 
		- It calculates the appropriate ALU immediate (27b 5b)
	- And the rest should 
*/