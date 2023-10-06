/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2023 hirosh dabui <hirosh@dabui.de>
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

module register_file #(
        parameter REGISTER_DEPTH = 32,  // rv32e = 16; rv32i = 32
        parameter STACKADDR = 32'hffff_ffff
    ) (
        input  wire        clk,
        input  wire        we,
        input  wire [ 4:0] A1,
        input  wire [ 4:0] A2,
        input  wire [ 4:0] A3,
        input  wire [31:0] wd,
        output wire [31:0] rd1,
        output wire [31:0] rd2
    );
    reg [31:0] bank0[0:REGISTER_DEPTH -1];
    integer i;

    localparam X2 = 2;
    initial begin
        bank0[10] = 'h00;  // hartid
        bank0[11] = 32'h80_000_000 + ((1024 * 1024 * 32) - 2048);  // 32'h81fffa00;  // dtb
    end


    always @(posedge clk) begin

        if (we && A3 != 0) begin
            bank0[A3] <= wd;
        end
    end

    assign rd1 = A1 != 0 ? bank0[A1] : 32'b0;
    assign rd2 = A2 != 0 ? bank0[A2] : 32'b0;

endmodule
