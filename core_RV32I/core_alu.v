`timescale 1ns/10ps
`include "define.vh"

/**
An ALU "normally" doesn't require any 
- Registers
- reset signals
Since it is supposed to be purely combinatorial.
*/

module core_alu (
    input               CLK,
    input               C_ALU,
    input [3:0]         OPCODE_ALU,
    input [31:0]        ALU_I1,
    input [31:0]        ALU_I2,
    output reg [31:0]   ALU_O
);


// ARITHMETIC RIGHT SHIFT
wire [63:0] SRA_tmp;
wire [63:0] SRA_tmp_shifted_64;
wire [31:0] SRA_tmp_shifted_32;
assign SRA_tmp = {{32{ALU_I1[31]}}, ALU_I1};
assign SRA_tmp_shifted_64 = {SRA_tmp >> ALU_I2};
assign SRA_tmp_shifted_32 = SRA_tmp_shifted_64[31:0];
// Take the relevant instruction, perform a switch-case
wire [31:0] alu_o;
assign alu_o = (OPCODE_ALU == `ALU_CODE_ADD) ? (ALU_I1 + ALU_I2) :
                (OPCODE_ALU == `ALU_CODE_SUB) ? (ALU_I1 - ALU_I2) :
                (OPCODE_ALU == `ALU_CODE_XOR) ? (ALU_I1 ^ ALU_I2) :
                (OPCODE_ALU == `ALU_CODE_OR) ? (ALU_I1 | ALU_I2) :
                (OPCODE_ALU == `ALU_CODE_AND) ? (ALU_I1 & ALU_I2) :
                (OPCODE_ALU == `ALU_CODE_SLL) ? (ALU_I1 << ALU_I2) :
                (OPCODE_ALU == `ALU_CODE_SRL) ? (ALU_I1 >> ALU_I2) :
                (OPCODE_ALU == `ALU_CODE_SRA) ? (SRA_tmp_shifted_32):
                (OPCODE_ALU == `ALU_CODE_SLT) ? {{31{1'b0}}, {($signed(ALU_I1) < $signed(ALU_I2))}} :
                (OPCODE_ALU == `ALU_CODE_SLTU) ? {{31{1'b0}}, {($unsigned(ALU_I1) < $unsigned(ALU_I2))}} :
                32'hff_ff_ff_ff;

always @(posedge CLK)
begin
    if (C_ALU)
        ALU_O <= alu_o;
end
endmodule
