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
`define SYSTEM_CLK 50_000_000
module top_tb;
  localparam PERIOD_NS = $rtoi(1.0 / `SYSTEM_CLK * 10 ** 9);

  localparam DISABLE_WAVE = 0;
  localparam DUMP_REGFILE = 1;

  //logic resetn;

  logic clk_1x_s = 1'b0;

  /* verilator lint_off STMTDLY */
  always #(PERIOD_NS / 2) clk_1x_s = !clk_1x_s;
  logic clk;
  assign clk = clk_1x_s;
  top top_i (
      .clk   (clk)//,
//      .resetn(resetn)
  );

  initial begin
    $dumpfile("iwave.vcd");
    $dumpvars(0, top_tb);
    if (DUMP_REGFILE) begin
    for (int i = 0; i < $size(top_i.cpu_i.datapath_unit_i.register_file32_i.bank0); i++) begin                                                                                                                         
      $dumpvars(0, top_i.cpu_i.datapath_unit_i.register_file32_i.bank0[i]);
      $dumpvars(0, top_i.cpu_i.datapath_unit_i.register_file32_i.bank1[i]);
    end            
    end
    $dumpon;
//    #000 resetn = 1'b0;
    //repeat (2) @(posedge clk);
 //   #100 resetn = 1'b1;
 //   repeat (1000) @(posedge clk);
//    $finish;
  end

endmodule
