/*
 *  m12l64322a_ctrl - A sdram controller
 *
 *  Copyright (C) 2022/2023  Hirosh Dabui <hirosh@dabui.de>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */
`timescale 1ns / 1ps
`ifndef SYNTHESES
`default_nettype none
`endif

// ugly hack
// I originally wrote this for the Colorlight i9, and now I've adapted it for the Tang Nano 20K.
module m12l64322a_ctrl #(
    parameter SDRAM_CLK_FREQ = 64
) (
    input wire clk,
    input wire resetn,

    input wire [20:0] addr,
    input wire [31:0] din,
    input wire [3:0] wmask,
    input wire valid,
    output reg [31:0] dout,
    output reg ready,

    output wire sdram_clk,
    output wire sdram_cke,
    output wire [3:0] sdram_dqm,
    output wire [10:0] sdram_addr,  //  A0-A10 row address, A0-A7 column address
    output wire [1:0] sdram_ba,  // bank select A11,A12
    output wire sdram_csn,
    output wire sdram_wen,
    output wire sdram_rasn,
    output wire sdram_casn,
    inout wire [31:0] sdram_dq
);

  localparam BURST_LENGTH = 3'b000,  // 000=1, 001=2, 010=4, 011=8
  ACCESS_TYPE = 1'b0,  // 0=sequential, 1=interleaved
  CAS_LATENCY = 3'd2,  // 2/3 allowed, tRCD=20ns -> 3 cycles@128MHz
  OP_MODE = 2'b00,  // only 00 (standard operation) allowed
  NO_WRITE_BURST = 1'b1;  // 0= write burst enabled, 1=only single access write

  localparam sdram_mode = {1'b0, NO_WRITE_BURST, OP_MODE, CAS_LATENCY, ACCESS_TYPE, BURST_LENGTH};

  reg [3:0] command;
  reg cke;
  reg [3:0] dqm;
  reg [10:0] saddr;
  reg [1:0] ba;  // this is a11

  assign sdram_clk = clk;
  assign sdram_cke = cke;
  assign sdram_addr = saddr;
  assign sdram_dqm = dqm;
  assign {sdram_csn, sdram_rasn, sdram_casn, sdram_wen} = command;
  assign sdram_ba = ba;

  wire [31:0] dout_dqm;
  assign sdram_dq = (state == COL_WRITE_WRITE1) ? dout_dqm : 32'hZ;

  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin
      assign dout_dqm[i*8+7:i*8] = !wmask[i] ? dout[i*8+7:i*8] : din[i*8+7:i*8];
    end
  endgenerate

  // ISSI-IS425 datasheet page 16
  localparam
  // (CS,RAS,CAS,WE)
  MRS = 4'b0000,  // mode register set
  ACT = 4'b0011,  // bank active
  READ = 4'b0101,  // to have read variant with autoprecharge set A10=H
  WRITE = 4'b0100,  // A10=H to have autoprecharge
  BST = 4'b0110,  // burst stop
  PRE = 4'b0010,  // precharge selected bank, A10=H both banks
  REF = 4'b0001,  // auto refresh (cke=H), selfrefresh assign cke=L
  NOP = 4'b0111, DSEL = 4'b1xxx;

  localparam WAIT_100US = 100 * SDRAM_CLK_FREQ,  // 64 * 1/64e6 = 1us => 100 * 1us
  // command period, PRE to ACT in ns, e.g. 20ns
  TRP = $rtoi(
      (20 * (SDRAM_CLK_FREQ) / 1000) + 1
  ),
  // tRC command period (REF to REF/ACT TO ACT) in ns
  TRC = $rtoi(
      (66 * (SDRAM_CLK_FREQ) / 1000) + 1
  ),  //
  // tRCD active command to read/write command delay, row-col-delay in ns
  TRCD = $rtoi(
      (20 * (SDRAM_CLK_FREQ) / 1000) + 1
  ),
  // tCH command hold time
  TCH = 1;

  initial begin
    $display("Clk frequence: %d MHz", SDRAM_CLK_FREQ);
    $display("WAIT_100US: %d cycles", WAIT_100US);
    $display("TRP: %d cycles", TRP);
    $display("TRC: %d cycles", TRC);
    $display("TRCD: %d cycles", TRCD);
    $display("TCH: %d cycles", TCH);
    $display("CAS_LATENCY: %d cycles", CAS_LATENCY);
  end

  localparam
    RESET                   = 5'd0,
    INIT_SEQ_PRE_CHARGE_ALL = 5'd1,
    INIT_SEQ_AUTO_REFRESH0  = 5'd2,
    INIT_SEQ_AUTO_REFRESH1  = 5'd3,
    INIT_SEQ_LOAD_MODE      = 5'd4,
    IDLE                    = 5'd5,
    COL_READ                = 5'd6,
    CAS_LATENCY_READ_DONE   = 5'd7,
    COL_WRITE               = 5'd8,
    AUTO_REFRESH            = 5'd9,
    PRE_CHARGE_ALL          = 5'd10,
    WAIT_STATES             = 5'd11,
    COL_WRITE_READ          = 5'd12,
    COL_WRITE_WRITE0        = 5'd13,
    COL_WRITE_WRITE1        = 5'd14,
    CAS_LATENCY_WRITE_READ_DONE = 5'd15
    ;

  reg [4:0] state;
  reg [4:0] return_state;
  reg [13:0] wait_states;
  reg update_ready;

  always @(posedge clk) begin

    if (!resetn) begin
      state <= RESET;
      ready <= 1'b0;
      update_ready <= 0;
    end else begin
      case (state)

        RESET: begin
          cke          <= 1'b0;

          saddr        <= 0;
          wait_states  <= WAIT_100US;
          state        <= WAIT_STATES;
          return_state <= INIT_SEQ_PRE_CHARGE_ALL;
        end

        INIT_SEQ_PRE_CHARGE_ALL: begin
          cke          <= 1'b1;
          command      <= PRE;

          saddr[10]    <= 1'b1;  // select all banks
          wait_states  <= TRP;
          state        <= WAIT_STATES;
          return_state <= INIT_SEQ_AUTO_REFRESH0;
        end

        INIT_SEQ_AUTO_REFRESH0: begin
          command <= REF;

          saddr <= 0;
          wait_states <= TRC;
          state <= WAIT_STATES;
          return_state <= INIT_SEQ_AUTO_REFRESH1;
        end

        INIT_SEQ_AUTO_REFRESH1: begin
          command <= REF;

          saddr <= 0;
          wait_states <= TRC;
          state <= WAIT_STATES;
          return_state <= INIT_SEQ_LOAD_MODE;
        end

        INIT_SEQ_LOAD_MODE: begin
          command <= MRS;

          saddr <= sdram_mode;
          wait_states <= TCH;
          state <= WAIT_STATES;

          return_state <= IDLE;
        end

        IDLE: begin
          dqm   <= 4'b1111;

          ready <= 1'b0;

          if (valid) begin
            command      <= ACT;

            saddr        <= addr[18:8];
            ba           <= addr[20:19];

            wait_states  <= TRCD;
            state        <= WAIT_STATES;
            //      return_state <= |wmask ? COL_WRITE : COL_READ;
            //return_state <= |wmask ? COL_WRITE_READ : COL_READ;
            //return_state <= |wmask ? COL_WRITE_READ : COL_READ;
            return_state <= |wmask ? COL_WRITE_WRITE0 : COL_READ; // we don't need read before write

          end else begin
            /* autorefresh */
            command <= REF;
            saddr <= 0;
            ba <= 0;
            wait_states <= TRC;
            state <= WAIT_STATES;

            return_state <= IDLE;
          end

        end

        COL_WRITE_READ: begin
          command      <= READ;
          dqm          <= 4'b0000;
          saddr        <= {3'b100, addr[7:0]};  // autoprecharge and column
          ba           <= addr[20:19];
          wait_states  <= CAS_LATENCY;
          state        <= WAIT_STATES;

          return_state <= CAS_LATENCY_WRITE_READ_DONE;
        end

        CAS_LATENCY_WRITE_READ_DONE: begin
          command      <= NOP;
          dqm          <= 4'b1111;
          dout         <= sdram_dq;
          saddr        <= 0;
          ba           <= 0;
          wait_states  <= TRP;
          state        <= WAIT_STATES;

          return_state <= COL_WRITE_WRITE0;
        end

        COL_WRITE_WRITE0: begin
          command      <= ACT;

          saddr        <= addr[18:8];
          ba           <= addr[20:19];

          wait_states  <= TRCD;
          state        <= WAIT_STATES;
          return_state <= COL_WRITE_WRITE1;
        end

        COL_WRITE_WRITE1: begin
          command      <= WRITE;
          dqm          <= ~wmask;
          saddr        <= {3'b100, addr[7:0]};  // autoprecharge and column
          ba           <= addr[20:19];
          wait_states  <= TRP;
          state        <= WAIT_STATES;

          update_ready <= 1'b1;
          return_state <= IDLE;
        end

        COL_READ: begin
          command      <= READ;
          dqm          <= 4'b0000;
          saddr        <= {3'b100, addr[7:0]};  // autoprecharge and column
          ba           <= addr[20:19];
          wait_states  <= CAS_LATENCY;
          state        <= WAIT_STATES;

          return_state <= CAS_LATENCY_READ_DONE;
        end

        CAS_LATENCY_READ_DONE: begin
          command      <= NOP;
          dqm          <= 4'b1111;
          dout         <= sdram_dq;
          saddr        <= 0;
          ba           <= 0;
          wait_states  <= TRP;
          state        <= WAIT_STATES;

          update_ready <= 1'b1;
          return_state <= IDLE;
        end

        COL_WRITE: begin
          command      <= WRITE;
          dqm          <= ~wmask;
          saddr        <= {3'b100, addr[7:0]};  // autoprecharge and column
          ba           <= addr[20:19];
          wait_states  <= TRP;
          state        <= WAIT_STATES;

          update_ready <= 1'b1;
          return_state <= IDLE;
        end

        PRE_CHARGE_ALL: begin
          command <= PRE;
          saddr[10] <= 1'b1;  // select all banks
          ba <= 0;
          wait_states <= TRP;
          state <= WAIT_STATES;

          return_state <= IDLE;
        end

        WAIT_STATES: begin
          command <= NOP;
          saddr   <= 0;

          if (wait_states == 1) begin
            if (return_state == IDLE && update_ready) begin
              update_ready <= 1'b0;
              ready <= 1'b1;
            end
            state <= return_state;
            wait_states <= 0;
          end else begin
            wait_states <= wait_states - 1;
          end
        end

        default: begin
          state <= RESET;
        end

      endcase

    end  /* resetn */

  end


endmodule
