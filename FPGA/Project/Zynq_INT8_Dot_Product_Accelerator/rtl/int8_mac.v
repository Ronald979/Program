`timescale 1ns / 1ps

module int8_mac (
    input  wire signed [7:0]  a,
    input  wire signed [7:0]  b,
    input  wire signed [31:0] acc_in,
    output wire signed [31:0] acc_out
);
    wire signed [15:0] product;

    assign product = a * b;
    assign acc_out = acc_in + {{16{product[15]}}, product};
endmodule
