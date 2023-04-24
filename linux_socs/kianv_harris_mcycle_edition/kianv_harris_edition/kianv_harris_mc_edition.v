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

`include "riscv_defines.vh"
module kianv_harris_mc_edition #(
        parameter RESET_ADDR = 0,
        parameter STACKADDR  = 0,
        parameter RV32E      = 0
    ) (
        input  wire        clk,
        input  wire        resetn,
        output wire        mem_valid,
        input  wire        mem_ready,
        output wire [ 3:0] mem_wstrb,
        output wire [31:0] mem_addr,
        output wire [31:0] mem_wdata,
        input  wire [31:0] mem_rdata,
        output wire [31:0] PC,
        input  wire        access_fault,
        input  wire        IRQ3,
        input  wire        IRQ7
    );

    wire [                 31:0] Instr;
    wire [                  6:0] op;
    wire [                  2:0] funct3;
    wire [                  6:0] funct7;
    wire [                  0:0] immb10;

    wire                         Zero;

    wire [`RESULT_WIDTH    -1:0] ResultSrc;
    wire [`ALU_CTRL_WIDTH  -1:0] ALUControl;
    wire [`SRCA_WIDTH      -1:0] ALUSrcA;
    wire [`SRCB_WIDTH      -1:0] ALUSrcB;
    wire [                  2:0] ImmSrc;
    wire [`STORE_OP_WIDTH  -1:0] STOREop;
    wire [`LOAD_OP_WIDTH   -1:0] LOADop;
    wire [`MUL_OP_WIDTH    -1:0] MULop;
    wire [`DIV_OP_WIDTH    -1:0] DIVop;
    wire [`CSR_OP_WIDTH    -1:0] CSRop;
    wire                         CSRwe;
    wire                         CSRre;
    wire [                  4:0] Rs1;
    wire [                  4:0] Rs2;
    wire [                  4:0] Rd;

    wire                         RegWrite;
    wire                         PCWrite;
    wire                         AdrSrc;
    wire                         MemWrite;
    wire                         unaligned_access_load;
    wire                         unaligned_access_store;
    wire                         fetched_instr;
    wire                         incr_inst_retired;
    wire                         ALUOutWrite;

    wire                         mul_valid;
    wire                         mul_ready;
    wire                         div_valid;
    wire                         div_ready;

    assign op     = Instr[6:0];
    assign funct3 = Instr[14:12];
    assign funct7 = Instr[31:25];
    assign Rs1    = Instr[19:15];
    assign Rs2    = Instr[24:20];
    assign Rd     = Instr[11:7];

    wire amo_tmp_write;
    wire amo_set_load_reserved_state;
    wire amo_intermediate_data;
    wire amo_intermediate_addr;
    wire amo_load_reserved_state;
    wire Aluout_or_amo_rd_wr_mux;
    wire AMOWb_en;
    wire amo_alu_op;

    // Exception Handler
    wire exception_event;
    wire [31:0] cause;
    wire [31:0] badaddr;
    wire mret;
    wire wfi_event;
    wire [1:0] privilege_mode;
    wire csr_access_fault;
    wire [31:0] mstatus;
    wire [31:0] mie;
    wire [31:0] mip;

    control_unit control_unit_I (
                     .clk              (clk),
                     .resetn           (resetn),
                     .op               (op),
                     .funct3           (funct3),
                     .funct7           (funct7),
                     .immb10           (immb10),
                     .Zero             (Zero),
                     .Rs1              (Rs1),
                     .Rs2              (Rs2),
                     .Rd               (Rd),
                     .ResultSrc        (ResultSrc),
                     .ALUControl       (ALUControl),
                     .ALUSrcA          (ALUSrcA),
                     .ALUSrcB          (ALUSrcB),
                     .ImmSrc           (ImmSrc),
                     .STOREop          (STOREop),
                     .LOADop           (LOADop),
                     .CSRop            (CSRop),
                     .CSRwe            (CSRwe),
                     .CSRre            (CSRre),
                     .RegWrite         (RegWrite),
                     .PCWrite          (PCWrite),
                     .AdrSrc           (AdrSrc),
                     .MemWrite         (MemWrite),
                     .fetched_instr    (fetched_instr),
                     .incr_inst_retired(incr_inst_retired),
                     .ALUOutWrite      (ALUOutWrite),
                     .mem_valid        (mem_valid),
                     .mem_ready        (mem_ready),
                     .MULop            (MULop),
                     .unaligned_access_load  (unaligned_access_load),
                     .unaligned_access_store (unaligned_access_store),
                     .access_fault (access_fault),

                     .mul_valid                  (mul_valid),
                     .mul_ready                  (mul_ready),
                     .DIVop                      (DIVop),
                     .div_valid                  (div_valid),
                     .div_ready                  (div_ready),
                     // AMO
                     .amo_tmp_write              (amo_tmp_write),
                     .amo_set_load_reserved_state(amo_set_load_reserved_state),
                     .amo_intermediate_data      (amo_intermediate_data),
                     .amo_intermediate_addr      (amo_intermediate_addr),
                     .amo_load_reserved_state    (amo_load_reserved_state),
                     .Aluout_or_amo_rd_wr_mux    (Aluout_or_amo_rd_wr_mux),
                     .AMOWb_en                   (AMOWb_en),
                     .amo_alu_op                 (amo_alu_op),

                     .exception_event            (exception_event),
                     .cause                      (cause),
                     .badaddr                    (badaddr),
                     .mret                       (mret),
                     .wfi_event                  (wfi_event),
                     .privilege_mode             (privilege_mode),
                     .csr_access_fault           (csr_access_fault),
                     .mstatus (mstatus),
                     .mie     (mie    ),
                     .mip     (mip    )
                 );

    datapath_unit #(
                      .RESET_ADDR(RESET_ADDR),
                      .STACKADDR (STACKADDR),
                      .RV32E     (RV32E)
                  ) datapath_unit_I (
                      .clk   (clk),
                      .resetn(resetn),

                      .ResultSrc (ResultSrc),
                      .ALUControl(ALUControl),
                      .ALUSrcA   (ALUSrcA),
                      .ALUSrcB   (ALUSrcB),
                      .ImmSrc    (ImmSrc),
                      .STOREop   (STOREop),
                      .LOADop    (LOADop),
                      .CSRop     (CSRop),
                      .CSRwe     (CSRwe),
                      .CSRre     (CSRre),
                      .Zero      (Zero),
                      .immb10    (immb10),

                      .RegWrite         (RegWrite),
                      .PCWrite          (PCWrite),
                      .AdrSrc           (AdrSrc),
                      .MemWrite         (MemWrite),
                      .incr_inst_retired(incr_inst_retired),
                      .fetched_instr    (fetched_instr),
                      .ALUOutWrite      (ALUOutWrite),
                      .Instr            (Instr),

                      .mem_wstrb(mem_wstrb),
                      .mem_addr (mem_addr),
                      .mem_wdata(mem_wdata),
                      .mem_rdata(mem_rdata),
                      .unaligned_access_load  (unaligned_access_load),
                      .unaligned_access_store (unaligned_access_store),

                      .MULop      (MULop),
                      .mul_valid  (mul_valid),
                      .mul_ready  (mul_ready),
                      .DIVop      (DIVop),
                      .div_valid  (div_valid),
                      .div_ready  (div_ready),
                      .ProgCounter(PC),

                      // AMO
                      .amo_tmp_write              (amo_tmp_write),
                      .amo_set_load_reserved_state(amo_set_load_reserved_state),
                      .amo_intermediate_data      (amo_intermediate_data),
                      .amo_intermediate_addr      (amo_intermediate_addr),
                      .amo_load_reserved_state    (amo_load_reserved_state),
                      .Aluout_or_amo_rd_wr_mux    (Aluout_or_amo_rd_wr_mux),
                      .AMOWb_en                   (AMOWb_en),
                      .amo_alu_op                 (amo_alu_op),

                      // Exception
                      .exception_event (exception_event),
                      .cause           (cause),
                      .badaddr         (badaddr),
                      .mret            (mret),
                      .wfi_event       (wfi_event),
                      .privilege_mode  (privilege_mode),
                      .csr_access_fault(csr_access_fault),
                      .mie     (mie    ),
                      .mip     (mip    ),
                      .mstatus (mstatus),
                      .IRQ3                       (IRQ3),
                      .IRQ7                       (IRQ7)
                  );
endmodule
