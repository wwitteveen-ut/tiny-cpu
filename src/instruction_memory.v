module instruction_memory(
    input logic [31:0] pc,
    output logic [31:0] instruction
);

    logic [31:0] memory [0:15];

    //Temporary, later the instructions come form elsewhere
    initial begin
        // ADD R3, R1, R2
        memory[0] = {4'b0000, 3'd3, 3'd1, 3'd2, 19'b0};

        // SUB R4, R3, R1
        memory[1] = {4'b0001, 3'd4, 3'd3, 3'd1, 19'b0};

        // AND R5, R1, R2
        memory[2] = {4'b0010, 3'd5, 3'd1, 3'd2, 19'b0};

        // OR R6, R3, R4
        memory[3] = {4'b0011, 3'd6, 3'd3, 3'd4, 19'b0};
    end

    assign instruction = memory[pc[5:2]];

endmodule