`timescale 1ns/1ps

module alu_tb;
    typedef enum logic [1:0] {
        ADD = 2'b00,
        SUB = 2'b01,
        AND = 2'b10,
        OR = 2'b11
    } operation_t;


    logic [31:0] a;
    logic [31:0] b;


    operation_t operation;
    logic [31:0] result;

    alu uut (
        .a(a),
        .b(b),
        .operation(operation),
        .result(result)
    );

    initial begin

        $dumpfile("build/alu.vcd");
        $dumpvars(0, alu_tb);

        a = 10;
        b = 5;

        operation = ADD;

        #10;

        $display("ADD: %d + %d = %d", a, b, result);

        // Test SUB
        operation = SUB;

        #10;

        $display("SUB: %d - %d = %d", a, b, result);

        // Test AND
        operation = AND;

        #10;

        $display("AND: %d & %d = %d", a, b, result);

        // Test OR
        operation = OR;

        #10;

        $display("OR: %d | %d = %d", a, b, result);

        $finish;

    end

endmodule