/*
 *  kianv harris multicycle RISC-V rv32ima
 *  Interrupt Controller
 *
 *  copyright (c) 2023/25 hirosh dabui <hirosh@dabui.de>
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
`include "riscv_defines.vh"

/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */

module interrupt_controller (
    input  wire        clk,
    input  wire        resetn,

    input  wire        IRQ3,
    input  wire        IRQ7,
    input  wire        IRQ9,
    input  wire        IRQ11,

    input  wire [31:0] mie,
    input  wire [31:0] mip_current,
    input  wire [31:0] mideleg,
    input  wire [31:0] mstatus,
    input  wire [1:0]  privilege_mode,
    input  wire [63:0] timer_counter,
    input  wire [31:0] stimecmp,
    input  wire [31:0] stimecmph,
    input  wire [31:0] menvcfgh,
    input  wire [31:0] mcounteren,

    output reg  [31:0] mip_next,

    output reg         IRQ_TO_CPU_CTRL1,   // SSIP
    output reg         IRQ_TO_CPU_CTRL3,   // MSIP
    output reg         IRQ_TO_CPU_CTRL5,   // STIP
    output reg         IRQ_TO_CPU_CTRL7,   // MTIP
    output reg         IRQ_TO_CPU_CTRL9,   // SEIP
    output reg         IRQ_TO_CPU_CTRL11   // MEIP
);

  reg [31:0] temp_mip;
  reg [31:0] pending_irqs;
  reg        m_enabled;
  reg        s_enabled;
  reg [31:0] m_interrupts;
  reg [31:0] s_interrupts;
  reg [31:0] interrupts;

  always @(*) begin
    /* verilator lint_off WIDTHTRUNC */
    /* verilator lint_off WIDTHEXPAND */
    temp_mip = mip_current & ~(`MIP_MTIP_MASK | `MIP_MEIP_MASK | `XIP_SEIP_MASK |
               (`CHECK_SSTC_CONDITIONS(menvcfgh, mcounteren) << `XIP_STIP_BIT));

    mip_next = temp_mip |
               `SET_MIP_MSIP(IRQ3) |
               `SET_XIP_STIP(`CHECK_SSTC_TM_AND_CMP(timer_counter, stimecmph, stimecmp, menvcfgh, mcounteren)) |
               `SET_MIP_MTIP(IRQ7) |
               `SET_MIP_MEIP(IRQ11) |
               `SET_XIP_SEIP(IRQ9);
    /* verilator lint_on WIDTHTRUNC */
    /* verilator lint_on WIDTHEXPAND */
  end

  // Interrupt priority and delegation logic
  always @(*) begin
    /* verilator lint_off WIDTHTRUNC */
    /* verilator lint_off WIDTHEXPAND */
    pending_irqs = mip_next & mie;
    m_enabled = (!`IS_MACHINE(privilege_mode)) ||
                (`IS_MACHINE(privilege_mode) && `GET_MSTATUS_MIE(mstatus));
    s_enabled = `IS_USER(privilege_mode) ||
                (`IS_SUPERVISOR(privilege_mode) && `GET_XSTATUS_SIE(mstatus));
    m_interrupts = pending_irqs & (~mideleg) & ({32{m_enabled}});
    s_interrupts = pending_irqs & (mideleg) & ({32{s_enabled}});
    interrupts = (|m_interrupts) ? m_interrupts : s_interrupts;

    IRQ_TO_CPU_CTRL1  = `GET_XIP_SSIP(interrupts);
    IRQ_TO_CPU_CTRL3  = `GET_MIP_MSIP(interrupts);
    IRQ_TO_CPU_CTRL5  = `GET_XIP_STIP(interrupts);
    IRQ_TO_CPU_CTRL7  = `GET_MIP_MTIP(interrupts);
    IRQ_TO_CPU_CTRL9  = `GET_XIP_SEIP(interrupts);
    IRQ_TO_CPU_CTRL11 = `GET_MIP_MEIP(interrupts);
    /* verilator lint_on WIDTHTRUNC */
    /* verilator lint_on WIDTHEXPAND */
  end

endmodule
