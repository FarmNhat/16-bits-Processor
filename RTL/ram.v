`include "define.v"
//dual port
module ram(
    input wire [`ADDR_W-1:0] addr1,
    input wire [`ADDR_W-1:0] addr2,
    input wire clk,
    input wire read1, write1,
    //input wire read2, write2,
    inout wire [`MEM_W-1:0] data1,
    inout wire [`MEM_W-1:0] data2 
);

reg [`MEM_W-1 : 0] ram [(2**`ADDR_W)-1 : 0];

always @(posedge clk) begin
    
    if (write1) begin
        ram[addr1] <= data1; // Write data to memory at address
    end
    // if (write2) begin
    //     ram[addr2] <= data2; // Write data to memory at address
    // end
    if (read1) begin
        data1 <= ram[addr1]; // Read data from memory at address
    end
    // if (read2) begin
    //     data2 <= ram[addr2]; // Read data from memory at address
    // end
end

// assign data1 <= ram[addr1]; // Read data from memory at address
// assign data2 <= ram[addr2];

endmodule