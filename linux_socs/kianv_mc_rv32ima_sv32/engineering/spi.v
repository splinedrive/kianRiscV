/*
 *  kianv.v - RISC-V rv32ima
 *
 *  copyright (c) 2023/2025 hirosh dabui <hirosh@dabui.de>
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

`default_nettype none

module spi #(
    parameter CPOL = 1'b0
) (
    input  wire        clk,
    input  wire        resetn,

    // Bus interface
    input  wire        ctrl,   // 0: control/status, 1: data
    output wire [31:0] rdata,
    input  wire [31:0] wdata,
    input  wire [3:0]  wstrb,
    input  wire [15:0] div,
    input  wire        valid,
    output reg         ready,   // 1-cycle ready pulse

    // SPI signals
    output wire        cen,     // chip enable (active low)
    output reg         sclk,
    output reg         mosi,
    input  wire        miso
);

  // ------------------------------------------------------------
  // Internal registers and state
  // ------------------------------------------------------------
  reg [5:0]  xfer_cycles;
  reg [31:0] rx_data;
  reg        spi_cen;
  reg [7:0]  spi_buf;
  reg [0:0]  state;
  reg [17:0] tick_cnt;

  localparam S_IDLE = 1'b0;
  localparam S_XFER = 1'b1;

  wire in_xfer = |xfer_cycles;
  wire tick = tick_cnt == ({2'b0, div} - 1);

  // ------------------------------------------------------------
  // Readback register value
  // ------------------------------------------------------------
  assign rdata = ctrl ? rx_data : {in_xfer, 30'b0, spi_cen};
  assign cen   = spi_cen;

  // ------------------------------------------------------------
  // Combinational access detection
  // ------------------------------------------------------------
  wire ctrl_access = valid && !ctrl;               // always allowed
  wire data_write  = valid && ctrl && wstrb[0] && !in_xfer;
  wire data_read   = valid && ctrl && !wstrb[0];
  wire accept      = ctrl_access || data_write || data_read;

  // ------------------------------------------------------------
  // Sequential logic
  // ------------------------------------------------------------
  always @(posedge clk) begin
    if (!resetn) begin
      sclk        <= CPOL;
      mosi        <= 1'b0;
      spi_buf     <= 8'b0;
      xfer_cycles <= 0;
      rx_data     <= 0;
      spi_cen     <= 1'b1;
      state       <= S_IDLE;
      tick_cnt    <= 0;
      ready       <= 1'b0;
    end else begin
      //----------------------------------------------------------
      // 1-cycle READY pulse after any accepted access
      //----------------------------------------------------------
      ready <= accept;

      //----------------------------------------------------------
      // Handle control register access (always allowed)
      //----------------------------------------------------------
      if (ctrl_access && wstrb[0])
        spi_cen <= ~wdata[0];   // toggle chip select

      //----------------------------------------------------------
      // Handle data register write (only when SPI idle)
      //----------------------------------------------------------
      if (data_write) begin
        spi_buf     <= wdata[7:0];
        xfer_cycles <= 8;
        state       <= S_XFER;
        mosi        <= wdata[7];   // output MSB first
      end

      //----------------------------------------------------------
      // SPI transfer logic
      //----------------------------------------------------------
      case (state)
        S_IDLE: begin
          sclk <= CPOL;
        end

        S_XFER: begin
          if (in_xfer && (tick || div == 0)) begin
            sclk <= ~sclk;
            if (!sclk) begin
              // Falling edge: sample MISO and shift left
              spi_buf     <= {spi_buf[6:0], miso};
              xfer_cycles <= xfer_cycles - 1;
            end else begin
              // Rising edge: update MOSI with next bit
              mosi <= spi_buf[7];
            end
          end else if (!in_xfer) begin
            rx_data <= {24'b0, spi_buf};
            state   <= S_IDLE;
            mosi    <= 1'b0; // idle state
          end
        end
      endcase

      //----------------------------------------------------------
      // SPI clock divider
      //----------------------------------------------------------
      if (!resetn || tick || !in_xfer)
        tick_cnt <= 0;
      else if (in_xfer)
        tick_cnt <= tick_cnt + 1;
    end
  end

endmodule

