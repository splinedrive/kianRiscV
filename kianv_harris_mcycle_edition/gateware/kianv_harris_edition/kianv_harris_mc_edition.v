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
module kianv_harris_mc_edition
    #(
         parameter STACKADDR = 32'h ffff_ffff,
         parameter RESET_ADDR = 0
     )
     (
         input  wire clk,
         input  wire resetn,
         output wire         mem_valid,
         input  wire         mem_ready,
         output wire [ 3: 0] mem_wstrb,
         output wire [31: 0] mem_addr,
         output wire [31: 0] mem_wdata,
         input  wire [31: 0] mem_rdata,
         output wire [31: 0] PC
     );

    wire [31: 0] Instr;
    wire [ 6: 0] op;
    wire [ 2: 0] funct3;
    wire [ 0: 0] funct7b5;
    wire [ 0: 0] funct7b1;
    wire [ 0: 0] immb10;

    wire Zero;

    wire [`RESULT_WIDTH    -1: 0] ResultSrc;
    wire [`ALU_CTRL_WIDTH  -1: 0] ALUControl;
    wire [`SRCA_WIDTH      -1: 0] ALUSrcA;
    wire [`SRCB_WIDTH      -1: 0] ALUSrcB;
    wire [                  2: 0] ImmSrc;
    wire [`STORE_OP_WIDTH  -1: 0] STOREop;
    wire [`LOAD_OP_WIDTH   -1: 0] LOADop;
    wire [`MUL_OP_WIDTH    -1: 0] MULop;
    wire [`DIV_OP_WIDTH    -1: 0] DIVop;
    wire [`CSR_OP_WIDTH    -1: 0] CSRop;

    wire RegWrite;
    wire PCWrite;
    wire AdrSrc;
    wire MemWrite;
    wire IRWrite;
    wire ALUOutWrite;

    wire mul_valid;
    wire mul_ready;
    wire div_valid;
    wire div_ready;

    assign op       = Instr[ 6: 0];
    assign funct3   = Instr[14:12];
    assign funct7b5 = Instr[30];  // r-type
    assign funct7b1 = Instr[25];  // r-type

    control_unit control_unit_I
                 (
                     .clk          ( clk         ),
                     .resetn       ( resetn      ),
                     .op           ( op          ),
                     .funct3       ( funct3      ),
                     .funct7b5     ( funct7b5    ),
                     .funct7b1     ( funct7b1    ),
                     .immb10       ( immb10      ),
                     .Zero         ( Zero        ),
                     .ResultSrc    ( ResultSrc   ),
                     .ALUControl   ( ALUControl  ),
                     .ALUSrcA      ( ALUSrcA     ),
                     .ALUSrcB      ( ALUSrcB     ),
                     .ImmSrc       ( ImmSrc      ),
                     .STOREop      ( STOREop     ),
                     .LOADop       ( LOADop      ),
                     .CSRop        ( CSRop       ),
                     .RegWrite     ( RegWrite    ),
                     .PCWrite      ( PCWrite     ),
                     .AdrSrc       ( AdrSrc      ),
                     .MemWrite     ( MemWrite    ),
                     .IRWrite      ( IRWrite     ),
                     .ALUOutWrite  ( ALUOutWrite ),
                     .mem_valid    ( mem_valid   ),
                     .mem_ready    ( mem_ready   ),
                     .MULop        ( MULop       ),
                     .mul_valid    ( mul_valid   ),
                     .mul_ready    ( mul_ready   ),
                     .DIVop        ( DIVop       ),
                     .div_valid    ( div_valid   ),
                     .div_ready    ( div_ready   )
                 );

    datapath_unit #(
                      .STACKADDR ( STACKADDR  ),
                      .RESET_ADDR( RESET_ADDR )
                  )
                  datapath_unit_I
                  (
                      .clk             ( clk             ),
                      .resetn          ( resetn          ),

                      .ResultSrc       (  ResultSrc      ),
                      .ALUControl      (  ALUControl     ),
                      .ALUSrcA         (  ALUSrcA        ),
                      .ALUSrcB         (  ALUSrcB        ),
                      .ImmSrc          (  ImmSrc         ),
                      .STOREop         (  STOREop        ),
                      .LOADop          (  LOADop         ),
                      .CSRop           (  CSRop          ),
                      .Zero            (  Zero           ),
                      .immb10          (  immb10         ),

                      .RegWrite        (  RegWrite       ),
                      .PCWrite         (  PCWrite        ),
                      .AdrSrc          (  AdrSrc         ),
                      .MemWrite        (  MemWrite       ),
                      .IRWrite         (  IRWrite        ),
                      .ALUOutWrite     (  ALUOutWrite    ),
                      .Instr           (  Instr          ),

                      .mem_wstrb       (  mem_wstrb      ),
                      .mem_addr        (  mem_addr       ),
                      .mem_wdata       (  mem_wdata      ),
                      .mem_rdata       (  mem_rdata      ),

                      .MULop           (  MULop          ),
                      .mul_valid       (  mul_valid      ),
                      .mul_ready       (  mul_ready      ),
                      .DIVop           (  DIVop          ),
                      .div_valid       (  div_valid      ),
                      .div_ready       (  div_ready      ),
                      .ProgCounter     (  PC             )
                  );
endmodule
