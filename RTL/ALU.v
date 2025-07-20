
module ALU (
  input [8:0] a, b;
  input [2:0] op;
  output [8:0] result
  );

  always @(*) begin
    case (op)
      3'b000: result = a + b; // ADD
      3'b001: result = a - b; // SUB
      3'b010: result = a & b; // AND
      3'b011: result = a | b; // OR
      
      default: result = 8'b00000000; // Default case
    endcase

  end
endmodule


