`timescale 1ns/1ps

module tiny_cpu(
    input logic clk,
    input logic reset
);

    logic [31:0] pc;
    logic [31:0] next_pc;
    logic [31:0] instruction;
        
    logic [3:0] opcode;
    logic [2:0] rd;
    logic [2:0] rs1;
    logic [2:0] rs2;

    logic [31:0] read_data_a;
    logic [31:0] read_data_b;

    logic       write_enable;
    logic [31:0] write_data;

    logic [1:0] alu_op;
    logic [31:0] alu_result;

    logic [21:0] immediate;

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
        .rs2(rs2),
        .immediate(immediate)
    );

    register_file register_file_module (
        .clk(clk),

        .read_addr_a(rs1),
        .read_addr_b(rs2),
        .read_data_a(read_data_a),
        .read_data_b(read_data_b),

        .write_enable(write_enable),
        .write_addr(rd),
        .write_data(write_data)
    );

    alu_control alu_control_module (
        .opcode(opcode),
        .alu_op(alu_op)
    );

    alu alu_module (
        .a(read_data_a),
        .b(read_data_b),
        .alu_operation(alu_op),
        .result(alu_result)
    );
    assign next_pc = pc + 4;

    assign write_enable = 1'b1;
    assign write_data = alu_result;

endmodule