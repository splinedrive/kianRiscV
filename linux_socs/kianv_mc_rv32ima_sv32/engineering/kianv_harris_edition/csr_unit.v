/*
 *  kianv harris multicycle RISC-V rv32ima
 *  CSR Unit - Control and Status Registers
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

module csr_unit #(
    parameter SYSTEM_CLK = 50_000_000
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
    output reg  [              31:0] rdata,
    output reg  [              31:0] exception_next_pc,
    output reg                       exception_select,
    output reg  [               1:0] privilege_mode,
    output wire                      csr_access_fault,
    output reg  [              31:0] mstatus,
    output wire [              63:0] timer_counter,
    output reg  [              31:0] satp,
    output reg                       tlb_flush,

    // Interface to interrupt controller
    output wire [              31:0] mie,
    output wire [              31:0] mip,
    output wire [              31:0] mideleg,
    output wire [              31:0] menvcfgh,
    output wire [              31:0] mcounteren,
    output wire [              31:0] stimecmp,
    output wire [              31:0] stimecmph,
    input  wire [              31:0] mip_next_from_irq_ctrl
);

  wire is_reg_operand;
  assign is_reg_operand = CSRop == `CSR_OP_CSRRW || CSRop == `CSR_OP_CSRRS || CSRop == `CSR_OP_CSRRC;

  // CSR access control
  reg csr_not_exist;
  wire [1:0] csr_privilege_level;
  assign csr_privilege_level = CSRAddr[9:8];
  wire csr_read_only;
  assign csr_read_only = (CSRAddr[11:10] == 2'b11);
  assign csr_access_fault = (privilege_mode < csr_privilege_level) || (we & csr_read_only) || csr_not_exist;

  wire csr_write_valid;
  assign csr_write_valid = we && !csr_access_fault;

  wire [31:0] extended_uimm;
  assign extended_uimm = {{27{1'b0}}, uimm};

  wire [31:0] wdata;
  assign wdata = is_reg_operand ? Rd1 : extended_uimm;

  // Counters
  wire [63:0] instr_counter;
  counter #(64) instr_cnt_I (
      resetn,
      clk,
      incr_inst_retired,
      instr_counter
  );

  reg [17:0] tick_cnt;
  wire [15:0] div = (SYSTEM_CLK / 1_000_000);
  wire tick = tick_cnt == ({2'b0, div} - 1);

  always @(posedge clk) begin
    if (!resetn || tick) begin
      tick_cnt <= 0;
    end else begin
      tick_cnt <= tick_cnt + 1;
    end
  end

  counter #(64) timer_cnt_I (
      resetn,
      clk,
      tick,
      timer_counter
  );

  wire [63:0] cycle_counter;
  counter #(64) cycle_counter_I (
      resetn,
      clk,
      1'b1,
      cycle_counter
  );

  // Machine-Level CSRs
  reg [31:0] mtimecmp;
  reg [31:0] mtimecmph;
  reg [31:0] mscratch;
  reg [31:0] mtvec;
  reg [31:0] mepc;
  reg [31:0] mcause;
  reg [31:0] mtval;
  reg [31:0] medeleg;
  reg [31:0] mie_reg;
  reg [31:0] mip_reg;
  reg [31:0] mideleg_reg;
  reg [31:0] menvcfg;
  reg [31:0] menvcfgh_reg;
  reg [31:0] mcounteren_reg;
  reg [31:0] mcountinhibit;

  assign mie = mie_reg;
  assign mip = mip_reg;
  assign mideleg = mideleg_reg;
  assign menvcfgh = menvcfgh_reg;
  assign mcounteren = mcounteren_reg;

  // Supervisor-Level CSRs
  reg [31:0] sscratch;
  reg [31:0] stvec;
  reg [31:0] sepc;
  reg [31:0] scause;
  reg [31:0] stval;
  reg [31:0] stimecmp_reg;
  reg [31:0] stimecmph_reg;
  reg [31:0] scounteren;

  assign stimecmp = stimecmp_reg;
  assign stimecmph = stimecmph_reg;

  // Next state signals
  reg [1:0]  privilege_mode_nxt;
  reg [31:0] mtimecmp_nxt;
  reg [31:0] mtimecmph_nxt;
  reg [31:0] mscratch_nxt;
  reg [31:0] mtvec_nxt;
  reg [31:0] mepc_nxt;
  reg [31:0] mtval_nxt;
  reg [31:0] mcause_nxt;
  reg [31:0] mstatus_nxt;
  reg [31:0] mie_nxt;
  reg [31:0] mip_nxt;
  reg [31:0] medeleg_nxt;
  reg [31:0] mideleg_nxt;
  reg [31:0] menvcfg_nxt;
  reg [31:0] menvcfgh_nxt;
  reg [31:0] mcounteren_nxt;
  reg [31:0] mcountinhibit_nxt;
  reg [31:0] sscratch_nxt;
  reg [31:0] stvec_nxt;
  reg [31:0] sepc_nxt;
  reg [31:0] scause_nxt;
  reg [31:0] stval_nxt;
  reg [31:0] satp_nxt;
  reg [31:0] stimecmp_nxt;
  reg [31:0] stimecmph_nxt;
  reg [31:0] scounteren_nxt;
  reg [31:0] exception_next_pc_nxt;
  reg        exception_select_nxt;

  // CSR operation types
  wire is_csrrw  = CSRop == `CSR_OP_CSRRW;
  wire is_csrrs  = CSRop == `CSR_OP_CSRRS;
  wire is_csrrc  = CSRop == `CSR_OP_CSRRC;
  wire is_csrrwi = CSRop == `CSR_OP_CSRRWI;
  wire is_csrrsi = CSRop == `CSR_OP_CSRRSI;
  wire is_csrrci = CSRop == `CSR_OP_CSRRCI;
  wire is_csr_set = is_csrrs || is_csrrsi;
  wire is_csr_clear = is_csrrc || is_csrrci;

  // Sequential logic
  always @(posedge clk) begin
    if (!resetn) begin
      privilege_mode <= `PRIVILEGE_MODE_MACHINE;
      mstatus <= 0;
      mtimecmp <= 0;
      mtimecmph <= 0;
      mscratch <= 0;
      mtvec <= 0;
      mepc <= 0;
      mcause <= 0;
      mtval <= 0;
      mie_reg <= 0;
      mip_reg <= 0;
      menvcfg <= 0;
      menvcfgh_reg <= 0;
      mcounteren_reg <= 0;
      mcountinhibit <= 0;
      medeleg <= 0;
      mideleg_reg <= 0;
      sscratch <= 0;
      stvec <= 0;
      sepc <= 0;
      scause <= 0;
      stval <= 0;
      satp <= 0;
      stimecmp_reg <= 0;
      stimecmph_reg <= 0;
      scounteren <= 0;
      exception_next_pc <= 0;
      exception_select <= 1'b0;
    end else begin
      privilege_mode <= privilege_mode_nxt;
      mtimecmp <= mtimecmp_nxt;
      mtimecmph <= mtimecmph_nxt;
      mscratch <= mscratch_nxt;
      mtvec <= mtvec_nxt;
      mepc <= mepc_nxt;
      mcause <= mcause_nxt;
      mtval <= mtval_nxt;
      mie_reg <= mie_nxt;
      mip_reg <= mip_nxt;
      menvcfg <= menvcfg_nxt;
      menvcfgh_reg <= menvcfgh_nxt;
      mcounteren_reg <= mcounteren_nxt;
      mcountinhibit <= mcountinhibit_nxt;
      medeleg <= medeleg_nxt;
      mideleg_reg <= mideleg_nxt;
      sscratch <= sscratch_nxt;
      stvec <= stvec_nxt;
      sepc <= sepc_nxt;
      scause <= scause_nxt;
      stval <= stval_nxt;
      satp <= satp_nxt;
      stimecmp_reg <= stimecmp_nxt;
      stimecmph_reg <= stimecmph_nxt;
      scounteren <= scounteren_nxt;
      exception_next_pc <= exception_next_pc_nxt;
      exception_select <= exception_select_nxt;
      mstatus <= mstatus_nxt;
    end
  end

  // CSR read logic
  always @(*) begin
    csr_not_exist = 1'b0;
    rdata = 32'b0;
    case (CSRAddr)
      `CSR_MISA: rdata = `SET_MISA_VALUE(`MISA_MXL_RV32) |
                         `MISA_EXTENSION_BIT(`MISA_EXTENSION_A) |
                         `MISA_EXTENSION_BIT(`MISA_EXTENSION_I) |
                         `MISA_EXTENSION_BIT(`MISA_EXTENSION_M) |
                         `MISA_EXTENSION_BIT(`MISA_EXTENSION_S) |
                         `MISA_EXTENSION_BIT(`MISA_EXTENSION_U);
      `CSR_INSTRET:   rdata = instr_counter[31:0];
      `CSR_INSTRETH:  rdata = instr_counter[63:32];
      `CSR_CYCLE:     rdata = cycle_counter[31:0];
      `CSR_CYCLEH:    rdata = cycle_counter[63:32];
      `CSR_TIME:      rdata = timer_counter[31:0];
      `CSR_TIMEH:     rdata = timer_counter[63:32];
      `CSR_MHARTID:   rdata = 32'b0;
      `CSR_MVENDORID: rdata = 32'h0;
      `CSR_MARCHID:   rdata = 32'h2b;
      `CSR_MIMPID:    rdata = 0;
      `CSR_MSTATUS:   rdata = mstatus;
      `CSR_MSCRATCH:  rdata = mscratch;
      `CSR_MIE:       rdata = mie_reg;
      `CSR_MIP:       rdata = mip_reg;
      `CSR_MTVEC:     rdata = mtvec;
      `CSR_MEPC:      rdata = mepc;
      `CSR_MCAUSE:    rdata = mcause;
      `CSR_MTVAL:     rdata = mtval;
      `CSR_MENVCFG:   rdata = menvcfg;
      `CSR_MENVCFGH:  rdata = menvcfgh_reg;
      `CSR_MCOUNTEREN: rdata = mcounteren_reg;
      `CSR_MCOUNTINHIBIT: rdata = mcountinhibit;
      `CSR_MEDELEG:   rdata = medeleg & `MEDELEG_MASK;
      `CSR_MIDELEG:   rdata = mideleg_reg & `MIDELEG_MASK;
      `CSR_MTIMECMP:  rdata = mtimecmp;
      `CSR_MTIMECMPH: rdata = mtimecmph;
      `CSR_SSTATUS:   rdata = mstatus & `SSTATUS_MASK;
      `CSR_SSCRATCH:  rdata = sscratch;
      `CSR_SIE:       rdata = mie_reg & `SIE_MASK;
      `CSR_SIP:       rdata = mip_reg & `SIP_MASK;
      `CSR_STVEC:     rdata = stvec;
      `CSR_SEPC:      rdata = sepc;
      `CSR_SCAUSE:    rdata = scause;
      `CSR_STVAL:     rdata = stval;
      `CSR_SATP:      rdata = satp;
      `CSR_STIMECMP:  rdata = stimecmp_reg;
      `CSR_STIMECMPH: rdata = stimecmph_reg;
      `CSR_SCOUNTEREN: rdata = scounteren;
      default: csr_not_exist = 1'b1;
    endcase
  end

  function [31:0] calculate_exception_pc;
    input [1:0] mode;
    input [31:0] base_addr;
    input [31:0] cause_;
    begin
      case (mode)
        2'b00: calculate_exception_pc = base_addr;
        2'b01: calculate_exception_pc = base_addr | (cause_ << 2);
        default: calculate_exception_pc = base_addr;
      endcase
    end
  endfunction

  reg [31:0] deleg;
  reg [31:0] mask;
  reg [31:0] temp_restricted;
  reg [31:0] temp_xstatus;
  reg [31:0] wdata_nxt;
  wire [`MSTATUS_MPP_WIDTH -1:0] y;
  assign y = `GET_MSTATUS_MPP(mstatus);

  // CSR write and exception handling logic
  always @(*) begin
    mstatus_nxt = mstatus;
    mscratch_nxt = mscratch;
    mie_nxt = mie_reg;
    mip_nxt = mip_next_from_irq_ctrl;
    mtvec_nxt = mtvec;
    mepc_nxt = mepc;
    mcause_nxt = mcause;
    mtval_nxt = mtval;
    menvcfg_nxt = menvcfg;
    menvcfgh_nxt = menvcfgh_reg;
    mcounteren_nxt = mcounteren_reg;
    mcountinhibit_nxt = mcountinhibit;
    medeleg_nxt = medeleg;
    mideleg_nxt = mideleg_reg;
    mtimecmp_nxt = mtimecmp;
    mtimecmph_nxt = mtimecmph;
    temp_restricted = 0;
    sscratch_nxt = sscratch;
    stvec_nxt = stvec;
    sepc_nxt = sepc;
    scause_nxt = scause;
    stval_nxt = stval;
    satp_nxt = satp;
    stimecmp_nxt = stimecmp_reg;
    stimecmph_nxt = stimecmph_reg;
    scounteren_nxt = scounteren;
    deleg = 0;
    mask = 0;
    exception_next_pc_nxt = exception_next_pc;
    exception_select_nxt = 1'b0;
    privilege_mode_nxt = privilege_mode;
    temp_xstatus = 0;
    wdata_nxt = is_csr_clear ? rdata & ~wdata : is_csr_set ? rdata | wdata : wdata;
    tlb_flush = 1'b0;

    if (exception_event) begin
      mask  = 1 << `GET_MCAUSE_CAUSE(cause);
      deleg = `IS_MCAUSE_INTERRUPT(cause) ? mideleg_reg : medeleg;

      if ((`IS_USER(privilege_mode) || `IS_SUPERVISOR(privilege_mode)) && (|(deleg & mask))) begin
        temp_xstatus = (mstatus & ~(`XSTATUS_SIE_MASK | `XSTATUS_SPIE_MASK | `XSTATUS_SPP_MASK));
        mstatus_nxt = (temp_xstatus |
                       `SET_XSTATUS_SPIE(`GET_XSTATUS_SIE(mstatus)) |
                       `SET_XSTATUS_SIE(1'b0) |
                       `SET_XSTATUS_SPP(`IS_SUPERVISOR(privilege_mode)));
        privilege_mode_nxt = `PRIVILEGE_MODE_SUPERVISOR;
        sepc_nxt = pc;
        scause_nxt = cause;
        exception_next_pc_nxt = calculate_exception_pc(stvec[1:0], {stvec[31:2], 2'b0}, cause);
        stval_nxt = badaddr;
        exception_select_nxt = 1'b1;
      end else begin
        temp_xstatus = (mstatus & ~(`MSTATUS_MIE_MASK | `MSTATUS_MPIE_MASK | `MSTATUS_MPP_MASK));
        mstatus_nxt = (temp_xstatus |
                       `SET_MSTATUS_MPIE(`GET_MSTATUS_MIE(mstatus)) |
                       `SET_MSTATUS_MIE(1'b0) |
                       `SET_MSTATUS_MPP(privilege_mode));
        privilege_mode_nxt = `PRIVILEGE_MODE_MACHINE;
        mepc_nxt = pc;
        mcause_nxt = cause;
        exception_next_pc_nxt = calculate_exception_pc(mtvec[1:0], {mtvec[31:2], 2'b0}, cause);
        mtval_nxt = badaddr;
        exception_select_nxt = 1'b1;
      end
    end else if (mret) begin
      temp_xstatus = (mstatus & ~(`MSTATUS_MIE_MASK | `MSTATUS_MPIE_MASK | `MSTATUS_MPP_MASK |
                     ((!`IS_MACHINE(y)) << `MSTATUS_MPRV_BIT)));
      mstatus_nxt = (temp_xstatus |
                     `SET_MSTATUS_MIE(`GET_MSTATUS_MPIE(mstatus)) |
                     `SET_MSTATUS_MPIE(1'b1) |
                     `SET_MSTATUS_MPP(`PRIVILEGE_MODE_USER));
      privilege_mode_nxt = y;
      exception_next_pc_nxt = mepc;
      exception_select_nxt = 1'b1;
    end else if (sret) begin
      temp_xstatus = (mstatus & ~(`XSTATUS_SIE_MASK | `XSTATUS_SPIE_MASK | `XSTATUS_SPP_MASK |
                     ((!`IS_MACHINE(y)) << `MSTATUS_MPRV_BIT)));
      mstatus_nxt = (temp_xstatus |
                     `SET_XSTATUS_SIE(`GET_XSTATUS_SPIE(mstatus)) |
                     `SET_XSTATUS_SPIE(1'b1) |
                     `SET_XSTATUS_SPP(1'b0));
      privilege_mode_nxt = `GET_XSTATUS_SPP(mstatus);
      exception_next_pc_nxt = sepc;
      exception_select_nxt = 1'b1;
    end else if (csr_write_valid) begin
      case (CSRAddr)
        `CSR_MSTATUS:  mstatus_nxt = wdata_nxt;
        `CSR_MSCRATCH: mscratch_nxt = wdata_nxt;
        `CSR_MIE:      mie_nxt = wdata_nxt;
        `CSR_MIP:      mip_nxt = wdata_nxt;
        `CSR_MTVEC:    mtvec_nxt = wdata_nxt;
        `CSR_MEPC:     mepc_nxt = wdata_nxt;
        `CSR_MCAUSE:   mcause_nxt = wdata_nxt;
        `CSR_MTVAL:    mtval_nxt = wdata_nxt;
        `CSR_MENVCFG:  menvcfg_nxt = wdata_nxt;
        `CSR_MENVCFGH: menvcfgh_nxt = wdata_nxt;
        `CSR_MCOUNTEREN: mcounteren_nxt = wdata_nxt;
        `CSR_MCOUNTINHIBIT: mcountinhibit_nxt = wdata_nxt;
        `CSR_MEDELEG:  medeleg_nxt = wdata_nxt & `MEDELEG_MASK;
        `CSR_MIDELEG:  mideleg_nxt = wdata_nxt & `MIDELEG_MASK;
        `CSR_MTIMECMP: mtimecmp_nxt = wdata_nxt;
        `CSR_MTIMECMPH: mtimecmph_nxt = wdata_nxt;
        `CSR_SSTATUS: begin
          temp_restricted = mstatus & ~(`SSTATUS_MASK);
          mstatus_nxt = temp_restricted | (wdata_nxt & `SSTATUS_MASK);
        end
        `CSR_SSCRATCH: sscratch_nxt = wdata_nxt;
        `CSR_SIE: begin
          temp_restricted = mie_reg & ~(`SIE_MASK);
          mie_nxt = temp_restricted | (wdata_nxt & `SIE_MASK);
        end
        `CSR_SIP: begin
          temp_restricted = mip_reg & ~(`SIP_MASK);
          mip_nxt = temp_restricted | (wdata_nxt & `SIP_MASK);
        end
        `CSR_STVEC:    stvec_nxt = wdata_nxt;
        `CSR_SEPC:     sepc_nxt = wdata_nxt;
        `CSR_SCAUSE:   scause_nxt = wdata_nxt;
        `CSR_STVAL:    stval_nxt = wdata_nxt;
        `CSR_SATP: begin
          tlb_flush = `GET_SATP_MODE(satp) ^ `GET_SATP_MODE(wdata_nxt);
          satp_nxt  = wdata_nxt;
        end
        `CSR_STIMECMP:   stimecmp_nxt = wdata_nxt;
        `CSR_STIMECMPH:  stimecmph_nxt = wdata_nxt;
        `CSR_SCOUNTEREN: scounteren_nxt = wdata_nxt;
        default: ;
      endcase
    end
  end

endmodule
