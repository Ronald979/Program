`timescale 1ns / 1ps

module tb_int8_dot_product_core;
    reg clk;
    reg rst_n;
    reg start;
    reg [127:0] a_vector;
    reg [127:0] b_vector;
    wire busy;
    wire done;
    wire signed [31:0] result;
    wire [31:0] latency_cycles;

    reg signed [7:0] a_mem [0:15];
    reg signed [7:0] b_mem [0:15];
    integer i;
    integer expected;
    integer test_count;
    integer pass_count;

    int8_dot_product_core #(
        .VECTOR_LEN(16)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .a_vector(a_vector),
        .b_vector(b_vector),
        .busy(busy),
        .done(done),
        .result(result),
        .latency_cycles(latency_cycles)
    );

    always #5 clk = ~clk;

    task pack_vectors;
        begin
            a_vector = 128'd0;
            b_vector = 128'd0;
            expected = 0;
            for (i = 0; i < 16; i = i + 1) begin
                a_vector[i*8 +: 8] = a_mem[i];
                b_vector[i*8 +: 8] = b_mem[i];
                expected = expected + (a_mem[i] * b_mem[i]);
            end
        end
    endtask

    task run_case;
        input [255:0] name;
        begin
            pack_vectors;
            test_count = test_count + 1;
            @(posedge clk);
            start = 1'b1;
            @(posedge clk);
            start = 1'b0;
            wait (done == 1'b1);
            @(posedge clk);

            if (result !== expected) begin
                $display("FAIL %-32s expected=%0d result=%0d", name, expected, result);
                $finish;
            end

            if (latency_cycles !== 32'd16) begin
                $display("FAIL %-32s expected latency=16 result latency=%0d", name, latency_cycles);
                $finish;
            end

            pass_count = pass_count + 1;
            $display("PASS %-32s result=%0d latency=%0d", name, result, latency_cycles);
        end
    endtask

    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        start = 1'b0;
        a_vector = 128'd0;
        b_vector = 128'd0;
        test_count = 0;
        pass_count = 0;

        repeat (5) @(posedge clk);
        rst_n = 1'b1;
        repeat (2) @(posedge clk);

        for (i = 0; i < 16; i = i + 1) begin
            a_mem[i] = 8'sd0;
            b_mem[i] = 8'sd0;
        end
        run_case("zero");

        for (i = 0; i < 16; i = i + 1) begin
            a_mem[i] = 8'sd1;
            b_mem[i] = 8'sd1;
        end
        run_case("all_one");

        for (i = 0; i < 16; i = i + 1) begin
            a_mem[i] = i - 8;
            b_mem[i] = 7 - i;
        end
        run_case("mixed_sign");

        for (i = 0; i < 16; i = i + 1) begin
            a_mem[i] = 8'sd127;
            b_mem[i] = -8'sd128;
        end
        run_case("max_magnitude_negative");

        for (i = 0; i < 16; i = i + 1) begin
            a_mem[i] = (i[0]) ? -8'sd3 : 8'sd5;
            b_mem[i] = (i[1]) ? 8'sd11 : -8'sd7;
        end
        run_case("alternating");

        $display("SUMMARY core tests pass=%0d total=%0d", pass_count, test_count);
        $finish;
    end
endmodule
