`timescale 1ns / 1ps

module int8_dot_product_core #(
    parameter VECTOR_LEN = 16
) (
    input  wire                    clk,
    input  wire                    rst_n,
    input  wire                    start,
    input  wire [VECTOR_LEN*8-1:0] a_vector,
    input  wire [VECTOR_LEN*8-1:0] b_vector,
    output reg                     busy,
    output reg                     done,
    output reg  signed [31:0]      result,
    output reg  [31:0]             latency_cycles
);
    localparam INDEX_WIDTH = 5;

    reg [INDEX_WIDTH-1:0] index;
    reg signed [31:0] acc;
    reg [VECTOR_LEN*8-1:0] a_latched;
    reg [VECTOR_LEN*8-1:0] b_latched;
    reg [31:0] latency_counter;

    wire signed [7:0] a_current;
    wire signed [7:0] b_current;
    wire signed [31:0] acc_next;

    assign a_current = a_latched[index*8 +: 8];
    assign b_current = b_latched[index*8 +: 8];

    int8_mac u_mac (
        .a(a_current),
        .b(b_current),
        .acc_in(acc),
        .acc_out(acc_next)
    );

    always @(posedge clk) begin
        if (!rst_n) begin
            busy <= 1'b0;
            done <= 1'b0;
            result <= 32'sd0;
            latency_cycles <= 32'd0;
            index <= {INDEX_WIDTH{1'b0}};
            acc <= 32'sd0;
            a_latched <= {VECTOR_LEN*8{1'b0}};
            b_latched <= {VECTOR_LEN*8{1'b0}};
            latency_counter <= 32'd0;
        end else begin
            done <= 1'b0;

            if (start && !busy) begin
                busy <= 1'b1;
                index <= {INDEX_WIDTH{1'b0}};
                acc <= 32'sd0;
                a_latched <= a_vector;
                b_latched <= b_vector;
                latency_counter <= 32'd0;
            end else if (busy) begin
                acc <= acc_next;
                latency_counter <= latency_counter + 32'd1;

                if (index == VECTOR_LEN - 1) begin
                    busy <= 1'b0;
                    done <= 1'b1;
                    result <= acc_next;
                    latency_cycles <= latency_counter + 32'd1;
                    index <= {INDEX_WIDTH{1'b0}};
                end else begin
                    index <= index + {{(INDEX_WIDTH-1){1'b0}}, 1'b1};
                end
            end
        end
    end
endmodule
