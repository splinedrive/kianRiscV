/*
 *  kianv harris single cycle RISC-V rv32im
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
`default_nettype none `timescale 1 ns / 100 ps
`define UART_TX_ADDR 32'h 30_000_000
`define UART_TX_RDY 32'h 30_000_000
`define SYSTEM_CLK 'd90_000_000
`define UART_BAUDRATE 2_000_000
// you need to GENESYS2 for GENESYS2
// please create a pll clock and adjust the defines above
//`define GENESYS2 
module top (
`ifdef GENESYS2
    input wire logic clk200mhz_p,
    input wire logic clk200mhz_n,
    output wire logic [0:0] led,
`else
    input wire logic clk,
`endif
    output wire uart_tx
);

`ifdef GENESYS2
  logic clk;
  clk_wiz_0 clk_i (
      // Clock out ports
      .clk_out1(clk),     // output clk_out1
      // Clock in ports
      .clk_in1_p(clk200mhz_p),    // input clk_in1_p
      .clk_in1_n(clk200mhz_n)
  );  // input clk_in1_n
`endif

  logic [ 3:0] dmem_wmask;
  logic [31:0] dmem_addr;
  logic [31:0] dmem_wdata;
  logic [31:0] dmem_rdata;

  logic [31:0] imem_addr;
  logic [31:0] imem_data;

  localparam IMEM_SIZE = ('h8_000);
  localparam DMEM_SIZE = ('h8_000);

  logic resetn;
  logic [8:0] rst_cnt = 0;
  always @(posedge clk) begin
    if (!rst_cnt[8]) rst_cnt <= rst_cnt + 1;
  end

  assign resetn = rst_cnt[8];

  //`define UNITTEST
`ifdef UNITTEST
  unittest unittest_i (
      .clk       (clk),
      .resetn    (resetn),
      .dmem_addr (dmem_addr),
      .dmem_wmask(dmem_wmask),
      .dmem_wdata(dmem_wdata)
  );
`endif

`define PSEUDO_HAVARD
`ifdef PSEUDO_HAVARD
  pseudo_havard #(
 //     .DEPTH('h800),
    .DEPTH(9000),
      .FILE ("./firmware/firmware.hex")
  ) pseudo_havard_i (
      .clk  (clk),
      .wmask(dmem_wmask),
      .wdata(dmem_wdata),
      .daddr(dmem_addr[31:2]),
      .rdata(dmem_rdata),
      .iaddr(imem_addr[31:2]),
      .idata(imem_data)
  );
`else
  imem32 #(
      .DEPTH(IMEM_SIZE),
      //      .FILE ("imem.hex")
      .FILE ("./firmware/firmware.hex")
  ) imem_i (
      .addr(imem_addr[31:2]),
      .data(imem_data)
  );

  dmem32 #(
      .DEPTH(DMEM_SIZE),
      //   .FILE ("dmem.hex")
      .FILE ("./firmware/firmware.hex")
      //     .FILE ("")
  ) dmem32_i (
      .clk  (clk),
      .wmask(dmem_wmask),
      .wdata(dmem_wdata),
      .addr (dmem_addr[31:2]),
      .rdata(dmem_rdata)
  );
`endif

  //
  // UART
  logic uart_tx_valid_wr;
  logic uart_tx_valid_rd;
  logic uart_tx_valid;

  assign uart_tx_valid = (dmem_addr === `UART_TX_ADDR);
  assign uart_tx_valid_wr = (|dmem_wmask) && uart_tx_valid;
  assign uart_tx_valid_rd = !(|dmem_wmask) && uart_tx_valid;

  logic uart_tx_rdy;
  logic uart_tx_busy;

  tx_uart #(
      .SYSTEM_CLK(`SYSTEM_CLK),
      .BAUDRATE  (`UART_BAUDRATE)
  ) tx_uart_i (
      .clk    (clk),
      .resetn (resetn),
      .valid  (uart_tx_valid_wr),
      .tx_data(dmem_wdata[7:0]),
      .tx_out (uart_tx),
      .ready  (uart_tx_rdy)
  );

  always_ff @(posedge clk) begin
    if (!resetn) begin
      uart_tx_busy <= 0;
    end else begin
      case (1'b1)
        (!uart_tx_busy && uart_tx_valid_wr): uart_tx_busy <= 1'b1;
        (uart_tx_busy && uart_tx_rdy): uart_tx_busy <= 1'b0;
      endcase
    end
  end

  kianv_harris_sc_edition cpu_i (
      .clk      (clk),
      .resetn   (resetn),
      .PC       (imem_addr),
      .Instr    (imem_data),
      .WriteMask(dmem_wmask),
      .AluResult(dmem_addr),
      .WriteData(dmem_wdata),
      //      .ReadData (uart_tx_rdy ? ~0 : dmem_rdata)
      .ReadData (uart_tx_valid_rd ? {32{~uart_tx_busy}} : dmem_rdata)
  );

  initial begin
    //    $monitor("%x:%x\n", imem_addr, imem_data);
  end
endmodule
