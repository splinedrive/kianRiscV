/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2022/23 hirosh dabui <hirosh@dabui.de>
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

module control_unit (
        input  wire                        clk,
        input  wire                        resetn,
        input  wire [                 6:0] op,
        input  wire [                 2:0] funct3,
        input  wire [                 6:0] funct7,
        input  wire [                 0:0] immb10,
        input  wire                        Zero,
        input  wire [                 4:0] Rs1,
        input  wire [                 4:0] Rs2,
        input  wire [                 4:0] Rd,
        output wire [`RESULT_WIDTH   -1:0] ResultSrc,
        output wire [`ALU_CTRL_WIDTH -1:0] ALUControl,
        output wire [`SRCA_WIDTH     -1:0] ALUSrcA,
        output wire [`SRCB_WIDTH     -1:0] ALUSrcB,
        output wire [                 2:0] ImmSrc,
        output wire [`STORE_OP_WIDTH -1:0] STOREop,
        output wire [`LOAD_OP_WIDTH  -1:0] LOADop,
        output wire [`MUL_OP_WIDTH   -1:0] MULop,
        output wire [`DIV_OP_WIDTH   -1:0] DIVop,
        output wire [`CSR_OP_WIDTH   -1:0] CSRop,
        output wire                        CSRwe,
        output wire                        CSRre,
        output wire                        RegWrite,
        output wire                        PCWrite,
        output wire                        AdrSrc,
        output wire                        MemWrite,
        input  wire                        unaligned_access_load,
        input  wire                        unaligned_access_store,
        input  wire                        access_fault,
        output wire                        fetched_instr,
        output wire                        incr_inst_retired,
        output wire                        ALUOutWrite,
        output wire                        amo_temp_write_operation,
        output wire                        muxed_Aluout_or_amo_rd_wr,
        output wire                        amo_set_reserved_state_load,
        output wire                        amo_buffered_data,
        output wire                        amo_buffered_address,
        input  wire                        amo_reserved_state_load,
        output wire                        select_ALUResult,
        output wire                        select_amo_temp,

        // Exception Handler
        output wire exception_event,
        output wire [31:0] cause,
        output wire [31:0] badaddr,
        output wire mret,
        output wire wfi_event,
        input wire [1:0] privilege_mode,
        input wire csr_access_fault,
        input wire [31:0] mie,
        input wire [31:0] mip,
        input wire [31:0] mstatus,

        output wire mem_valid,
        input  wire mem_ready,

        output wire mul_valid,
        input  wire mul_ready,

        output wire div_valid,
        input  wire div_ready
    );

    wire [`ALU_OP_WIDTH   -1:0] ALUOp;
    wire [`AMO_OP_WIDTH   -1:0] AMOop;
    wire PCUpdate;
    wire Branch;
    wire mul_ext_ready;
    wire mul_ext_valid;

    wire taken_branch = !Zero;
    assign PCWrite = Branch & taken_branch | PCUpdate;

    assign mul_ext_ready = mul_ready | div_ready;

    wire amo_data_load;
    wire amo_operation_store;

    wire CSRvalid;
    main_fsm main_fsm_I (
                 .clk              (clk),
                 .resetn           (resetn),
                 .op               (op),
                 .funct7           (funct7),
                 .funct3           (funct3),
                 .Rs1              (Rs1),
                 .Rs2              (Rs2),
                 .Rd               (Rd),
                 .Zero             (Zero),
                 .AdrSrc           (AdrSrc),
                 .fetched_instr    (fetched_instr),
                 .incr_inst_retired(incr_inst_retired),
                 .ALUSrcA          (ALUSrcA),
                 .ALUSrcB          (ALUSrcB),
                 .ALUOp            (ALUOp),
                 .AMOop            (AMOop),
                 .ResultSrc        (ResultSrc),
                 .ImmSrc           (ImmSrc),
                 .CSRvalid         (CSRvalid),
                 .PCUpdate         (PCUpdate),
                 .Branch           (Branch),
                 .RegWrite         (RegWrite),
                 .ALUOutWrite      (ALUOutWrite),

                 .amo_temp_write_operation   (amo_temp_write_operation),
                 .amo_data_load              (amo_data_load),
                 .amo_operation_store        (amo_operation_store),
                 .muxed_Aluout_or_amo_rd_wr  (muxed_Aluout_or_amo_rd_wr),
                 .amo_set_reserved_state_load(amo_set_reserved_state_load),
                 .amo_buffered_data          (amo_buffered_data),
                 .amo_buffered_address       (amo_buffered_address),
                 .amo_reserved_state_load    (amo_reserved_state_load),
                 .select_ALUResult           (select_ALUResult),
                 .select_amo_temp            (select_amo_temp),
                 .MemWrite                   (MemWrite),
                 .unaligned_access_load      (unaligned_access_load),
                 .unaligned_access_store     (unaligned_access_store),
                 .access_fault               (access_fault),

                 .exception_event (exception_event),
                 .cause           (cause),
                 .badaddr         (badaddr),
                 .mret            (mret),
                 .wfi_event       (wfi_event),
                 .privilege_mode  (privilege_mode),
                 .csr_access_fault(csr_access_fault),
                 .mstatus         (mstatus),
                 .mie             (mie),
                 .mip             (mip),

                 .mem_valid(mem_valid),
                 .mem_ready(mem_ready),

                 .mul_ext_valid(mul_ext_valid),
                 .mul_ext_ready(mul_ext_ready)
             );

    load_decoder load_decoder_I (
                     funct3,
                     amo_data_load,
                     LOADop
                 );
    store_decoder store_decoder_I (
                      funct3,
                      amo_operation_store,
                      STOREop
                  );

    csr_decoder csr_decoder_I (
                    .funct3(funct3),
                    .Rs1Uimm(Rs1),
                    .Rd(Rd),
                    .valid(CSRvalid),
                    .CSRwe(CSRwe),
                    .CSRre(CSRre),
                    .CSRop(CSRop)
                );

    alu_decoder alu_decoder_I (
                    .imm_bit10 (immb10),
                    .op_bit5   (op[5]),
                    .funct3    (funct3),
                    .funct7b5  (funct7[5]),
                    .ALUOp     (ALUOp),
                    .AMOop     (AMOop),
                    .ALUControl(ALUControl)
                );

    multiplier_extension_decoder mul_ext_de_I (
                                     funct3,
                                     MULop,
                                     DIVop,
                                     mul_ext_valid,
                                     mul_valid,
                                     div_valid
                                 );

endmodule
