// instr_mem.v
module instr_mem (
    input logic [31:0] addr,
    output logic [31:0] instruction
);
    logic [31:0] memory [0:255]; // 1 KB instruction memory

    initial begin
        $readmemh("program.hex", memory); // Hex file with RISC-V instructions
    end

    assign instruction = memory[addr[9:2]]; // Word-aligned
endmodule

-->
Takes PC as input (addr) and outputs the corresponding instruction.

Expects a hex file (program.hex) as instruction ROM.

Address bits [9:2] ensure word alignment (since each instruction is 4 bytes).


