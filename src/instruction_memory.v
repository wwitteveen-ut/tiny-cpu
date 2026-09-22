module instruction_memory(
    input logic [31:0] pc,
    output logic [31:0] instruction
);

    logic [31:0] memory [0:15];

    //Temporary, later the instructions come form elsewhere
    initial begin
        // ADD R3, R1, R2
        memory[0] = {4'b0000, 4'd3, 4'd1, 4'd2, 16'b0};

        // SUB R4, R3, R1
        memory[1] = {4'b0001, 4'd4, 4'd3, 4'd1, 16'b0};

        // AND R5, R1, R2
        memory[2] = {4'b0010, 4'd5, 4'd1, 4'd2, 16'b0};

        // OR R6, R3, R4
        memory[3] = {4'b0011, 4'd6, 4'd3, 4'd4, 16'b0};
    end

    assign instruction = memory[pc[5:2]];

endmodule