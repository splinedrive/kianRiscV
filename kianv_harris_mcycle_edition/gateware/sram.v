/*
 *  kianv.v - a simple RISC-V rv32im
 *
 *  copyright (c) 2021 hirosh dabui <hirosh@dabui.de>
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
`timescale 1ns/1ps
`default_nettype none
module sram(
        input  wire         clk,
        input  wire         resetn,
        output wire         ready,
        /* external interface */
        output wire [18:0]     sram_addr,
        input  wire [15:0]     sram_data_in,
        output wire [15:0]     sram_data_out,
        output wire            sram_cen,
        output wire            sram_oen,
        output wire            sram_wen,
        output wire            sram_lbn,
        output wire            sram_ubn,
        /* internal interface */
        input  wire        raw_mode16, /* 16 bit one cycle */
        input  wire [17:0] addr,
        input  wire        cen,
        input  wire        oen,
        input  wire        wen,
        input  wire [3:0]  wmask,
        output wire [31:0] dout, /* read from sram */
        input  wire [31:0] din   /* write to sram */
    );
    reg [18:0]     sram_addr_r;
    reg [15:0]     sram_data_out_r;
    reg            sram_cen_r;
    reg            sram_oen_r;
    reg            sram_wen_r;
    reg            sram_lbn_r;
    reg            sram_ubn_r;
    reg            ready_r;

`ifdef SIM
    reg [7:0] sim_sram_data0 [0: 256*1024 -1];
    reg [7:0] sim_sram_data1 [0: 256*1024 -1];
    reg [7:0] sim_sram_data2 [0: 256*1024 -1];
    reg [7:0] sim_sram_data3 [0: 256*1024 -1];

    integer i;
    initial begin
        for (i = 0; i < 256*1024; i = i + 1) begin
            sim_sram_data0[i] = 0;
            sim_sram_data1[i] = 0;
            sim_sram_data2[i] = 0;
            sim_sram_data3[i] = 0;
        end
    end


    reg [31:0] sram_data_in_sim = 0;
    always @(cen or oen or wen) begin
        if (raw_mode16) begin
            if (cen) begin
                if (wen) begin
                    sim_sram_data0[addr] = din[7 :0];
                    sim_sram_data1[addr] = din[15:8];
                end
                if (oen) begin
                    sram_data_in_sim[7 :0] = sim_sram_data0[addr];
                    sram_data_in_sim[15:8] = sim_sram_data1[addr];
                end
            end
        end
    end
`endif

`ifdef SIM
    assign dout             = ~raw_mode16 ? dout_r               : {{16{1'b0}}, sram_data_in_sim};
`else
    assign dout             = ~raw_mode16 ? dout_r               : {{16{1'b0}}, sram_data_in};
`endif

    assign sram_addr        = ~raw_mode16 ? sram_addr_r          : addr;
    assign sram_data_out    = ~raw_mode16 ? sram_data_out_r      : din[15:0];
    assign sram_cen         = ~raw_mode16 ? sram_cen_r           : 1'b0;
    assign sram_oen         = ~raw_mode16 ? sram_oen_r           : ~(oen & ~clk);
    assign sram_wen         = ~raw_mode16 ? sram_wen_r           : ~(wen & ~clk);
    assign sram_lbn         = ~raw_mode16 ? sram_lbn_r           : ~(wmask[0]);
    assign sram_ubn         = ~raw_mode16 ? sram_ubn_r           : ~(wmask[1]);
    assign ready            = ~raw_mode16 ? ready_r              : 1'b1;

    reg [ 1: 0]  state;
    reg [ 1: 0]  oen_r;
    reg [ 1: 0]  wen_r;
    reg [31: 0] dout_r;

    always @(posedge clk) begin
        if (!resetn) begin
            state           <= 1'b0;
            ready_r         <= 1'b0;
            sram_cen_r      <= 1'b1;
            sram_oen_r      <= 1'b1;
            sram_wen_r      <= 1'b1;
            sram_lbn_r      <= 1'b1;
            sram_ubn_r      <= 1'b1;
            sram_addr_r     <= 'hx;
            sram_data_out_r <= 'hx;
            dout_r          <= 'hx;
            oen_r           <= 1'b0;
            wen_r           <= 1'b0;

        end else begin
            if (~raw_mode16) begin

                oen_r <= {oen_r[0], oen};
                wen_r <= {wen_r[0], wen};

                case (state)
                    0: begin
                        sram_oen_r  <= 1'b1;
                        sram_wen_r  <= 1'b1;
                        sram_lbn_r  <= 1'b1;
                        sram_ubn_r  <= 1'b1;
                        sram_cen_r  <= 1'b1;
                        ready_r     <= 1'b0;
                        (* parallelcase, fullcase *)
                        case (1'b1)
                            /* read sram */
                            cen & oen_r == 2'b01: begin

                                sram_addr_r <= {addr, 1'b0};

                                {sram_ubn_r, sram_lbn_r} <= ~wmask[1:0];
                                {sram_cen_r, sram_oen_r, sram_wen_r} <= 3'b001;

                                state <= 2;
                            end
                            /* write sram */
                            cen & wen_r == 2'b01: begin
                                sram_addr_r <= {addr, 1'b0};
`ifdef SIM
                                if (wmask[0]) sim_sram_data0[{addr, 1'b0}] <= din[ 7 : 0];
                                if (wmask[1]) sim_sram_data1[{addr, 1'b0}] <= din[15 : 8];
`endif
                                sram_data_out_r <= din[15:0];
                                {sram_ubn_r, sram_lbn_r} <= ~wmask[1:0];
                                {sram_cen_r, sram_oen_r, sram_wen_r} <= 3'b010;

                                if (|wmask[3:2]) begin
                                    state <= 1;
                                end else begin
                                    ready_r       <= 1'b1;
                                    state <= 0;
                                end
                            end

                        endcase
                    end

                    /* write */
                    1: begin
                        sram_addr_r[0]  <= 1'b1;
                        {sram_ubn_r, sram_lbn_r} <= ~wmask[3:2];
`ifdef SIM
                        if (wmask[2]) sim_sram_data2[{addr, 1'b1}] <= din[23 :16];
                        if (wmask[3]) sim_sram_data3[{addr, 1'b1}] <= din[31 :24];
`endif
                        sram_data_out_r <= din[31:16];
                        ready_r <= 1'b1;
                        state <= 0;
                    end

                    /////////////////////////////////////////////////////////////////////////////////////////////

                    /* read */
                    2: begin
                        {sram_ubn_r, sram_lbn_r} <= ~wmask[3:2];
`ifdef SIM
                        if (wmask[0]) dout_r[ 7 : 0] <= sim_sram_data0[sram_addr];
                        if (wmask[1]) dout_r[15 : 8] <= sim_sram_data1[sram_addr];
`else
                        dout_r[15:0] <= sram_data_in;
`endif
                        sram_addr_r[0] <= 1'b1;

                        if (|wmask[3:2]) begin
                            state <= 3;
                        end else begin
                            sram_oen_r    <= 1'b1;
                            ready_r       <= 1'b1;
                            state <= 0;
                        end
                    end

                    3: begin
`ifdef SIM
                        if (wmask[2]) dout_r[23 : 16] <= sim_sram_data2[sram_addr];
                        if (wmask[3]) dout_r[31 : 24] <= sim_sram_data3[sram_addr];
`else
                        dout_r[31:16] <= sram_data_in;
`endif
                        sram_oen_r    <= 1'b1;
                        ready_r       <= 1'b1;

                        state <= 0;
                    end

                    default:
                        state <= 0;
                endcase
            end
        end

    end

endmodule
