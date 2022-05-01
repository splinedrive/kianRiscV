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

`include "riscv_defines.vh"
module datapath_unit
    #(
         parameter            RV32E               = 0,
         parameter            RESET_ADDR          = 0,
         parameter            SHOW_ASSEMBLER      = 0,
         parameter            SHOW_REGISTER_SET   = 0,
         parameter            STACKADDR           = 32'h ffff_ffff
     )
     (
         input  wire clk,
         input  wire resetn,

         input  wire [`RESULT_WIDTH   -1: 0] ResultSrc,
         input  wire [`ALU_CTRL_WIDTH -1: 0] ALUControl,
         input  wire [`SRCA_WIDTH     -1: 0] ALUSrcA,
         input  wire [`SRCB_WIDTH     -1: 0] ALUSrcB,
         input  wire [                 2: 0] ImmSrc,
         input  wire [`STORE_OP_WIDTH -1: 0] STOREop,
         input  wire [`LOAD_OP_WIDTH  -1: 0] LOADop,
         input  wire [`MUL_OP_WIDTH   -1: 0] MULop,
         input  wire [`DIV_OP_WIDTH   -1: 0] DIVop,
         input  wire [`CSR_OP_WIDTH   -1: 0] CSRop,
         output wire                         Zero,
         output wire                         immb10,

         input  wire         RegWrite,
         input  wire         PCWrite,
         input  wire         AdrSrc,
         input  wire         MemWrite,
         input  wire         IRWrite,
         input  wire         ALUOutWrite,

         output wire [31: 0] Instr,

         output wire [ 3: 0] mem_wstrb,
         output wire [31: 0] mem_addr,
         output wire [31: 0] mem_wdata,
         input  wire [31: 0] mem_rdata,
         input  wire         mul_valid,
         output wire         mul_ready,
         input  wire         div_valid,
         output wire         div_ready
     );

    wire [31: 0] Rd1;
    wire [31: 0] Rd2;

    wire [ 4: 0] Rs1 = Instr[19:15];
    wire [ 4: 0] Rs2 = Instr[24:20];
    wire [ 4: 0] Rd  = Instr[11:7];

    wire [31: 0] WD3;

    assign immb10    = ImmExt[10];

    register_file #(
                      .REGISTER_DEPTH(RV32E ? 16 : 32),
                      .STACKADDR(STACKADDR)
                  )
                  register_file_I(
                      .clk            (  clk      ),
                      .we             (  RegWrite ),
                      .A1             (  Rs1      ),
                      .A2             (  Rs2      ),
                      .A3             (  Rd       ),
                      .rd1            (  Rd1      ),
                      .rd2            (  Rd2      ),
                      .wd             (  WD3      )

                  );

    wire [31: 0] ImmExt;
    wire [31: 0] PC, OldPC;
    wire [31: 0] PCNext;
    wire [31: 0] A1, A2;
    wire [31: 0] SrcA, SrcB;
    wire [31: 0] ALUResult;
    wire [31: 0] MULResult;
    wire [31: 0] DIVResult;
    wire [31: 0] MULExtResult;
    wire [31: 0] MULExtResultOut;
    wire [31: 0] ALUOut;
    wire [31: 0] Result;
    wire [ 3: 0] wmask;
    wire [31: 0] Data;
    wire [31: 0] DataLatched;
    wire [31: 0] CSRData;
    wire [ 1: 0] mem_addr_align_latch;
    wire [31: 0] CSRDataOut;
    wire         div_by_zero_err;

    assign mem_wstrb = wmask & {4{MemWrite}};

    assign WD3    = Result;
    assign PCNext = Result;

    mux2 #(32) Addr_I   (PC, Result, AdrSrc, mem_addr);
    mux5 #(32) Result_I (ALUOut, DataLatched, ALUResult, MULExtResultOut, CSRDataOut, ResultSrc, Result);

    dflop_rsync #(32, RESET_ADDR) PC_I       (resetn, clk, PCWrite, PCNext, PC);
    dflop_rsync #(32)             Instr_I    (resetn, clk, IRWrite, mem_rdata, Instr);
    dflop_rsync #(32)             OldPC_I    (resetn, clk, IRWrite, PC, OldPC);
    dflop_rsync #(32)             ALUOut_I   (resetn, clk, ALUOutWrite, ALUResult, ALUOut);

    latch #(2)  ADDR_I            (clk, mem_addr[1:0], mem_addr_align_latch);
    latch #(32) A1_I              (clk, Rd1, A1);
    latch #(32) A2_I              (clk, Rd2, A2);

    // todo: data, csrdata, mulex could be stored in one latch
    latch #(32) Data_I            (clk, Data, DataLatched);
    latch #(32) CSROut_I          (clk, CSRData, CSRDataOut);
    latch #(32) MULExtResultOut_I (clk, MULExtResult, MULExtResultOut);

    extend          extend_I          (Instr[31:7], ImmSrc, ImmExt);
    store_alignment store_alignment_I (mem_addr[1:0], STOREop, A2, mem_wdata, wmask);
    load_alignment  load_alignment_I  (mem_addr_align_latch, LOADop, mem_rdata, Data);

    mux3 #(32) SrcA_I   (PC, OldPC,      A1 /* Rd1 */, ALUSrcA, SrcA);
    mux3 #(32) SrcB_I   (A2 /* Rd2 */, ImmExt, 32'd 4, ALUSrcB, SrcB);

    alu alu_I(SrcA, SrcB, ALUControl, ALUResult, Zero);

    mux2 #(32) mul_ext_I  (MULResult, DIVResult, !mul_valid, MULExtResult);
    multiplier mul_I      (clk, resetn, SrcA, SrcB, MULop, MULResult, mul_valid, mul_ready);
    divider    div_I      (clk, resetn, SrcA, SrcB, DIVop, DIVResult, div_valid, div_ready, div_by_zero_err /* todo: */);

    csr_unit csr_unit_I(clk, resetn, IRWrite, ImmExt[11:0], CSRop, CSRData);

endmodule
