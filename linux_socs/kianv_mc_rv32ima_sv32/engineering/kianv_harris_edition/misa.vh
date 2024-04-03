/*
 *  kianv.v - RISC-V rv32ima
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
`ifndef MISA_VH
`define MISA_VH

`define MISA_MXL_RV32 2'b01
`define MISA_EXTENSION_A 5'd0
`define MISA_EXTENSION_B 5'd1
`define MISA_EXTENSION_C 5'd2
`define MISA_EXTENSION_D 5'd3
`define MISA_EXTENSION_E 5'd4
`define MISA_EXTENSION_F 5'd5
`define MISA_EXTENSION_G 5'd6
`define MISA_EXTENSION_H 5'd7
`define MISA_EXTENSION_I 5'd8
`define MISA_EXTENSION_J 5'd9
`define MISA_EXTENSION_K 5'd10
`define MISA_EXTENSION_L 5'd11
`define MISA_EXTENSION_M 5'd12
`define MISA_EXTENSION_N 5'd13
`define MISA_EXTENSION_O 5'd14
`define MISA_EXTENSION_P 5'd15
`define MISA_EXTENSION_Q 5'd16
`define MISA_EXTENSION_R 5'd17
`define MISA_EXTENSION_S 5'd18
`define MISA_EXTENSION_T 5'd19
`define MISA_EXTENSION_U 5'd20
`define MISA_EXTENSION_V 5'd21
`define MISA_EXTENSION_W 5'd22
`define MISA_EXTENSION_X 5'd23
`define MISA_EXTENSION_Y 5'd24
`define MISA_EXTENSION_Z 5'd25

`define IS_EXTENSION_SUPPORTED(MXL, Extensions, Ext_To_Check) \
  ((MXL) == `MISA_MXL_RV32) && (((Extensions) >> (Ext_To_Check)) & 1'b1)
`define SET_MISA_VALUE(MXL) (MXL << 30)
`define MISA_EXTENSION_BIT(extension) (1 << extension)

`endif
