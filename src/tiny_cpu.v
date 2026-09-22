module tiny_cpu(
    input logic clk,
    input logic reset
);

    logic [31:0] pc;
    logic [31:0] next_pc;
    logic [31:0] instruction;
        
    logic [3:0] opcode;
    logic [3:0] rd;
    logic [3:0] rs1;
    logic [3:0] rs2;

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

    decoder decoder_module (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2)
    );

    assign next_pc = pc + 4;

endmodule