`timescale 1ns/1ps
module tb_alu_control;
    reg  [3:0] opcode;
    wire [1:0] alu_op;

    alu_control uut (
        .opcode(opcode),
        .alu_op(alu_op)
    );

    initial begin
        $dumpfile("build/alu_control.vcd");
        $dumpvars(0, tb_alu_control);
        $display("opcode | alu_op");
        opcode = 4'b0000; #10; $display("%b   | %b  (expect 00 ADD)", opcode, alu_op);
        opcode = 4'b0001; #10; $display("%b   | %b  (expect 01 SUB)", opcode, alu_op);
        opcode = 4'b0010; #10; $display("%b   | %b  (expect 10 AND)", opcode, alu_op);
        opcode = 4'b0011; #10; $display("%b   | %b  (expect 11 OR)",  opcode, alu_op);
        opcode = 4'b1111; #10; $display("%b   | %b  (expect 00 default)", opcode, alu_op);
        $finish;
    end
endmodule