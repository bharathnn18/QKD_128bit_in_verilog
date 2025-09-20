`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: top_qkd_core
//////////////////////////////////////////////////////////////////////////////////
module top_qkd_core (
    input clk,
    input rst,
    output [127:0] final_key
);

    parameter N = 640;

    // Memory loaded from Python-generated .mem file (3 bits: alice_bit, alice_base, bob_base)
    reg [2:0] data_mem [0:N-1];
    reg [10:0] i;

    reg [639:0] alice_bits;
    reg [639:0] alice_bases;
    reg [639:0] bob_bases;

    wire [1279:0] qubit;
    wire [1279:0] sifted_sender, s_valid_sender;
    wire [1279:0] sifted_receiver, s_valid_receiver;
    wire [1279:0] final_sender, final_receiver;
    wire [10:0] sender_len, receiver_len;
    wire [127:0] key_out;

    initial begin
        $readmemb("C:/Users/TARUN/QKD_128bit/QKD_128bit.sim/sim_1/behave/xsim/data.mem", data_mem);
        for (i = 0; i < N; i = i + 1) begin
            alice_bits[i]  = data_mem[i][2];
            alice_bases[i] = data_mem[i][1];
            bob_bases[i]   = data_mem[i][0];
        end
        $display("Loaded data.mem: alice_bits = %b \n alice_bases = %b \n bob_bases = %b", alice_bits, alice_bases, bob_bases);
    end

    qubit sender (
        .clk(clk),
        .r_bit(alice_bits),
        .r_base(alice_bases),
        .qubit(qubit)
    );

    sender_sifted s_sifted (
        .clk(clk),
        .qubit(qubit),
        .sender_bases(alice_bases),
        .receiver_bases(bob_bases),
        .sifted_valid(s_valid_sender),
        .sifted_sender(sifted_sender)
    );

    receiver_sifted r_sifted (
        .clk(clk),
        .qubit(qubit),
        .r_bases(alice_bases),
        .s_bases(bob_bases),
        .sifted_valid(s_valid_receiver),
        .sifted_receiver(sifted_receiver)
    );

    siftedkey_gen keygen (
        .clk(clk),
        .sender_sifted(sifted_sender),
        .sender_svalid(s_valid_sender),
        .receiver_sifted(sifted_receiver),
        .receiver_svalid(s_valid_receiver),
        .sender_vsifted(final_sender),
        .receiver_vsifted(final_receiver),
        .sender_len(sender_len),
        .receiver_len(receiver_len)
    );

    key_generation key_module (
        .clk(clk),
        .sender_vsifted(final_sender),
        .receiver_vsifted(final_receiver),
        .key(key_out)
    );

    assign final_key = key_out;

    initial begin
        #1000;
        $display("Final Key = %b", final_key);
    end

endmodule