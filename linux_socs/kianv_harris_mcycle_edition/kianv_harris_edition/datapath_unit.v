/*
 *  kianv harris multicycle RISC-V rv32imo
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
module datapath_unit #(
        parameter RV32E             = 0,
        parameter RESET_ADDR        = 0,
        parameter SHOW_ASSEMBLER    = 0,
        parameter SHOW_REGISTER_SET = 0,
        parameter STACKADDR         = 32'hffff_ffff
    ) (
        input wire clk,
        input wire resetn,

        input  wire [`RESULT_WIDTH   -1:0] ResultSrc,
        input  wire [`ALU_CTRL_WIDTH -1:0] ALUControl,
        input  wire [`SRCA_WIDTH     -1:0] ALUSrcA,
        input  wire [`SRCB_WIDTH     -1:0] ALUSrcB,
        input  wire [                 2:0] ImmSrc,
        input  wire [`STORE_OP_WIDTH -1:0] STOREop,
        input  wire [`LOAD_OP_WIDTH  -1:0] LOADop,
        input  wire [`MUL_OP_WIDTH   -1:0] MULop,
        input  wire [`DIV_OP_WIDTH   -1:0] DIVop,
        input  wire [`CSR_OP_WIDTH   -1:0] CSRop,
        input  wire                        CSRwe,
        input  wire                        CSRre,
        output wire                        Zero,
        output wire                        immb10,

        input wire RegWrite,
        input wire PCWrite,
        input wire AdrSrc,
        input wire MemWrite,
        input wire incr_inst_retired,
        input wire fetched_instr,
        input wire ALUOutWrite,

        // AMO
        input  wire amo_temp_write_operation,
        input  wire amo_set_reserved_state_load,
        input  wire amo_buffered_data,
        input  wire amo_buffered_address,
        output wire amo_reserved_state_load,
        input  wire muxed_Aluout_or_amo_rd_wr,
        input  wire select_ALUResult,
        input  wire select_amo_temp,


        // 32-bit instruction input
        output wire [31:0] Instr,

        output wire [ 3:0] mem_wstrb,
        output wire [31:0] mem_addr,
        output wire [31:0] mem_wdata,
        input  wire [31:0] mem_rdata,
        input  wire        mul_valid,
        output wire        mul_ready,
        input  wire        div_valid,
        output wire        div_ready,
        output wire [31:0] ProgCounter,
        output wire        unaligned_access_load,
        output wire        unaligned_access_store,

        // Exception Handler
        input wire exception_event,
        input wire [31:0] cause,
        input wire [31:0] badaddr,
        input wire mret,
        input wire wfi_event,
        output wire csr_access_fault,
        output wire [1:0] privilege_mode,
        output wire [31:0] mie,
        output wire [31:0] mip,
        output wire [31:0] mstatus,
        input wire IRQ3,
        input wire IRQ7
    );


    wire [31:0] Rd1;
    wire [31:0] Rd2;

    wire [4:0] Rs1 = Instr[19:15];
    wire [4:0] Rs2 = Instr[24:20];
    wire [4:0] Rd = Instr[11:7];

    wire [31:0] WD3;

    register_file #(
                      .REGISTER_DEPTH(RV32E ? 16 : 32),
                      .STACKADDR(STACKADDR)
                  ) register_file_I (
                      .clk(clk),
                      .we (RegWrite),
                      .A1 (Rs1),
                      .A2 (Rs2),
                      .A3 (Rd),
                      .rd1(Rd1),
                      .rd2(Rd2),
                      .wd (WD3)
                  );

    wire [31:0] ImmExt;
    wire [31:0] PC, OldPC;
    wire [31:0] PCNext;
    wire [31:0] A1, A2;
    wire [31:0] SrcA, SrcB;
    wire [31:0] ALUResult;
    wire [31:0] MULResult;
    wire [31:0] DIVResult;
    wire [31:0] MULExtResult;
    wire [31:0] MULExtResultOut;
    wire [31:0] ALUOut;
    wire [31:0] Result;
    wire [ 3:0] wmask;
    wire [31:0] Data;
    wire [31:0] DataLatched;
    wire [31:0] CSRData;
    wire [ 1:0] mem_addr_align_latch;
    wire [31:0] CSRDataOut;
    wire        div_by_zero_err;

    assign immb10      = ImmExt[10];
    assign ProgCounter = PC;
    assign mem_wstrb   = wmask & {4{MemWrite}};

    assign WD3         = Result;
    assign PCNext      = Result;

    // AMO
    wire [31:0] amo_temporary_data;
    wire [31:0] alu_out_or_amo_scw;
    wire [31:0] DataLatched_or_AMOtempData;
    wire [31:0] muxed_A2_data;
    wire [31:0] muxed_Data_ALUResult;

    // CSR exception handler
    wire [11:0] CSRAddr;
    assign CSRAddr = ImmExt[11:0];

    wire [31:0] exception_next_pc;


    mux2 #(32) Addr_I (
             PC,
             Result,
             AdrSrc,
             mem_addr
         );

    mux2 #(32) DataLatched_or_AMOtempData_i (
             DataLatched,
             amo_temporary_data,
             select_amo_temp,
             DataLatched_or_AMOtempData
         );

    mux6 #(32) Result_I (
             alu_out_or_amo_scw,
             DataLatched_or_AMOtempData,
             ALUResult,
             MULExtResultOut,
             CSRDataOut,
             amo_buffer_addr_value,
             ResultSrc,
             Result
         );

    wire [31:0] pc_or_exception_next;
    wire exception_select;
    mux2 #(32) pc_next_or_exception_mux_I (
             PCNext,
             exception_next_pc,
             exception_select,
             pc_or_exception_next
         );

    dff #(32, RESET_ADDR) PC_I (
            resetn,
            clk,
            PCWrite,
            pc_or_exception_next,
            PC
        );

    dff #(32, `NOP_INSTR) Instr_I (
            resetn,
            clk,
            fetched_instr,
            mem_rdata,
            Instr
        );

    wire [31:0] amo_buffer_addr_value;
    dff #(32) amo_buffered_addr_I (
            .resetn(resetn),
            .clk(clk),
            .d(ALUResult),
            .en(amo_buffered_address),
            .q(amo_buffer_addr_value)
        );

    dff #(1) amo_reserved_state_load_I (
            .resetn(resetn),
            .clk(clk),
            .d(amo_buffered_data),
            .en(amo_set_reserved_state_load),
            .q(amo_reserved_state_load)
        );

    dff #(32, RESET_ADDR) OldPC_I (
            resetn,
            clk,
            fetched_instr,
            PC,
            OldPC
        );

    dff #(32) ALUOut_I (
            resetn,
            clk,
            ALUOutWrite,
            ALUResult,
            ALUOut
        );

    mux2 #(32) Aluout_or_atomic_scw_I (
             ALUOut,
             {{31{1'b0}}, amo_buffered_data},
             muxed_Aluout_or_amo_rd_wr,
             alu_out_or_amo_scw
         );

    dlatch #(2) ADDR_I (
               clk,
               mem_addr[1:0],
               mem_addr_align_latch
           );

    dlatch #(32) A1_I (
               clk,
               Rd1,
               A1
           );

    dlatch #(32) A2_I (
               clk,
               Rd2,
               A2
           );

    // todo: data, csrdata, mulex could be stored in one dlatch
    dlatch #(32) Data_I (
               clk,
               Data,
               DataLatched
           );

    dlatch #(32) CSROut_I (
               clk,
               CSRData,
               CSRDataOut
           );

    dlatch #(32) MULExtResultOut_I (
               clk,
               MULExtResult,
               MULExtResultOut
           );

    extend extend_I (
               Instr[31:7],
               ImmSrc,
               ImmExt
           );

    mux2 #(32) muxed_A2_data_I (
             A2,
             amo_temporary_data,
             select_amo_temp,
             muxed_A2_data
         );

    store_alignment store_alignment_I (
                        mem_addr[1:0],
                        STOREop,
                        muxed_A2_data,
                        mem_wdata,
                        wmask,
                        unaligned_access_store
                    );

    load_alignment load_alignment_I (
                       mem_addr_align_latch,
                       LOADop,
                       mem_rdata,
                       Data,
                       unaligned_access_load
                   );

    mux2 #(32) muxed_Data_ALUResult_I (
             Data,
             ALUResult,
             select_ALUResult,
             muxed_Data_ALUResult
         );

    dff #(32) AMOTmpData_I (
            resetn,
            clk,
            amo_temp_write_operation,
            muxed_Data_ALUResult,
            amo_temporary_data
        );

    mux5 #(32) SrcA_I (
             PC,
             OldPC,
             A1  /* Rd1 */,
             amo_temporary_data,
             32'd0,
             ALUSrcA,
             SrcA
         );

    mux4 #(32) SrcB_I (
             A2  /* Rd2 */,
             ImmExt,
             32'd4,
             32'd0,
             ALUSrcB,
             SrcB
         );

    alu alu_I (
            SrcA,
            SrcB,
            ALUControl,
            ALUResult,
            Zero
        );

    mux2 #(32) mul_ext_I (
             MULResult,
             DIVResult,
             !mul_valid,
             MULExtResult
         );

    multiplier mul_I (
                   clk,
                   resetn,
                   SrcA,
                   SrcB,
                   MULop,
                   MULResult,
                   mul_valid,
                   mul_ready
               );

    divider div_I (
                clk,
                resetn,
                SrcA,
                SrcB,
                DIVop,
                DIVResult,
                div_valid,
                div_ready,
                div_by_zero_err  /* todo: */
            );

    csr_exception_handler csr_exception_handler_I (
                              .clk              (clk),
                              .resetn           (resetn),
                              .incr_inst_retired(incr_inst_retired),
                              .CSRAddr          (CSRAddr),
                              .CSRop            (CSRop),
                              .Rd1              (SrcA),
                              .uimm             (Rs1),
                              .we               (CSRwe),
                              .re               (CSRre),
                              .exception_event  (exception_event),
                              .mret             (mret),
                              .wfi_event        (wfi_event),
                              .cause            (cause),
                              .pc               (OldPC),
                              .badaddr          (badaddr),

                              .privilege_mode   (privilege_mode),
                              .rdata            (CSRData),
                              .exception_next_pc(exception_next_pc),
                              .exception_select (exception_select),
                              .csr_access_fault (csr_access_fault),
                              .mie              (mie),
                              .mip              (mip),
                              .mstatus          (mstatus),
                              .IRQ3             (IRQ3),
                              .IRQ7             (IRQ7)
                          );

endmodule
