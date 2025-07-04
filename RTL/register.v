`include "define.v"

module reg(
    input [`MEM_W-1:0] data_in, // Address for the register
    output [`MEM_W-1:0] data_out, // Data output from the register
    input sel, 
    input wire clk, rst
    input wire wr, rd
); 

reg [`MEM_W-1 : 0] reg [`REG_W-1 : 0];

always @(posedge clk)begin
    if (rst) begin
        reg[sel] <= 0; // Reset register 0 to 
    end else begin
        if(wr)begin
            reg[sel] <= data_in; // Write data to register 
        end
        else(rd)begin
            data_out <= reg[sel]; // Read data from register 
        end
    end
end
endmodule