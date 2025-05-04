# This module breaks down the 32-bit instruction into opcode, control signals, source/destination registers, 
and immediate.

DESIGN:
module decoder (
 input [31:0] instr,
 output reg [6:0] opcode,
 output reg [2:0] funct3,
 output reg [6:0] funct7,
 output reg [4:0] rs1,
 output reg [4:0] rs2,
 output reg [4:0] rd,
 output reg [31:0] imm_out
);
 always @(*) begin
 opcode = instr[6:0];
 rd = instr[11:7];
 funct3 = instr[14:12];
 rs1 = instr[19:15];
 rs2 = instr[24:20];
 funct7 = instr[31:25];
 // Immediate decoder (for I-type)
 case (opcode)
 7'b0010011, // I-type ALU
 7'b0000011: // Load
 imm_out = {{20{instr[31]}}, instr[31:20]}; // sign-extend I-type
 7'b0100011: // Store
 imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
 7'b1100011: // Branch
 imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
 7'b1101111: // JAL
 imm_out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
 default:
 imm_out = 32'd0;
 endcase
 end
endmodule
