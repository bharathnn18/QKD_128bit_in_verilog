`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: tb_top_qkd_core
//////////////////////////////////////////////////////////////////////////////////
module tb_top_qkd_core;

    reg clk;
    reg rst;
    wire [127:0] final_key;

    top_qkd_core uut (
        .clk(clk),
        .rst(rst),
        .final_key(final_key)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("=== QKD Simulation Started ===");
        rst = 1;
        #20 rst = 0;
        #100000;
        $display("Final Key = %b", final_key);
        $display("=== QKD Simulation Completed ===");
        $stop;
    end

endmodule