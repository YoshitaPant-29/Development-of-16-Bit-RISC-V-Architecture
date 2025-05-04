# The Control Unit generates all control signals based on the instruction opcode and funct3/funct7 fields.

module control_unit (
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg alu_src,
    output reg mem_to_reg,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg jump,
    output reg [2:0] alu_op
);

always @(*) begin
    // Default values
    alu_src = 0;
    mem_to_reg = 0;
    reg_write = 0;
    mem_read = 0;
    mem_write = 0;
    branch = 0;
    jump = 0;
    alu_op = 3'b000;

    case (opcode)
        7'b0110011: begin // R-type
            reg_write = 1;
            alu_src = 0;
            alu_op = funct3; // e.g., ADD, SUB, SLT based on funct3
        end
        7'b0010011: begin // I-type (e.g., ADDI)
            reg_write = 1;
            alu_src = 1;
            alu_op = funct3;
        end
        7'b0000011: begin // Load
            reg_write = 1;
            alu_src = 1;
            mem_to_reg = 1;
            mem_read = 1;
            alu_op = 3'b000; // ADD for address calc
        end
        7'b0100011: begin // Store
            alu_src = 1;
            mem_write = 1;
            alu_op = 3'b000;
        end
        7'b1100011: begin // Branch
            branch = 1;
            alu_src = 0;
            alu_op = 3'b001; // SUB to compare for BEQ/BNE
        end
        7'b1101111: begin // JAL
            jump = 1;
            reg_write = 1;
        end
        default: begin
            // NOP or unsupported instruction
        end
    endcase
end

endmodule


-->Key Output Signals:
alu_src: Whether to use immediate (1) or register (0) as ALU operand.

alu_op: ALU operation code (you can refine logic using funct7 too).

reg_write: Enables writing result back to register.

mem_to_reg: Selects memory data for writing to register.

mem_read / mem_write: Enable memory access.

branch / jump: Activate PC redirection logic.
