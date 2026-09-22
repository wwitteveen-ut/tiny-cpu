`timescale 1ns/1ps

module register_file_tb;

    logic clk;

    logic [2:0] read_addr_a;
    logic [2:0] read_addr_b;
    logic [7:0] read_data_a;
    logic [7:0] read_data_b;

    logic write_enable;

    logic [2:0] write_addr;
    logic [7:0] write_data;

    register_file test_register_file (
        .clk(clk),
        .read_addr_a(read_addr_a),
        .read_addr_b(read_addr_b),
        .read_data_a(read_data_a),
        .read_data_b(read_data_b),
        .write_enable(write_enable),
        .write_addr(write_addr),
        .write_data(write_data)
    );

    initial begin
        $dumpfile("build/register_file.vcd");
        $dumpvars(0, register_file_tb);

        clk = 0;

        read_addr_a = 0;
        read_addr_b = 0;

        write_enable = 0;
        write_addr = 0;
        write_data = 0;

        //Test 1: Write 42 in register 3
        #2;
        write_enable = 1;
        write_addr = 3;
        write_data = 42;

        #10;
        
        // Stop writing
        write_enable = 0;

        // Read register 3
        read_addr_a = 3;

        #2;

        $display("R3 = %d", read_data_a);

        // Write 99 into register 5
        write_enable = 1;
        write_addr = 5;
        write_data = 99;

        #10;

        // Read registers 3 and 5
        write_enable = 0;
        read_addr_a = 3;
        read_addr_b = 5;

        #2;

        $display("R3 = %d, R5 = %d",
                 read_data_a,
                 read_data_b);

        #10;

        $finish;
    end
    
    always #5 clk = ~clk;

endmodule

