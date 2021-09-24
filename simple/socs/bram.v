/*
 *  kianv.v - a simple RISC-V rv32i
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
`define FLASH_EXECUTION
module bram #(
           parameter integer WORDS = 256
       ) (
           input wire clk,
           input wire resetn,
           input wire wr,
           input wire [3:0] wmask,
           input wire rd,
           input wire [$clog2(WORDS) -1:0] addr,
           input wire [31:0] wdata,
           output wire [31:0] rdata
       );
reg [31:0] mem [0:WORDS -1];

integer i;
initial begin
    $display("WORDS:", WORDS);
`ifdef FLASH_EXECUTION
    //    for (i = 0; i < WORDS; i = i + 1) mem[i] = 0;
`else
    $readmemh("firmware.hex", mem);
`endif
end

reg [31:0] out;
always @(posedge clk) begin

    if (!resetn) begin
        out <= 0;
    end  else begin
        if (|wmask) begin
            if (wmask[0]) mem[addr][ 7: 0] <= wdata[ 7: 0];
            if (wmask[1]) mem[addr][15: 8] <= wdata[15: 8];
            if (wmask[2]) mem[addr][23:16] <= wdata[23:16];
            if (wmask[3]) mem[addr][31:24] <= wdata[31:24];
        end
    end

    out <= {mem[addr][31:24], mem[addr][23:16], mem[addr][15:8], mem[addr][7:0]};

end

assign rdata = out;
endmodule
