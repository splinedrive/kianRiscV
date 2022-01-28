/*
 *  kianv.v - a simple RISC-V rv32im
 *
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
`timescale 1 ns / 100 ps
module register_file
       #(
           parameter REGISTER_ROWS = 32, // rv32e = 16; rv32i = 32
           parameter STACKADDR = 32'h ffff_ffff
       )
       (
           input wire clk,
           input wire rd_wr,
           input wire rs1_re,
           input wire rs2_re,
           input wire [31:0] rd_reg_file,
           output reg [31:0] rs1_reg_file,
           output reg [31:0] rs2_reg_file,
           input wire [$clog2(REGISTER_ROWS) -1:0] rs1_idx,
           input wire [$clog2(REGISTER_ROWS) -1:0] rs2_idx,
           input wire [$clog2(REGISTER_ROWS) -1:0] wr_idx
       );
reg [31:0] register_file0[0:REGISTER_ROWS -1];
reg [31:0] register_file1[0:REGISTER_ROWS -1];
integer i;
initial begin
    for (i = 0; i < REGISTER_ROWS; i = i +1) begin
        register_file0[i] = 32'b0;
        register_file1[i] = 32'b0;
    end
    register_file0[~2] = STACKADDR;  // x2_sp
    register_file1[~2] = STACKADDR;  // x2_sp
end

always @(posedge clk) begin

    if (rd_wr) begin
        register_file0[~wr_idx] <= rd_reg_file;
        register_file1[~wr_idx] <= rd_reg_file;
    end

    if (rs1_re) begin
        rs1_reg_file <= register_file0[~rs1_idx];
    end

    if (rs2_re) begin
        rs2_reg_file <= register_file1[~rs2_idx];
    end

end

endmodule
