`timescale 1ns/1ps

module decoder_tb;

    logic [31:0] instruction;
    logic [3:0] opcode;
    logic [2:0] rd;
    logic [2:0] rs1;
    logic [2:0] rs2;
    logic [21:0] immediate;

    typedef enum logic [3:0] {
        OP_ADD = 4'b0000,
        OP_SUB = 4'b0001,
        OP_AND = 4'b0010,
        OP_OR  = 4'b0011,
        OP_ADDI = 4'b0100
    } opcode_t;

    decoder test_decoder(
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .immediate(immediate)
    );

    initial begin

        instruction = {OP_ADD, 3'd3, 3'd1, 3'd2, 19'b0};

        #10;

        $display("opcode=%d rd=%d rs1=%d rs2=%d",
                 opcode, rd, rs1, rs2);

        instruction = {OP_ADDI,  3'd7, 3'd1, 22'd7};

        #10;

        $display("opcode=%d rd=%d rs1=%d immediate=%d",
                 opcode, rd, rs1, immediate);

        $finish;
    end

endmodule