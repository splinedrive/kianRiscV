/*
 *  kianv harris multicycle RISC-V rv32im
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
`timescale 1 ns/100 ps
`default_nettype none
module eight_seg_display
    (
        input  wire clk,
        input  wire [ 31: 0] number32,
        output wire CA,
        output wire CB,
        output wire CC,
        output wire CD,
        output wire CE,
        output wire CF,
        output wire CG,
        output wire DP,
        output wire [ 7: 0] AN
    );

    reg  [ 20: 0] cycle;
    always @(posedge clk) cycle <= cycle + 1;
    assign DP = 1'b 1;

    reg  [ 3: 0] nibble;
    reg  [ 7: 0] decode3_8;

    assign AN = ~decode3_8;

    always @(*)
    case (cycle[20 -: 3])
        3'b 000  : begin decode3_8 = 8'b 00000001; nibble = number32[ 3: 0]; end
        3'b 001  : begin decode3_8 = 8'b 00000010; nibble = number32[ 7: 4]; end
        3'b 010  : begin decode3_8 = 8'b 00000100; nibble = number32[11: 8]; end
        3'b 011  : begin decode3_8 = 8'b 00001000; nibble = number32[15:12]; end
        3'b 100  : begin decode3_8 = 8'b 00010000; nibble = number32[19:16]; end
        3'b 101  : begin decode3_8 = 8'b 00100000; nibble = number32[23:20]; end
        3'b 110  : begin decode3_8 = 8'b 01000000; nibble = number32[27:24]; end
        3'b 111  : begin decode3_8 = 8'b 10000000; nibble = number32[31:28]; end
    endcase

    seg_decoder seg_decoder_I( nibble, {CG, CF, CE, CD, CC, CB, CA} );
endmodule

module seg_decoder(
        input  wire [ 3: 0] nibble,
        output reg  [ 6: 0] segment
    );

    /* table taken from digilent */
    always @*
    case (nibble)
        4'h 0: segment = 7'b 1000000;
        4'h 1: segment = 7'b 1111001;
        4'h 2: segment = 7'b 0100100;
        4'h 3: segment = 7'b 0110000;
        4'h 4: segment = 7'b 0011001;
        4'h 5: segment = 7'b 0010010;
        4'h 6: segment = 7'b 0000010;
        4'h 7: segment = 7'b 1111000;
        4'h 8: segment = 7'b 0000000;
        4'h 9: segment = 7'b 0011000;
        4'h A: segment = 7'b 0001000;
        4'h B: segment = 7'b 0000011;
        4'h C: segment = 7'b 1000110;
        4'h D: segment = 7'b 0100001;
        4'h E: segment = 7'b 0000110;
        4'h F: segment = 7'b 0001110;
    endcase

endmodule
