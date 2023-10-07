/*
 *  kianv.v - a simple RISC-V rv32im
 *
 *  copyright (c) 2022 hirosh dabui <hirosh@dabui.de>
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
`timescale 1 ns/100 ps
`default_nettype none
/* verilator lint_on STMTDLY */
module simple_dma
    #(
         parameter DMA_SRC    = 32'h 30_000_02C,
         parameter DMA_DST    = 32'h 30_000_030,
         parameter DMA_LEN    = 32'h 30_000_034,
         parameter DMA_CTRL   = 32'h 30_000_038
     )
     (
         input wire            clk,
         input wire            resetn,

         // dma handshaking
         input  wire [31: 0]   addr,
         input  wire [ 3: 0]   wstrb,
         input  wire [31: 0]   wdata,
         output reg  [31: 0]   rdata,
         input  wire           valid,
         output wire           ready,

         // dma interface
         output reg   [31: 0]  dma_addr,
         output reg   [31: 0]  dma_wdata,
         input  wire  [31: 0]  dma_rdata,
         output reg   [ 3: 0]  dma_wstrb,
         output reg            dma_valid,
         input  wire           dma_ready,
         output reg            dma_active
     );

    reg [ 1: 0] state;
    reg [31: 0] cnt;
    reg [31: 0] saddr;
    reg [31: 0] daddr;
    reg [31: 0] len;
    reg [31: 0] ctrl;


    reg  dma_src_ready;
    wire dma_src_valid  = !dma_src_ready && valid && (addr == DMA_SRC);

    reg  dma_dst_ready;
    wire dma_dst_valid  = !dma_dst_ready && valid && (addr == DMA_DST);

    reg  dma_len_ready;
    wire dma_len_valid  = !dma_len_ready && valid && (addr == DMA_LEN);

    reg  dma_ctrl_ready;
    wire dma_ctrl_valid = !dma_ctrl_ready && valid && (addr == DMA_CTRL);

    reg dma_transfer_done;
    assign ready     = dma_transfer_done || (dma_src_ready | dma_dst_ready | dma_len_ready | dma_ctrl_valid);

    wire [31: 0] src_addr_plus4 = saddr + 4;
    reg  read_setup;
    always @(posedge clk) begin
        if (!resetn) begin
            state             <= 0;
            dma_valid         <= 1'b 0;
            dma_transfer_done <= 1'b 0;
            dma_active        <= 1'b 0;
            read_setup        <= 1'b 0;
        end else begin

            if (dma_src_valid && |wstrb) begin
                saddr <= wdata;
            end else begin
                rdata <= saddr;
            end
            dma_src_ready <= !resetn ? 0 : dma_src_valid;

            if (dma_dst_valid && |wstrb) begin
                daddr <= wdata;
            end else begin
                rdata <= daddr;
            end
            dma_dst_ready <= !resetn ? 0 : dma_dst_valid;

            if (dma_len_valid && |wstrb) begin
                len <= wdata;
            end else begin
                rdata <= len;
            end
            dma_len_ready <= !resetn ? 0 : dma_len_valid;

            if (dma_ctrl_valid && |wstrb) begin
                ctrl <= wdata;
            end else begin
                rdata <= ctrl;
            end
            dma_ctrl_ready <= !resetn ? 0 : dma_ctrl_valid;

            case (state)
                0: begin : idle
                    dma_transfer_done <= 1'b 0;
                    dma_active        <= 1'b 0;
                    if (valid && !ready) begin
                        case (1'b 1)
                            ctrl[0] : begin
                                dma_active   <= 1'b 1;
                                ctrl[0]      <= 1'b 0;
                                dma_wstrb    <= 4'b 0000;
                                dma_addr     <= saddr;
                                cnt          <= len;
                                dma_valid    <= 1'b 1;
                                state        <= 1;
                            end
                            ctrl[1] : begin
                                dma_active   <= 1'b 1;
                                ctrl[1]      <= 1'b 0;
                                dma_wstrb    <= 4'b 1111;
                                dma_addr     <= saddr;
                                cnt          <= len;
                                dma_wdata    <= daddr; // pattern to write
                                dma_valid    <= 1'b 1;
                                state        <= 3;
                            end
                            default:
                                state <= 0;
                        endcase
                    end
                end
                1: begin : dma_copy_read
                    read_setup <= 1'b 1;
                    if (dma_ready && read_setup) begin
                        dma_wdata  <= dma_rdata;
                        dma_addr   <= daddr;
                        dma_wstrb  <= 4'b 1111;
                        read_setup <= 1'b 0;
                        state      <= 2;
                    end
                end
                2: begin : dma_copy_write
                    if (dma_ready) begin
                        cnt           <= cnt - 1;
                        if (cnt == 1) begin
                            dma_valid         <= 1'b 0;
                            dma_wstrb         <= 4'b 0000;
                            dma_transfer_done <= 1'b 1;
                            state             <= 0;
                        end else begin
                            dma_wstrb <= 4'b 0000;
                            dma_addr  <= src_addr_plus4;
                            saddr     <= src_addr_plus4;
                            daddr     <= daddr + 4;
                            state <= 1;
                        end
                    end
                end
                3: begin
                    if (dma_ready) begin : memset
                        cnt           <= cnt - 1;
                        if (cnt == 1) begin
                            dma_wstrb         <= 4'b 0000;
                            dma_valid         <= 1'b 0;
                            dma_transfer_done <= 1'b 1;
                            state             <= 0;
                        end else begin
                            dma_addr  <= src_addr_plus4;
                            saddr     <= src_addr_plus4;
                            state <= 3;
                        end
                    end
                end
                default:
                    state <= 0;
            endcase

        end
    end
endmodule
