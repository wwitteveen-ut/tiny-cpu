module tiny_cpu(
    input logic clk,
    input logic reset
);

    logic [31:0] pc;
    logic [31:0] next_pc;
    logic [31:0] instruction;

    program_counter pc_module (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .next_pc(next_pc)
    );

    instruction_memory instruction_memory_module  (
        .pc(pc),
        .instruction(instruction)
    );

    assign next_pc = pc + 4;

endmodule