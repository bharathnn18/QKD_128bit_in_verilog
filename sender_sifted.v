`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: sender_sifted
//////////////////////////////////////////////////////////////////////////////////
module sender_sifted(
    input clk,
    input [1279:0] qubit,
    input [1279:0] sender_bases,
    input [1279:0] receiver_bases,
    output reg [1279:0] sifted_valid,
    output reg [1279:0] sifted_sender
);
    parameter ZERO = 2'b00, NINETY = 2'b01, FORTYFIVE = 2'b10, ONETHREEFIVE = 2'b11;
    integer i;
    always @(posedge clk) begin
        for(i = 0; i < 640; i = i + 1) begin
            if(sender_bases[i] == receiver_bases[i]) begin
                if(sender_bases[i] == 0 && qubit[2*i+:2] == ZERO) begin
                    sifted_sender[i] = 1'b0; sifted_valid[i] = 1'b1;
                end
                else if(sender_bases[i] == 0 && qubit[2*i+:2] == NINETY) begin
                    sifted_sender[i] = 1'b1; sifted_valid[i] = 1'b1;
                end
                else if(sender_bases[i] == 1 && qubit[2*i+:2] == FORTYFIVE) begin
                    sifted_sender[i] = 1'b0; sifted_valid[i] = 1'b1;
                end
                else if(sender_bases[i] == 1 && qubit[2*i+:2] == ONETHREEFIVE) begin
                    sifted_sender[i] = 1'b1; sifted_valid[i] = 1'b1;
                end
                else begin
                    sifted_sender[i] = 1'bx; sifted_valid[i] = 1'b0;
                end
            end
            else begin
                sifted_sender[i] = 1'bx; sifted_valid[i] = 1'b0;
            end
        end
    end
endmodule