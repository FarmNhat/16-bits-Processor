
module control(
    input wire clk,
    input wire reset,
    input wire [2:0] op, 
    output reg  wr, rd, inc_pc, halt, load_pc, 
);
    reg aluop, halt, store, jump, load

    always @(posedge clk) begin
        aluop <= (op == 0) || (op == 1) || (op == 2) || (op == 3);
        store <= op == 4;
        load <= op == 5;
        store <= op == 6;
        halt <= op == 7;
    end

    

endmodule