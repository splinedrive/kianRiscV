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
reg [127:0] instr_ascii;
always @* begin
    instr_ascii = "";

    if (is_lui)      instr_ascii = "lui";
    if (is_auipc)    instr_ascii = "auipc";
    if (is_jal)      instr_ascii = "jal";
    if (is_jalr)     instr_ascii = "jalr";

    if (is_beq)      instr_ascii = "beq";
    if (is_bne)      instr_ascii = "bne";
    if (is_blt)      instr_ascii = "blt";
    if (is_bge)      instr_ascii = "bge";
    if (is_bltu)     instr_ascii = "bltu";
    if (is_bgeu)     instr_ascii = "bgeu";

    if (is_lb)       instr_ascii = "lb";
    if (is_lh)       instr_ascii = "lh";
    if (is_lw)       instr_ascii = "lw";
    if (is_lbu)      instr_ascii = "lbu";
    if (is_lhu)      instr_ascii = "lhu";

    if (is_sb)       instr_ascii = "sb";
    if (is_sh)       instr_ascii = "sh";
    if (is_sw)       instr_ascii = "sw";

    if (is_addi)     instr_ascii = "addi";
    if (is_slti)     instr_ascii = "slti";
    if (is_sltiu)    instr_ascii = "sltiu";
    if (is_xori)     instr_ascii = "xori";
    if (is_ori)      instr_ascii = "ori";
    if (is_andi)     instr_ascii = "andi";
    if (is_slli)     instr_ascii = "slli";
    if (is_srli)     instr_ascii = "srli";
    if (is_srai)     instr_ascii = "srai";

    if (is_add)      instr_ascii = "add";
    if (is_sub)      instr_ascii = "sub";
    if (is_sll)      instr_ascii = "sll";
    if (is_slt)      instr_ascii = "slt";
    if (is_sltu)     instr_ascii = "sltu";
    if (is_xor)      instr_ascii = "xor";
    if (is_srl)      instr_ascii = "srl";
    if (is_sra)      instr_ascii = "sra";
    if (is_or)       instr_ascii = "or";
    if (is_and)      instr_ascii = "and";

`ifdef RV32M
    if (is_mul)      instr_ascii = "mul";
    if (is_mulh)     instr_ascii = "mulh";
    if (is_mulsu)    instr_ascii = "mulsu";
    if (is_mulu)     instr_ascii = "mulu";
    if (is_div)      instr_ascii = "div";
    if (is_divu)     instr_ascii = "divu";
    if (is_rem)      instr_ascii = "rem";
    if (is_remu)     instr_ascii = "remu";
`endif

end

wire  [31:0] x0_zero = register_file_i.register_file0[31];
wire  [31:0] x1_ra   = register_file_i.register_file0[30];
wire  [31:0] x2_sp   = register_file_i.register_file0[29];
wire  [31:0] x3_gp   = register_file_i.register_file0[28];
wire  [31:0] x4_tp   = register_file_i.register_file0[27];
wire  [31:0] x5_t0   = register_file_i.register_file0[26];
wire  [31:0] x6_t1   = register_file_i.register_file0[25];
wire  [31:0] x7_t2   = register_file_i.register_file0[24];
wire  [31:0] x8_s0   = register_file_i.register_file0[23];
wire  [31:0] x9_s1   = register_file_i.register_file0[22];
wire  [31:0] x10_a0  = register_file_i.register_file0[21];
wire  [31:0] x11_a1  = register_file_i.register_file0[20];
wire  [31:0] x12_a2  = register_file_i.register_file0[19];
wire  [31:0] x13_a3  = register_file_i.register_file0[18];
wire  [31:0] x14_a4  = register_file_i.register_file0[17];
wire  [31:0] x15_a5  = register_file_i.register_file0[16];
wire  [31:0] x16_a6  = register_file_i.register_file0[15];
wire  [31:0] x17_a7  = register_file_i.register_file0[14];
wire  [31:0] x18_s2  = register_file_i.register_file0[13];
wire  [31:0] x19_s3  = register_file_i.register_file0[12];
wire  [31:0] x20_s4  = register_file_i.register_file0[11];
wire  [31:0] x21_s5  = register_file_i.register_file0[10];
wire  [31:0] x22_s6  = register_file_i.register_file0[9];
wire  [31:0] x23_s7  = register_file_i.register_file0[8];
wire  [31:0] x24_s8  = register_file_i.register_file0[7];
wire  [31:0] x25_s9  = register_file_i.register_file0[6];
wire  [31:0] x26_s10 = register_file_i.register_file0[5];
wire  [31:0] x27_s11 = register_file_i.register_file0[4];
wire  [31:0] x28_t3  = register_file_i.register_file0[3];
wire  [31:0] x29_t4  = register_file_i.register_file0[2];
wire  [31:0] x30_t5  = register_file_i.register_file0[1];
wire  [31:0] x31_t6  = register_file_i.register_file0[0];

