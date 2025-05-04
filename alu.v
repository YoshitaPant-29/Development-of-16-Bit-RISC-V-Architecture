module alu(
    input logic [15:0] a, b,
    input logic [2:0] alu_ctrl,
    output logic [15:0] result,
    output logic zero
);
    always_comb begin
        case (alu_ctrl)
            3'b000: result = a + b;       // ADD
            3'b001: result = a - b;       // SUB
            3'b010: result = a & b;       // AND
            3'b011: result = a | b;       // OR
            3'b100: result = a ^ b;       // XOR
            3'b101: result = (a < b) ? 1 : 0; // SLT
            default: result = 16'b0;
        endcase
    end

    assign zero = (result == 16'b0);
endmodule

