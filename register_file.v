module register_file (
    input logic clk,
    input logic we,
    input logic [4:0] rd_addr1, rd_addr2, wr_addr,
    input logic [15:0] wr_data,
    output logic [15:0] rd_data1, rd_data2
);
    logic [15:0] regfile[31:0];

    always_ff @(posedge clk) begin
        if (we && wr_addr != 0)
            regfile[wr_addr] <= wr_data;
    end

    assign rd_data1 = regfile[rd_addr1];
    assign rd_data2 = regfile[rd_addr2];
endmodule
