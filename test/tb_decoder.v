`timescale 1ns/1ps

module decoder_tb;

    logic [31:0] instruction;
    logic [3:0] opcode;
    logic [3:0] rd;
    logic [3:0] rs1;
    logic [3:0] rs2;

    typedef enum logic [3:0] {
        OP_ADD = 4'b0000,
        OP_SUB = 4'b0001,
        OP_AND = 4'b0010,
        OP_OR  = 4'b0011
    } opcode_t;

    decoder test_decoder(
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2)
    );

    initial begin

        instruction = {OP_ADD, 4'd3, 4'd1, 4'd2, 16'b0};

        #10;

        $display("opcode=%d rd=%d rs1=%d rs2=%d",
                 opcode, rd, rs1, rs2);

        $finish;
    end

endmodule