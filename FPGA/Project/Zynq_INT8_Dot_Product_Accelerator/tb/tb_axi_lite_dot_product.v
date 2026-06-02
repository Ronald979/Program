`timescale 1ns / 1ps

module tb_axi_lite_dot_product;
    localparam ADDR_CONTROL        = 8'h00;
    localparam ADDR_STATUS         = 8'h04;
    localparam ADDR_VECTOR_LENGTH  = 8'h08;
    localparam ADDR_LATENCY_CYCLES = 8'h0C;
    localparam ADDR_A0             = 8'h10;
    localparam ADDR_A1             = 8'h14;
    localparam ADDR_A2             = 8'h18;
    localparam ADDR_A3             = 8'h1C;
    localparam ADDR_B0             = 8'h20;
    localparam ADDR_B1             = 8'h24;
    localparam ADDR_B2             = 8'h28;
    localparam ADDR_B3             = 8'h2C;
    localparam ADDR_RESULT         = 8'h30;

    reg clk;
    reg rst_n;
    reg [7:0] awaddr;
    reg [2:0] awprot;
    reg awvalid;
    wire awready;
    reg [31:0] wdata;
    reg [3:0] wstrb;
    reg wvalid;
    wire wready;
    wire [1:0] bresp;
    wire bvalid;
    reg bready;
    reg [7:0] araddr;
    reg [2:0] arprot;
    reg arvalid;
    wire arready;
    wire [31:0] rdata;
    wire [1:0] rresp;
    wire rvalid;
    reg rready;

    reg signed [7:0] a_mem [0:15];
    reg signed [7:0] b_mem [0:15];
    integer i;
    integer expected;
    reg [31:0] rd;
    reg [31:0] result_rd;

    axi_lite_dot_product dut (
        .s_axi_aclk(clk),
        .s_axi_aresetn(rst_n),
        .s_axi_awaddr(awaddr),
        .s_axi_awprot(awprot),
        .s_axi_awvalid(awvalid),
        .s_axi_awready(awready),
        .s_axi_wdata(wdata),
        .s_axi_wstrb(wstrb),
        .s_axi_wvalid(wvalid),
        .s_axi_wready(wready),
        .s_axi_bresp(bresp),
        .s_axi_bvalid(bvalid),
        .s_axi_bready(bready),
        .s_axi_araddr(araddr),
        .s_axi_arprot(arprot),
        .s_axi_arvalid(arvalid),
        .s_axi_arready(arready),
        .s_axi_rdata(rdata),
        .s_axi_rresp(rresp),
        .s_axi_rvalid(rvalid),
        .s_axi_rready(rready)
    );

    always #5 clk = ~clk;

    function [31:0] pack4;
        input signed [7:0] x0;
        input signed [7:0] x1;
        input signed [7:0] x2;
        input signed [7:0] x3;
        begin
            pack4 = {x3[7:0], x2[7:0], x1[7:0], x0[7:0]};
        end
    endfunction

    task axi_write;
        input [7:0] addr;
        input [31:0] data;
        begin
            @(posedge clk);
            awaddr <= addr;
            wdata <= data;
            wstrb <= 4'hF;
            awvalid <= 1'b1;
            wvalid <= 1'b1;
            bready <= 1'b0;

            while (!(awready && wready)) begin
                @(posedge clk);
            end

            @(posedge clk);
            awvalid <= 1'b0;
            wvalid <= 1'b0;

            while (!bvalid) begin
                @(posedge clk);
            end

            bready <= 1'b1;
            @(posedge clk);
            bready <= 1'b0;
        end
    endtask

    task axi_read;
        input [7:0] addr;
        output [31:0] data;
        begin
            @(posedge clk);
            araddr <= addr;
            arvalid <= 1'b1;
            rready <= 1'b0;

            while (!arready) begin
                @(posedge clk);
            end

            @(posedge clk);
            arvalid <= 1'b0;

            while (!rvalid) begin
                @(posedge clk);
            end

            data = rdata;
            rready <= 1'b1;
            @(posedge clk);
            rready <= 1'b0;
        end
    endtask

    task load_vectors;
        begin
            expected = 0;
            for (i = 0; i < 16; i = i + 1) begin
                expected = expected + (a_mem[i] * b_mem[i]);
            end

            axi_write(ADDR_A0, pack4(a_mem[0],  a_mem[1],  a_mem[2],  a_mem[3]));
            axi_write(ADDR_A1, pack4(a_mem[4],  a_mem[5],  a_mem[6],  a_mem[7]));
            axi_write(ADDR_A2, pack4(a_mem[8],  a_mem[9],  a_mem[10], a_mem[11]));
            axi_write(ADDR_A3, pack4(a_mem[12], a_mem[13], a_mem[14], a_mem[15]));
            axi_write(ADDR_B0, pack4(b_mem[0],  b_mem[1],  b_mem[2],  b_mem[3]));
            axi_write(ADDR_B1, pack4(b_mem[4],  b_mem[5],  b_mem[6],  b_mem[7]));
            axi_write(ADDR_B2, pack4(b_mem[8],  b_mem[9],  b_mem[10], b_mem[11]));
            axi_write(ADDR_B3, pack4(b_mem[12], b_mem[13], b_mem[14], b_mem[15]));
        end
    endtask

    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        awaddr = 8'd0;
        awprot = 3'd0;
        awvalid = 1'b0;
        wdata = 32'd0;
        wstrb = 4'd0;
        wvalid = 1'b0;
        bready = 1'b0;
        araddr = 8'd0;
        arprot = 3'd0;
        arvalid = 1'b0;
        rready = 1'b0;

        repeat (5) @(posedge clk);
        rst_n = 1'b1;
        repeat (2) @(posedge clk);

        axi_read(ADDR_VECTOR_LENGTH, rd);
        if (rd !== 32'd16) begin
            $display("FAIL vector length expected=16 result=%0d", rd);
            $finish;
        end

        for (i = 0; i < 16; i = i + 1) begin
            a_mem[i] = i - 8;
            b_mem[i] = 7 - i;
        end

        load_vectors;
        axi_write(ADDR_CONTROL, 32'h00000001);

        rd = 32'd0;
        while (rd[1] != 1'b1) begin
            axi_read(ADDR_STATUS, rd);
        end

        axi_read(ADDR_RESULT, rd);
        result_rd = rd;
        if ($signed(rd) !== expected) begin
            $display("FAIL AXI result expected=%0d result=%0d", expected, $signed(rd));
            $finish;
        end

        axi_read(ADDR_LATENCY_CYCLES, rd);
        if (rd !== 32'd16) begin
            $display("FAIL AXI latency expected=16 result=%0d", rd);
            $finish;
        end

        axi_write(ADDR_CONTROL, 32'h00000002);
        axi_read(ADDR_STATUS, rd);
        if (rd[1] !== 1'b0) begin
            $display("FAIL clear_done status=%h", rd);
            $finish;
        end

        $display("PASS AXI wrapper expected=%0d result=%0d latency=16", expected, $signed(result_rd));
        $finish;
    end
endmodule
