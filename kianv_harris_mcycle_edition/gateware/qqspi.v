/*
 * QQSPI
 * Copyright (c) 2021 Lone Dynamics Corporation. All rights reserved.
 *
 * Verilog module for interfacing the LD-QQSPI-PSRAM32 Pmod(tm) compatible
 * module with ICE40 FPGAs.
 *
 *  Copyright (c) 2022 hirosh dabui <hirosh@dabui.de>
 *  added address mode via wstrb
 */
`timescale 1 ns/100 ps
`default_nettype none
module qqspi #(
        parameter [0:0] QUAD_MODE = 1
    )(

        input wire [24:0] addr,
        output reg [31:0] rdata,
        input wire [31:0] wdata,
        input wire [ 3:0] wstrb,
        output reg ready,
        input wire valid,
        input wire clk,
        input wire resetn,

        output reg ss,
        output reg sclk,
        inout wire mosi,
        inout wire miso,
        inout wire sio2,
        inout wire sio3,
        output reg [1:0] cs,
        output reg [2:0] state

    );

    reg  [3:0] sio_oe;
    reg  [3:0] sio_do;
    wire [3:0] sio_di;


    assign mosi = sio_oe[0] ? sio_do[0] : 1'bz;
    assign miso = sio_oe[1] ? sio_do[1] : 1'bz;
    assign sio2 = sio_oe[2] ? sio_do[2] : 1'bz;
    assign sio3 = sio_oe[3] ? sio_do[3] : 1'bz;

    assign sio_di = {sio3, sio2, miso, mosi};
    wire write = |wstrb;

    reg [1:0] offset;
    reg [5:0] xfer_wr_cycles;
    reg [31:0] write_buffer;
    always @(*) begin
        write_buffer = 'h x;
        case (wstrb)
            4'b 0001: begin
                offset = 3;
                write_buffer[31:24] = wdata[7:0];
                xfer_wr_cycles = 8;
            end
            4'b 0010: begin
                offset = 2;
                write_buffer[31:24] = wdata[15:8];
                xfer_wr_cycles = 8;
            end
            4'b 0100: begin
                offset = 1;
                write_buffer[31:24] = wdata[23:16];
                xfer_wr_cycles = 8;
            end
            4'b 1000: begin
                offset = 0;
                write_buffer[31:24] = wdata[31:24];
                xfer_wr_cycles = 8;
            end
            4'b 0011: begin
                offset = 2;
                write_buffer[31:16] = wdata[15:0];
                xfer_wr_cycles = 16;
            end
            4'b 1100: begin
                offset = 0;
                write_buffer[31:16] = wdata[31:16];
                xfer_wr_cycles = 16;
            end
            4'b 1111: begin
                offset = 0;
                write_buffer = wdata;
                xfer_wr_cycles = 32;
            end
            default:
            begin
                offset = 0;
                write_buffer = wdata;
                xfer_wr_cycles = 32;
            end
        endcase
    end

    localparam [2:0]
               STATE_IDLE			= 3'd0,
               STATE_INIT			= 3'd1,
               STATE_START	  = 3'd2,
               STATE_CMD			= 3'd3,
               STATE_ADDR			= 3'd4,
               STATE_WAIT			= 3'd5,
               STATE_XFER			= 3'd6,
               STATE_END			= 3'd7;

    reg [31:0] buffer;
    reg [5:0] xfer_bits;
    reg xfer_quad;

    always @(posedge clk) begin


        if (!resetn) begin

            cs <= 2'b00;
            ss <= 1;
            sclk <= 0;
            sio_oe <= 4'b1111;
            sio_do <= 4'b0000;

            buffer    <= 0;
            xfer_quad <= 0;
            xfer_bits <= 0;
            ready <= 0;

            state <= STATE_IDLE;

        end else if (valid && !ready && state == STATE_IDLE) begin

            state <= STATE_INIT;
            xfer_bits <= 0;

        end else if (!valid && ready) begin

            ready <= 0;

        end else if (|xfer_bits) begin

            if (xfer_quad) begin
                sio_do[3:0] <= buffer[31:28];
            end else begin
                sio_do[0]   <= buffer[31];
            end

            if (sclk) begin
                sclk <= 0;
            end else begin
                sclk <= 1;
                if (xfer_quad) begin
                    buffer <= {buffer[27:0], sio_di[3:0]};
                    xfer_bits <= xfer_bits - 4;
                end else begin
                    buffer <= {buffer[30:0], sio_di[1]};
                    xfer_bits <= xfer_bits - 1;
                end
            end

        end else case (state)

            STATE_IDLE: begin
                ss <= 1;
            end

            STATE_INIT: begin
                sio_oe <= 4'b0001;
                cs[1:0] <= addr[22:21];
                state <= STATE_START;
            end

            STATE_START: begin
                ss <= 0;
                state <= STATE_CMD;
            end

            STATE_CMD: begin
                if (QUAD_MODE)
                        if (write) buffer[31:24] <= 8'h38; else buffer[31:24] <= 8'heb;
                else
                        if (write) buffer[31:24] <= 8'h02; else buffer[31:24] <= 8'h03;
                xfer_bits <= 8;
                xfer_quad <= 0;
                state <= STATE_ADDR;
            end

            STATE_ADDR: begin
                buffer[31:8] <= { 1'b0, {addr[20:0], write ? offset : 2'b 00} };

                sio_oe <= 4'b1111;
                xfer_bits <= 24;
                if (QUAD_MODE)
                    xfer_quad <= 1;
                if (QUAD_MODE && !write)
                    state <= STATE_WAIT;
                else
                    state <= STATE_XFER;
            end

            STATE_WAIT: begin
                sio_oe <= 4'b0000;
                xfer_bits <= 6;
                xfer_quad <= 0;
                state <= STATE_XFER;
            end

            STATE_XFER: begin
                if (QUAD_MODE)
                    xfer_quad <= 1;
                if (write) begin
                    sio_oe <= 4'b1111;
                    buffer <= write_buffer;
                end else begin
                    sio_oe <= 4'b0000;
                end
                xfer_bits <= write ? xfer_wr_cycles : 32;
                state <= STATE_END;
            end

            STATE_END: begin
                if (write)
                    ss <= 1;
                else
                    rdata <= buffer;
                ready <= 1;
                state <= STATE_IDLE;
            end

        endcase
    end

endmodule
