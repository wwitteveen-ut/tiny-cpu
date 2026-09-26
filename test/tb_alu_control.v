`timescale 1ns/1ps
module tb_alu_control;
    logic  [3:0] opcode;
    logic [1:0] alu_op;
    logic [1:0] alu_src;

    alu_control uut (
        .opcode(opcode),
        .alu_op(alu_op),
        .alu_src(alu_src)
    );

    initial begin
        $dumpfile("build/alu_control.vcd");
        $dumpvars(0, tb_alu_control);

        $display("opcode | alu_op | alu_src");

        opcode = 4'b0000; #10;
        $display("%b    | %b     | %b   (expect 00, 0 ADD)", opcode, alu_op, alu_src);

        opcode = 4'b0001; #10;
        $display("%b    | %b     | %b   (expect 01, 0 SUB)", opcode, alu_op, alu_src);

        opcode = 4'b0010; #10;
        $display("%b    | %b     | %b   (expect 10, 0 AND)", opcode, alu_op, alu_src);

        opcode = 4'b0011; #10;
        $display("%b    | %b     | %b   (expect 11, 0 OR)", opcode, alu_op, alu_src);

        opcode = 4'b0100; #10;
        $display("%b    | %b     | %b   (expect 00, 1 ADDI)", opcode, alu_op, alu_src);

        opcode = 4'b1111; #10;
        $display("%b    | %b     | %b   (expect 00, 0 default)", opcode, alu_op, alu_src);

        $finish;
    end
endmodule