`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: siftedkey_gen
//////////////////////////////////////////////////////////////////////////////////
module siftedkey_gen(
    input clk,
    input [639:0] sender_sifted,
    input [639:0] sender_svalid,
    input [639:0] receiver_sifted,
    input [639:0] receiver_svalid,
    output reg [639:0] sender_vsifted,
    output reg [639:0] receiver_vsifted,
    output reg [10:0] sender_len,
    output reg [10:0] receiver_len
);
    integer i;
    reg [10:0] sender_idx;
    reg [10:0] receiver_idx;

    always @(posedge clk) begin
        sender_idx = 0;
        receiver_idx = 0;
        sender_vsifted = 1024'b0;
        receiver_vsifted = 1024'b0;

        for (i = 0; i < 640; i = i + 1) begin
            if (sender_svalid[i]) begin
                sender_vsifted[sender_idx] = sender_sifted[i];
                sender_idx = sender_idx + 1;
            end
            if (receiver_svalid[i]) begin
                receiver_vsifted[receiver_idx] = receiver_sifted[i];
                receiver_idx = receiver_idx + 1;
            end
        end

        sender_len = sender_idx;
        receiver_len = receiver_idx;
    end
endmodule