module program_counter (
    input logic     clk,
    input logic [31:0] next_pc,
    output logic [31:0] pc
);

    always_ff @(posedge clk) begin
        pc <= next_pc;
    end

endmodule