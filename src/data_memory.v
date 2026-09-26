module data_memory (
    input logic clk,
    input logic [31:0] address,
    input logic [31:0] write_data,
    input logic        write_enable,
    output logic [31:0] read_data 
);

    logic [31:0] memory [0:15];

    initial begin
        memory[0] = 32'd100;
        memory[1] = 32'd200;
        memory[2] = 32'd300;
        memory[3] = 32'd400;
    end

    always_ff @(posedge clk) begin
        if (write_enable) begin
            memory[address[5:2]] <= write_data;
        end
    end

    assign read_data = memory[address[5:2]];

endmodule