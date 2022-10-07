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
module top (
    input wire logic clk200mhz_p,
    input wire logic clk200mhz_n,
    output wire logic [0:0] led,
    input wire logic cpu_resetn
);

  logic [ 3:0] dmem_wmask;
  logic [31:0] dmem_addr;
  logic [31:0] dmem_wdata;
  logic [31:0] dmem_rdata;

  logic [31:0] imem_addr;
  logic [31:0] imem_data;

  localparam IMEM_SIZE = (1024);
  localparam DMEM_SIZE = (1024);

  wire logic resetn = cpu_resetn;
    assign led[0] = imem_addr[3];
  wire clk;
  /*                                                     
  IBUFDS ibufds_i (                                                 
      .O  (clk),                                         
    .I  (clk200mhz_p),                                     
    .IB (clk200mhz_n));
*/
  clk_wiz_0 clk_i
   (
    // Clock out ports
    .clk_out1(clk),     // output clk_out1
   // Clock in ports
    .clk_in1_p(clk200mhz_p),    // input clk_in1_p
    .clk_in1_n(clk200mhz_n));    // input clk_in1_n

    imem32 #(
      .DEPTH(IMEM_SIZE),
      .FILE ("imem.hex")
  ) imem_i (
      .addr({2'b0, imem_addr[31:2]}),
      .data(imem_data)
  );

  dmem32 #(
      .DEPTH(DMEM_SIZE),
      .FILE ("dmem.hex")
  ) dmem32_i (
      .clk  (clk),
      .wmask(dmem_wmask),
      .wdata(dmem_wdata),
      .addr ({2'b0, dmem_addr[31:2]}),
      .rdata(dmem_rdata)
  );

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
endmodule
