/*
 *  kianv harris multicycle RISC-V rv32ima
 *  CSR Exception Handler Wrapper
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

module csr_exception_handler #(
    parameter SYSTEM_CLK = 50_000_00
) (
    input  wire                      clk,
    input  wire                      resetn,
    input  wire                      incr_inst_retired,
    input  wire [              11:0] CSRAddr,
    input  wire [`CSR_OP_WIDTH -1:0] CSRop,
    input  wire                      we,
    input  wire                      re,
    input  wire [              31:0] Rd1,
    input  wire [               4:0] uimm,
    input  wire                      exception_event,
    input  wire                      mret,
    input  wire                      sret,
    input  wire                      wfi_event,
    input  wire [              31:0] cause,
    input  wire [              31:0] pc,
    input  wire [              31:0] badaddr,
    output wire [              31:0] rdata,
    output wire [              31:0] exception_next_pc,
    output wire                      exception_select,
    output wire [               1:0] privilege_mode,
    output wire                      csr_access_fault,
    output wire [              31:0] mstatus,
    output wire [              63:0] timer_counter  /* verilator public_flat_rw */,
    output wire [              31:0] satp,
    output wire                      tlb_flush,
    input  wire                      IRQ3,
    input  wire                      IRQ7,
    input  wire                      IRQ9,
    input  wire                      IRQ11,
    output wire                      IRQ_TO_CPU_CTRL1,
    output wire                      IRQ_TO_CPU_CTRL3,
    output wire                      IRQ_TO_CPU_CTRL5,
    output wire                      IRQ_TO_CPU_CTRL7,
    output wire                      IRQ_TO_CPU_CTRL9,
    output wire                      IRQ_TO_CPU_CTRL11
);

  // Internal signals connecting CSR unit and interrupt controller
  wire [31:0] mie;
  wire [31:0] mip_current;
  wire [31:0] mideleg;
  wire [31:0] mip_next;
  wire [31:0] menvcfgh;
  wire [31:0] mcounteren;
  wire [31:0] stimecmp;
  wire [31:0] stimecmph;

  // Instantiate CSR Unit
  csr_unit #(
      .SYSTEM_CLK(SYSTEM_CLK)
  ) csr_unit_inst (
      .clk(clk),
      .resetn(resetn),
      .incr_inst_retired(incr_inst_retired),
      .CSRAddr(CSRAddr),
      .CSRop(CSRop),
      .we(we),
      .re(re),
      .Rd1(Rd1),
      .uimm(uimm),
      .exception_event(exception_event),
      .mret(mret),
      .sret(sret),
      .wfi_event(wfi_event),
      .cause(cause),
      .pc(pc),
      .badaddr(badaddr),
      .rdata(rdata),
      .exception_next_pc(exception_next_pc),
      .exception_select(exception_select),
      .privilege_mode(privilege_mode),
      .csr_access_fault(csr_access_fault),
      .mstatus(mstatus),
      .timer_counter(timer_counter),
      .satp(satp),
      .tlb_flush(tlb_flush),
      .mie(mie),
      .mip(mip_current),
      .mideleg(mideleg),
      .menvcfgh(menvcfgh),
      .mcounteren(mcounteren),
      .stimecmp(stimecmp),
      .stimecmph(stimecmph),
      .mip_next_from_irq_ctrl(mip_next)
  );

  // Instantiate Interrupt Controller
  interrupt_controller interrupt_controller_inst (
      .clk(clk),
      .resetn(resetn),
      .IRQ3(IRQ3),
      .IRQ7(IRQ7),
      .IRQ9(IRQ9),
      .IRQ11(IRQ11),
      .mie(mie),
      .mip_current(mip_current),
      .mideleg(mideleg),
      .mstatus(mstatus),
      .privilege_mode(privilege_mode),
      .timer_counter(timer_counter),
      .stimecmp(stimecmp),
      .stimecmph(stimecmph),
      .menvcfgh(menvcfgh),
      .mcounteren(mcounteren),
      .mip_next(mip_next),
      .IRQ_TO_CPU_CTRL1(IRQ_TO_CPU_CTRL1),
      .IRQ_TO_CPU_CTRL3(IRQ_TO_CPU_CTRL3),
      .IRQ_TO_CPU_CTRL5(IRQ_TO_CPU_CTRL5),
      .IRQ_TO_CPU_CTRL7(IRQ_TO_CPU_CTRL7),
      .IRQ_TO_CPU_CTRL9(IRQ_TO_CPU_CTRL9),
      .IRQ_TO_CPU_CTRL11(IRQ_TO_CPU_CTRL11)
  );

endmodule
