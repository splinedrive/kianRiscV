/*
 *  kianv harris single cycle RISC-V rv32i
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
module top (
    input wire logic clk,
    input wire logic resetn,
    output wire uart_tx_out
);

  logic [ 3:0] dmem_wmask;
  logic [31:0] dmem_addr;
  logic [31:0] dmem_wdata;
  logic [31:0] dmem_rdata;

  logic [31:0] imem_addr;
  logic [31:0] imem_data;

  localparam IMEM_SIZE = ('h10_000);
  localparam DMEM_SIZE = ('h10_000);

  `define PSEUDO_HAVARD
`ifdef PSEUDO_HAVARD
  pseudo_havard #(
      .DEPTH('h40_000),
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

  kianv_harris_sc_edition cpu_i (
      .clk      (clk),
      .resetn   (resetn),
      .PC       (imem_addr),
      .Instr    (imem_data),
      .WriteMask(dmem_wmask),
      .AluResult(dmem_addr),
      .WriteData(dmem_wdata),
      .ReadData (dmem_rdata)
  );

  initial begin
    //    $monitor("%x:%x\n", imem_addr, imem_data);
  end
endmodule
