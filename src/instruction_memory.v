module instruction_memory(
    input logic [31:0] pc,
    output logic [31:0] instruction
);

    logic [31:0] memory [0:15];

    //Temporary, later the instructions come form elsewhere
    initial begin
        memory[0] = 32'h00000001;
        memory[1] = 32'h00000002;
        memory[2] = 32'h00000003;
        memory[3] = 32'h00000004;
    end

    assign instruction = memory[pc[5:2]];

endmodule