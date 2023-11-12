/*
 *  kianv.v - a simple RISC-V rv32ima
 *
 *  copyright (c) 2023 hirosh dabui <hirosh@dabui.de>
 *
 *  permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  the software is provided "as is" and the author disclaims all warranties
 *  with regard to this software including all implied warranties of
 *  merchantability and fitness. in no event shall the author be liable for
 *  any special, direct, indirect, or consequential damages or any damages
 *  whatsoever resulting from loss of use, data or profits, whether in an
 *  action of contract, negligence or other tortious action, arising out of
 *  or in connection with the use or performance of this software.
 *
 */
`default_nettype none `timescale 1 ns / 100 ps
module spi #(
        parameter SYSTEM_CLK = 50_000_000,
        parameter SPI_FREQ   = 1_000_000,   // Desired SPI frequency
        parameter QUAD_MODE  = 1'b1
    ) (
        input wire clk,
        input wire resetn,

        input wire ctrl,  /* 0: cs control, 1: data */
        output wire [31:0] rdata,
        input wire [31:0] wdata,
        input wire [3:0] wstrb,
        input wire valid,
        output wire ready,

        output wire cen,
        output reg  sclk,
        inout  wire sio1_so_miso,
        inout  wire sio0_si_mosi,
        inout  wire sio2,
        inout  wire sio3
    );
    /* verilator lint_off WIDTHTRUNC */
    localparam SPI_FREQ_BIT_WIDTH = $clog2(SPI_FREQ);
    localparam [SPI_FREQ_BIT_WIDTH -1:0] CYCLES_TO_TICK = ($rtoi(SYSTEM_CLK / (SPI_FREQ)) / 2);
    /* verilator lint_on WIDTHTRUNC */

    assign rdata = ctrl ? rx_data : {31'b0, spi_cen};

    reg spi_cen;
    reg spi_cen_nxt;

    reg [3:0] sio_oe;
    reg [3:0] sio_out;
    wire [3:0] sio_in;

    wire [3:0] sio;
    assign {sio3, sio2, sio1_so_miso, sio0_si_mosi} = sio;

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            assign sio[i] = sio_oe[i] ? sio_out[i] : 1'bz;
        end
    endgenerate

    assign sio_in = {sio3, sio2, sio1_so_miso, sio0_si_mosi};

    assign ready = ready_xfer || ready_ctrl;
    assign cen = spi_cen;
    reg ready_ctrl;
    reg ready_ctrl_next;
    always @(posedge clk) begin
        if (!resetn) begin
            spi_cen <= 1'b1;
            ready_ctrl <= 1'b0;
        end else begin
            spi_cen <= spi_cen_nxt;
            ready_ctrl <= ready_ctrl_next;
        end
    end

    wire ctrl_access = !ctrl & valid;
    always @(*) begin
        ready_ctrl_next = 1'b0;
        spi_cen_nxt = spi_cen;
        if (ctrl_access) begin
            if (wstrb[0]) spi_cen_nxt = ~wdata[0];
            ready_ctrl_next = 1'b1;
        end
    end

    localparam [0:0] S0_IDLE = 0;
    localparam [0:0] S1_WAIT_FOR_XFER_DONE = 1;

    reg [0:0] state, next_state;
    reg [7:0] spi_buf;
    reg [5:0] xfer_cycles;
    reg is_quad;

    reg [31:0] rx_data;
    reg [31:0] rx_data_next;

    reg sclk_next;
    reg [3:0] sio_oe_next;
    reg [3:0] sio_out_next;
    reg [7:0] spi_buf_next;
    reg is_quad_next;
    reg [5:0] xfer_cycles_next;
    reg ready_xfer_next;
    reg ready_xfer;

    always @(posedge clk) begin
        if (!resetn) begin
            sclk <= 1'b1;
            sio_oe <= 4'b1111;
            sio_out <= 4'b0000;
            spi_buf <= 0;
            is_quad <= 0;
            xfer_cycles <= 0;
            ready_xfer <= 0;
            state <= S0_IDLE;
        end else begin
            state <= next_state;
            sclk <= sclk_next;
            sio_oe <= sio_oe_next;
            sio_out <= sio_out_next;
            spi_buf <= spi_buf_next;
            is_quad <= is_quad_next;
            xfer_cycles <= xfer_cycles_next;
            rx_data <= rx_data_next;
            ready_xfer <= ready_xfer_next;
        end
    end

    always @(*) begin
        next_state = state;
        sclk_next = sclk;
        sio_oe_next = sio_oe;
        sio_out_next = sio_out;
        spi_buf_next = spi_buf;
        is_quad_next = is_quad;
        ready_xfer_next = ready_xfer;
        rx_data_next = rx_data;
        xfer_cycles_next = xfer_cycles;

        if (|xfer_cycles) begin
            if (tick || (SPI_FREQ == 0)) begin
                sio_out_next[3:0] = is_quad ? spi_buf[7:4] : {3'b0, spi_buf[7]};
                if (sclk) begin
                    sclk_next = 1'b0;
                end else begin
                    sclk_next = 1'b1;
                    spi_buf_next = is_quad ? {spi_buf[3:0], sio_in[3:0]} : {spi_buf[6:0], sio_in[1]};
                    xfer_cycles_next = is_quad ? xfer_cycles - 4 : xfer_cycles - 1;
                end
            end

        end else begin
            case (state)
                S0_IDLE: begin
                    if (valid && ctrl) begin // && !ready_xfer) begin  // && !ready_xfer) begin
                        is_quad_next = QUAD_MODE;

                        if (wstrb[0]) begin
                            ready_xfer_next = 1'b0;
                            spi_buf_next = wdata[7:0];
                            sio_oe_next  = QUAD_MODE ? 4'b1111 : 4'b0001;
                            xfer_cycles_next = 8;  /* byte */
                        end else begin
                            xfer_cycles_next = 0;  /* byte */
                            //sio_oe_next  = QUAD_MODE ? 4'b0000 : 4'b0001;
                        end

                        next_state = S1_WAIT_FOR_XFER_DONE;

                    end else begin  //if (!valid && ready_xfer) begin
                        xfer_cycles_next = 0;
                        ready_xfer_next = 1'b0;
                    end
                end

                S1_WAIT_FOR_XFER_DONE: begin
                    rx_data_next = {24'b0, spi_buf};
                    ready_xfer_next = 1'b1;
                    next_state = S0_IDLE;
                end

                default: next_state = S0_IDLE;
            endcase

        end

    end

    reg [SPI_FREQ_BIT_WIDTH -1:0] tick_cnt;
    wire tick = tick_cnt == (CYCLES_TO_TICK - 1);
    always @(posedge clk) begin
        if (!resetn) begin
            tick_cnt <= 0;
        end else begin
            if (tick || xfer_cycles == 0) begin
                tick_cnt <= 0;
            end else begin
                if (|xfer_cycles) tick_cnt <= tick_cnt + 1;
            end
        end
    end

endmodule
