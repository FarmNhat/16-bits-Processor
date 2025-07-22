
module control(
    input wire clk,
    input wire reset,
    input wire [2:0] op, 
    output reg  wr, rd, inc_pc, halt, alu, load_pc
);
    reg aluop, halt, store, jump, load;

    always @(posedge clk) begin
        aluop <= (op == 0) || (op == 1) || (op == 2) || (op == 3);
        jump <= op == 4; 
        load <= op == 5;
        store <= op == 6;
        halt <= op == 7;
    end

    always @(posedge clk or posedge reset) begin
        
            case (op)
                3'b000: begin // ALU operation
                    alu <= 1;
                    wr <= 0;
                    rd <= 0;
                    inc_pc <= 1;
                    load_pc <= 0;
                    halt <= 0;
                end
                3'd4: begin // jump operation
                    alu <= 0;
                    wr <= 0;
                    rd <= 0;
                    inc_pc <= 1;
                    load_pc <= 1;
                    halt <= 0;
                end
                3'd5: begin // load operation
                    alu <= 0;
                    wr <= 0;
                    rd <= 1;
                    inc_pc <= 1;
                    load_pc <= 0;
                    halt <= 0;
                end
                3'd6: begin // Store operation
                    alu <= 0;
                    wr <= 1;
                    rd <= 0;
                    inc_pc <= 1;
                    load_pc <= 0;
                    halt <= 0;
                end
                3'd7: begin // Halt operation
                    alu <= 0;
                    wr <= 0;
                    rd <= 0;
                    inc_pc <= 0;
                    load_pc <= 0;
                    halt <= 1; // Set halt signal
                end

                // Add more cases for other operations as needed
               
            endcase

    end

endmodule