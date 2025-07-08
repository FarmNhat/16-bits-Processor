module int_float(
    input wire [31:0] in,
    output wire [31:0] out,
    input wire clk,
    input wire rst,
);

reg [23:0] man;
reg [7:0] exp;
reg [7:0] round;
reg sign;
reg [2:0] state;
reg [31:0] val_a; //temp val for a

reg guard, r_bit, sticky; //for rounding

parameter conv0 = 3'd0; 
parameter conv1 = 3'd1; 
parameter conv2 = 3'd2;
parameter round = 3'd3;
parameter pack = 3'd4;

always @(posedge clk) begin
    case(state)
        conv0:
            if(in == 0)begin
                man <= 0;
                exp <= -127;
                sign <= 0;
                state <= pack;
            end else begin
                val_a <= in[31] ? -in : in;  
                sign <= in[31];
                state <= conv1;
            end

        conv1: begin
            sign <= val_a[31];
            exp <= val_a[31:8];
            round <= val_a[7:0];
            state <= conv2;
        end

        conv2: begin
            if(!man[23])begin
                exp <= exp - 1; 
                man <= man << 1;    //shift liên tục cho tới khi man[23] chạm 1 vì int bắt đầu từ đáy.
                man[0] <= round[7];
                round <= round << 1;
            end
            else begin
                guard <= round[7]; //guard bit  
                r_bit <= round[6]; //round bit
                sticky <= |round[5:0]; //sticky bit
            end
        end

        round: begin
            if(guard && (r_bit || sticky || man[0]))begin   //1.10000 thì ko làm tròn vì các rbt sticky = 0, 1.10001 cân tròn vì mấy cái sau lớn hơn 0, nên quá bán
                man <= man + 1; //round up
                if(man == 24'hffffff)begin
                    exp <= exp + 1;
                end
            end
            state <= pack;
        end

        pack: begin
            out[31] <= sign; //sign bit
            out[30:23] <= exp + 127; //bias exponent
            out[22:0] <= man;
            state <= conv0; //reset state for next conversion
        end


    endcase
end

endmodule