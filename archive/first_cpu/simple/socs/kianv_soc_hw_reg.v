/*
 *  kianv.v - a simple RISC-V rv32im
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
 `default_nettype none
 `timescale 1ns/1ps
`ifndef KIANV_SOC_HW_REG
`define KIANV_SOC_HW_REG

localparam UART_TX           = 32'h 30_000_000;
localparam UART_READY        = 32'h 30_000_000;
localparam VIDEOENABLE       = 32'h 30_000_008;
localparam VIDEO             = 32'h 30_000_008;
localparam VIDEO_RAW         = 32'h 30_000_00C;
localparam CPU_FREQ_REG      = 32'h 30_000_010;
localparam GPIO_DIR          = 32'h 30_000_014;
localparam GPIO_PULLUP       = 32'h 30_000_018;
localparam GPIO_OUTPUT       = 32'h 30_000_01C;
localparam GPIO_INPUT        = 32'h 30_000_020;

`endif  // KIANV_SOC_HW_REG
