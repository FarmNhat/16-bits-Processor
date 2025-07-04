
module counter(
    input wire clk,
    input wire rst, load, en,
    input wire [15:0] cnt_in,
    output reg [15:0] cnt_out
);

always @(posedge clk)begin
    if (rst) begin
        cnt_out <= 16'b0; // Reset counter to 0
    end else if (load) begin
        cnt_out <= cnt_in; // Load the counter with input value
    end else if (en) begin
        cnt_out <= cnt_out + 1; // Increment counter
    end
end
endmodule