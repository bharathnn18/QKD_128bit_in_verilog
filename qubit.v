`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: qubit
//////////////////////////////////////////////////////////////////////////////////
module qubit(
    input clk,
    input [639:0] r_bit,
    input [639:0] r_base,
    output reg [1279:0] qubit
);
    parameter ZERO = 2'b00, NINETY = 2'b01, FORTYFIVE = 2'b10, ONETHREEFIVE = 2'b11;
    integer i;
    always @(posedge clk) begin
        for(i = 0; i < 640; i = i + 1) begin
            if(r_bit[i] == 1'b0 && r_base[i] == 1'b0) qubit[2*i+:2] = ZERO;
            else if(r_bit[i] == 1'b1 && r_base[i] == 1'b0) qubit[2*i+:2] = NINETY;
            else if(r_bit[i] == 1'b0 && r_base[i] == 1'b1) qubit[2*i+:2] = FORTYFIVE;
            else if(r_bit[i] == 1'b1 && r_base[i] == 1'b1) qubit[2*i+:2] = ONETHREEFIVE;
        end
    end
endmodule