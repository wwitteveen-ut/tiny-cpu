`timescale 1ns/1ps

module tb_data_memory;

    logic        clk;
    logic [31:0] address;
    logic [31:0] write_data;
    logic        write_enable;
    logic [31:0] read_data;

    data_memory uut (
        .clk(clk),
        .address(address),
        .write_data(write_data),
        .write_enable(write_enable),
        .read_data(read_data)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin
        $dumpfile("build/data_memory.vcd");
        $dumpvars(0, tb_data_memory);

        clk = 0;
        address = 0;
        write_data = 0;
        write_enable = 0;

        // Read initial value at address 0
        #2;
        $display("Address=%d | Read data=%d (expect 100)",
                 address, read_data);

        // Read address 4
        address = 32'd4;
        #2;
        $display("Address=%d | Read data=%d (expect 200)",
                 address, read_data);

        // Write 999 to address 8
        address = 32'd8;
        write_data = 32'd999;
        write_enable = 1;

        #8;  // reach next rising clock edge

        write_enable = 0;

        // Read back address 8
        #2;
        $display("Address=%d | Read data=%d (expect 999)",
                 address, read_data);

        $finish;
    end

endmodule