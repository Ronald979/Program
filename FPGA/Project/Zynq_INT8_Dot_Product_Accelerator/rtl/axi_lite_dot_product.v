`timescale 1ns / 1ps

module axi_lite_dot_product #(
    parameter C_S_AXI_ADDR_WIDTH = 8,
    parameter C_S_AXI_DATA_WIDTH = 32
) (
    input  wire                              s_axi_aclk,
    input  wire                              s_axi_aresetn,

    input  wire [C_S_AXI_ADDR_WIDTH-1:0]     s_axi_awaddr,
    input  wire [2:0]                        s_axi_awprot,
    input  wire                              s_axi_awvalid,
    output wire                              s_axi_awready,

    input  wire [C_S_AXI_DATA_WIDTH-1:0]     s_axi_wdata,
    input  wire [(C_S_AXI_DATA_WIDTH/8)-1:0] s_axi_wstrb,
    input  wire                              s_axi_wvalid,
    output wire                              s_axi_wready,

    output reg  [1:0]                        s_axi_bresp,
    output reg                               s_axi_bvalid,
    input  wire                              s_axi_bready,

    input  wire [C_S_AXI_ADDR_WIDTH-1:0]     s_axi_araddr,
    input  wire [2:0]                        s_axi_arprot,
    input  wire                              s_axi_arvalid,
    output wire                              s_axi_arready,

    output reg  [C_S_AXI_DATA_WIDTH-1:0]     s_axi_rdata,
    output reg  [1:0]                        s_axi_rresp,
    output reg                               s_axi_rvalid,
    input  wire                              s_axi_rready
);
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

    localparam AXI_RESP_OKAY = 2'b00;

    reg aw_holding;
    reg w_holding;
    reg [C_S_AXI_ADDR_WIDTH-1:0] awaddr_reg;
    reg [C_S_AXI_DATA_WIDTH-1:0] wdata_reg;
    reg [(C_S_AXI_DATA_WIDTH/8)-1:0] wstrb_reg;

    reg [31:0] a_reg0;
    reg [31:0] a_reg1;
    reg [31:0] a_reg2;
    reg [31:0] a_reg3;
    reg [31:0] b_reg0;
    reg [31:0] b_reg1;
    reg [31:0] b_reg2;
    reg [31:0] b_reg3;
    reg done_sticky;
    reg core_start;

    wire [127:0] a_vector;
    wire [127:0] b_vector;
    wire core_busy;
    wire core_done;
    wire signed [31:0] core_result;
    wire [31:0] core_latency_cycles;

    assign s_axi_awready = !aw_holding && !s_axi_bvalid;
    assign s_axi_wready  = !w_holding && !s_axi_bvalid;
    assign s_axi_arready = !s_axi_rvalid;

    assign a_vector = {a_reg3, a_reg2, a_reg1, a_reg0};
    assign b_vector = {b_reg3, b_reg2, b_reg1, b_reg0};

    int8_dot_product_core #(
        .VECTOR_LEN(16)
    ) u_core (
        .clk(s_axi_aclk),
        .rst_n(s_axi_aresetn),
        .start(core_start),
        .a_vector(a_vector),
        .b_vector(b_vector),
        .busy(core_busy),
        .done(core_done),
        .result(core_result),
        .latency_cycles(core_latency_cycles)
    );

    function [31:0] apply_wstrb;
        input [31:0] old_value;
        input [31:0] new_value;
        input [3:0]  wstrb;
        integer i;
        begin
            apply_wstrb = old_value;
            for (i = 0; i < 4; i = i + 1) begin
                if (wstrb[i]) begin
                    apply_wstrb[i*8 +: 8] = new_value[i*8 +: 8];
                end
            end
        end
    endfunction

    function [31:0] read_register;
        input [C_S_AXI_ADDR_WIDTH-1:0] addr;
        begin
            case (addr[7:0])
                ADDR_CONTROL:        read_register = 32'd0;
                ADDR_STATUS:         read_register = {30'd0, done_sticky, core_busy};
                ADDR_VECTOR_LENGTH:  read_register = 32'd16;
                ADDR_LATENCY_CYCLES: read_register = core_latency_cycles;
                ADDR_A0:             read_register = a_reg0;
                ADDR_A1:             read_register = a_reg1;
                ADDR_A2:             read_register = a_reg2;
                ADDR_A3:             read_register = a_reg3;
                ADDR_B0:             read_register = b_reg0;
                ADDR_B1:             read_register = b_reg1;
                ADDR_B2:             read_register = b_reg2;
                ADDR_B3:             read_register = b_reg3;
                ADDR_RESULT:         read_register = core_result;
                default:             read_register = 32'd0;
            endcase
        end
    endfunction

    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            aw_holding <= 1'b0;
            w_holding <= 1'b0;
            awaddr_reg <= {C_S_AXI_ADDR_WIDTH{1'b0}};
            wdata_reg <= {C_S_AXI_DATA_WIDTH{1'b0}};
            wstrb_reg <= {(C_S_AXI_DATA_WIDTH/8){1'b0}};
            s_axi_bresp <= AXI_RESP_OKAY;
            s_axi_bvalid <= 1'b0;
            a_reg0 <= 32'd0;
            a_reg1 <= 32'd0;
            a_reg2 <= 32'd0;
            a_reg3 <= 32'd0;
            b_reg0 <= 32'd0;
            b_reg1 <= 32'd0;
            b_reg2 <= 32'd0;
            b_reg3 <= 32'd0;
            done_sticky <= 1'b0;
            core_start <= 1'b0;
        end else begin
            core_start <= 1'b0;

            if (core_done) begin
                done_sticky <= 1'b1;
            end

            if (s_axi_awready && s_axi_awvalid) begin
                aw_holding <= 1'b1;
                awaddr_reg <= s_axi_awaddr;
            end

            if (s_axi_wready && s_axi_wvalid) begin
                w_holding <= 1'b1;
                wdata_reg <= s_axi_wdata;
                wstrb_reg <= s_axi_wstrb;
            end

            if (aw_holding && w_holding && !s_axi_bvalid) begin
                case (awaddr_reg[7:0])
                    ADDR_CONTROL: begin
                        if (wdata_reg[0] && !core_busy) begin
                            core_start <= 1'b1;
                            done_sticky <= 1'b0;
                        end
                        if (wdata_reg[1]) begin
                            done_sticky <= 1'b0;
                        end
                    end
                    ADDR_A0: a_reg0 <= apply_wstrb(a_reg0, wdata_reg, wstrb_reg);
                    ADDR_A1: a_reg1 <= apply_wstrb(a_reg1, wdata_reg, wstrb_reg);
                    ADDR_A2: a_reg2 <= apply_wstrb(a_reg2, wdata_reg, wstrb_reg);
                    ADDR_A3: a_reg3 <= apply_wstrb(a_reg3, wdata_reg, wstrb_reg);
                    ADDR_B0: b_reg0 <= apply_wstrb(b_reg0, wdata_reg, wstrb_reg);
                    ADDR_B1: b_reg1 <= apply_wstrb(b_reg1, wdata_reg, wstrb_reg);
                    ADDR_B2: b_reg2 <= apply_wstrb(b_reg2, wdata_reg, wstrb_reg);
                    ADDR_B3: b_reg3 <= apply_wstrb(b_reg3, wdata_reg, wstrb_reg);
                    default: begin
                    end
                endcase

                aw_holding <= 1'b0;
                w_holding <= 1'b0;
                s_axi_bresp <= AXI_RESP_OKAY;
                s_axi_bvalid <= 1'b1;
            end else if (s_axi_bvalid && s_axi_bready) begin
                s_axi_bvalid <= 1'b0;
            end
        end
    end

    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            s_axi_rdata <= {C_S_AXI_DATA_WIDTH{1'b0}};
            s_axi_rresp <= AXI_RESP_OKAY;
            s_axi_rvalid <= 1'b0;
        end else begin
            if (s_axi_arready && s_axi_arvalid) begin
                s_axi_rdata <= read_register(s_axi_araddr);
                s_axi_rresp <= AXI_RESP_OKAY;
                s_axi_rvalid <= 1'b1;
            end else if (s_axi_rvalid && s_axi_rready) begin
                s_axi_rvalid <= 1'b0;
            end
        end
    end

    wire unused_axi_inputs;
    assign unused_axi_inputs = ^{s_axi_awprot, s_axi_arprot};
endmodule
