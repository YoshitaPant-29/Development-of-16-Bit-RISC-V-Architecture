module control_unit (
    input logic [6:0] opcode,
    output logic reg_write,
    output logic [2:0] alu_op
);
    always_comb begin
        case (opcode)
            7'b0110011: begin // R-type
                reg_write = 1;
                alu_op = 3'b000; // ADD as default
            end
            default: begin
                reg_write = 0;
                alu_op = 3'b000;
            end
        endcase
    end
endmodule
