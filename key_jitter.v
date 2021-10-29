//`timescale
module key_jitter(
    input clk,
    input rst_n,
    input key_in,
    output reg key_out
    );

    //when clk is 100m,
    //localparam TIME_20MS = 20'd2_000_000;
    //when clk is 25m,
    localparam TIME_20MS = 20'd500_000;
    //when clk is 1m,
    //localparam TIME_20MS = 20'd20_000;

    reg key_cnt;
    reg [20:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if(rst_n == 0)
            key_cnt <= 0;
        else if(key_cnt == 0 && key_out != key_in)
            key_cnt <= 1;
        else if(cnt == TIME_20MS - 1)
            key_cnt <= 0;
    end

    always @(posedge clk or negedge rst_n) begin
        if(rst_n == 0)
            cnt <= 0;
        else if(key_cnt)
            cnt <= cnt + 1'b1;
        else
            cnt <= 0;
    end

    always @(posedge clk or negedge rst_n) begin
        if(rst_n == 0)
            key_out <= 0;
        else if(key_cnt == 0 && key_out != key_in)
            key_out <= key_in;
    end
endmodule
