`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: key_generation
//////////////////////////////////////////////////////////////////////////////////
module key_generation(
    input clk,
    input [639:0] sender_vsifted,
    input [639:0] receiver_vsifted,
    output reg [127:0] key
);

    integer i;
    integer key_index;

    always @(posedge clk) begin
        key_index = 0;
        key = 128'b0;

        for (i = 0; i < 640; i = i + 1) begin
            if (sender_vsifted[i] == receiver_vsifted[i]) begin
                if (key_index < 128) begin
                    key[key_index] = sender_vsifted[i];
                    key_index = key_index + 1;
                end
            end
        end
    end

endmodule