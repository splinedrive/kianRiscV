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

`define RV32M
`define CSR_TIME_COUNTER
module kianv #(
           parameter integer    rv32e      = 0,
           parameter integer    rv32m      = 0, /* not used yet, use upper defines */
           parameter integer    reset_addr = 0
       ) (
           input  wire          clk,
           input  wire          resetn,

           /* memory interface */
           input  wire          mem_ready,
           input  wire          mem_valid,
           output reg  [ 3:0]   mem_wmask,
           output reg           mem_rd,
           output reg  [31:0]   mem_addr,
           output reg  [31:0]   mem_din,
           input  wire [31:0]   mem_dout,

           /* cpu signales */
           output reg  [31:0]   pc,
           output wire [ NR_CPU_STATES -1:0]   state
       );

assign state = cpu_state;

localparam REG_FILE_IDX_WIDTH = $clog2(rv32e ? 16 : 32); // don't use zero reg

// instruction memory
reg [31:0] instr;

// register file
reg rd_wr;

wire [31:0] rs1_reg_file;
wire [31:0] rs2_reg_file;
reg  [31:0] rd_reg_file;

wire [REG_FILE_IDX_WIDTH -1:0] rs1_idx;
wire [REG_FILE_IDX_WIDTH -1:0] rs2_idx;
wire [REG_FILE_IDX_WIDTH -1:0] wr_idx;

register_file #(rv32e ? 16 : 32)
              register_file_i(
                  .clk(clk),

                  .rs1_re(1'b1),
                  .rs2_re(1'b1),
                  .rd_wr(rd_wr),

                  .rd_reg_file (rd_reg_file),
                  .rs1_reg_file(rs1_reg_file),
                  .rs2_reg_file(rs2_reg_file),

                  .rs1_idx(rs1_idx),
                  .rs2_idx(rs2_idx),
                  .wr_idx (wr_idx)
              );

`ifdef CSR_TIME_COUNTER
// some csr stuff rdcycle[H], rdtime[H], rdinstret[H]
reg [63:0] cycle_counter;
reg [63:0] instr_counter;
`endif

initial begin
    $display("register_file:", REG_FILE_IDX_WIDTH);
end

// decode logic: instruction fields
wire is_r_instr = instr[6:2] == 5'b01011 ||
     instr[6:2] == 5'b01100 ||
     instr[6:2] == 5'b01110 ||
     instr[6:2] == 5'b10100
`ifdef RV32M
     || instr[6:2] == 5'b01100 // RV32M
`endif
     ;

wire is_i_instr = instr[6:2] == 5'b00000 ||
     instr[6:2] == 5'b00001 ||
     instr[6:2] == 5'b00100 ||
     instr[6:2] == 5'b00110 ||
     instr[6:2] == 5'b11001 ||
     instr[6:2] == 5'b11100 /* system */;

wire is_s_instr = instr[6:2] == 5'b01000 ||
     instr[6:2] == 5'b01001;

wire is_b_instr = instr[6:2] == 5'b11000;

wire is_u_instr = instr[6:2] == 5'b00101 ||
     instr[6:2] == 5'b01101;

wire is_j_instr = instr[6:2] == 5'b11011;

// register operations
`ifdef SIM
wire   rs1_read = is_r_instr || is_s_instr || is_b_instr || is_i_instr;
wire   rs2_read = is_r_instr || is_s_instr || is_b_instr;
// immediate
wire   imm_value = !is_r_instr;
`endif
wire   rd_wback  = is_r_instr || is_i_instr || is_u_instr || is_j_instr;

// 3 address register operation
wire [REG_FILE_IDX_WIDTH -1:0]    rs2    = instr[24:20];
wire [REG_FILE_IDX_WIDTH -1:0]    rs1    = instr[19:15];
wire [REG_FILE_IDX_WIDTH -1:0]    rd     = instr[11:7];

// register file values
assign  rs1_idx   = rs1;
assign  rs2_idx   = rs2;
assign  wr_idx    = rd;

// opcode
wire [6:0] opcode = instr[6:0];

wire [31:0] imm = is_i_instr ? { {21{instr[31]}}, instr[30:20] } :
     is_s_instr ? { {21{instr[31]}}, instr[30:25], instr[11:7] } :
     is_b_instr ? { {20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0 } :
     is_u_instr ? { instr[31:12], 12'b0 } :
     is_j_instr ? { {12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0} :
     32'b0 /* is r_instr */;

// functions
wire [6:0] funct7 = is_r_instr ? instr[31:25] : 7'b0;
wire [2:0] funct3 = is_r_instr || is_i_instr || is_s_instr || is_b_instr ? instr[14:12] : 3'b0;

// concate decoder bits
wire [12:0] decode_bits = {imm[10], funct7[5], funct7[0], funct3, opcode};

`ifdef CSR_TIME_COUNTER
// system instruction
wire is_system = decode_bits[6:0] == 7'b1110011;

// csr timer and counters
wire [11:0] csr_register = instr[31:20];
wire decode_csrs = (funct3 == 3'b 010) & is_system;

wire is_rdcycle  = decode_csrs & (csr_register == 12'h C00);
wire is_rdcycleh = decode_csrs & (csr_register == 12'h C80);

wire is_instret  = decode_csrs & (csr_register == 12'h C02);
wire is_instreth = decode_csrs & (csr_register == 12'h C82);

wire is_time     = decode_csrs & (csr_register == 12'h C01);
wire is_timeh    = decode_csrs & (csr_register == 12'h C81);

wire is_csr_timer_cnt           = is_rdcycle | is_rdcycleh |
     is_instret | is_instreth |
     is_time    | is_timeh;
`endif

// decode B-Type
wire is_beq  = decode_bits[9:0] == 10'b000_1100011;
wire is_bne  = decode_bits[9:0] == 10'b001_1100011;
wire is_blt  = decode_bits[9:0] == 10'b100_1100011;
wire is_bge  = decode_bits[9:0] == 10'b101_1100011;
wire is_bltu = decode_bits[9:0] == 10'b110_1100011;
wire is_bgeu = decode_bits[9:0] == 10'b111_1100011;

// decode U-Type
wire is_lui   = decode_bits[6:0] == 7'b0110111;
wire is_auipc = decode_bits[6:0] == 7'b0010111;

// decode J-Type
wire is_jal   = decode_bits[6:0] == 7'b1101111;
wire is_jalr  = decode_bits[9:0] == 10'b000_1100111;

// alu instructions
wire is_addi  = decode_bits[9:0] ==  10'b000_0010011;
wire is_slti  = decode_bits[9:0] ==  10'b010_0010011;
wire is_sltiu = decode_bits[9:0] ==  10'b011_0010011;
wire is_xori  = decode_bits[9:0] ==  10'b100_0010011;
wire is_ori   = decode_bits[9:0] ==  10'b110_0010011;
wire is_andi  = decode_bits[9:0] ==  10'b111_0010011;

wire [5:0] shamt = imm[5:0];
wire is_slli  = ~decode_bits[12] & (decode_bits[9:0] ==  10'b001_0010011);
wire is_srli  = ~decode_bits[12] & (decode_bits[9:0] ==  10'b101_0010011);
wire is_srai  =  decode_bits[12] & (decode_bits[9:0] ==  10'b101_0010011);
wire is_sll   =  decode_bits[11:0] ==  12'b00_001_0110011;
wire is_slt   =  decode_bits[11:0] ==  12'b00_010_0110011;
wire is_srl   =  decode_bits[11:0] ==  12'b00_101_0110011;
wire is_sra   =  decode_bits[11:0] ==  12'b10_101_0110011;

wire is_shift  = is_slli | is_srli | is_srai | is_sll | is_slt | is_srl | is_sra;
wire instr_err = is_shift & shamt[5];

wire is_add   = decode_bits[11:0] ==  12'b00_000_0110011;
wire is_sub   = decode_bits[11:0] ==  12'b10_000_0110011;
wire is_sltu  = decode_bits[11:0] ==  12'b00_011_0110011;
wire is_xor   = decode_bits[11:0] ==  12'b00_100_0110011;
wire is_or    = decode_bits[11:0] ==  12'b00_110_0110011;
wire is_and   = decode_bits[11:0] ==  12'b00_111_0110011;

`ifdef RV32M
// RV32M Multiply extension
wire is_mul   = decode_bits[11:0] == 12'b01_000_0110011;
wire is_mulh  = decode_bits[11:0] == 12'b01_001_0110011;
wire is_mulsu = decode_bits[11:0] == 12'b01_010_0110011;
wire is_mulu  = decode_bits[11:0] == 12'b01_011_0110011;
wire is_div   = decode_bits[11:0] == 12'b01_100_0110011;
wire is_divu  = decode_bits[11:0] == 12'b01_101_0110011;
wire is_rem   = decode_bits[11:0] == 12'b01_110_0110011;
wire is_remu  = decode_bits[11:0] == 12'b01_111_0110011;

wire is_mul_instr = is_mul | is_mulh | is_mulsu | is_mulu;
wire is_div_instr = is_div | is_divu | is_rem | is_remu;
`endif

// decode S-Type, store instruction
wire is_sb = decode_bits[9:0] ==  10'b000_0100011;
wire is_sh = decode_bits[9:0] ==  10'b001_0100011;
wire is_sw = decode_bits[9:0] ==  10'b010_0100011;

wire is_store = is_sb | is_sh | is_sw;

// decode I-Type, load instruction
wire is_lb  = decode_bits[9:0] ==  10'b000_0000011;
wire is_lh  = decode_bits[9:0] ==  10'b001_0000011;
wire is_lw  = decode_bits[9:0] ==  10'b010_0000011;
wire is_lbu = decode_bits[9:0] ==  10'b100_0000011;
wire is_lhu = decode_bits[9:0] ==  10'b101_0000011;

wire is_load  = is_lb | is_lbu | is_lh | is_lhu | is_lw;

// shift right arithmetic
// imm[5] != 0 slli, srliw and sraiw generate illegal instruction
wire [31:0] sltu_rslt  = {31'b0, rs1_reg_file < rs2_reg_file};
wire [31:0] sltiu_rslt = {31'b0, rs1_reg_file < imm};

wire [63:0] sext_rs1        = {{32{rs1_reg_file[31]}}, rs1_reg_file};
wire [63:0] sra_srai_rslt   = sext_rs1 >> ((is_srai) ? imm[4:0] : rs2_reg_file[4:0]);

// alu, straight :)
wire [31:0] alu_rslt =
     is_addi | is_load | is_s_instr ? rs1_reg_file + imm :
     is_andi                        ? rs1_reg_file & imm :
     is_ori                         ? rs1_reg_file | imm :
     is_xori                        ? rs1_reg_file ^ imm :
     is_slli | is_sll               ? rs1_reg_file << ((is_slli) ? imm[4:0] : rs2_reg_file[4:0]):
     is_srli | is_srl               ? rs1_reg_file >> ((is_srli) ? imm[4:0] : rs2_reg_file[4:0]):
     is_and                         ? rs1_reg_file & rs2_reg_file :
     is_or                          ? rs1_reg_file | rs2_reg_file :
     is_xor                         ? rs1_reg_file ^ rs2_reg_file :
     is_add                         ? rs1_reg_file + rs2_reg_file :
     is_sub                         ? rs1_reg_file - rs2_reg_file :
     is_sltu                        ? sltu_rslt :
     is_sltiu                       ? sltiu_rslt :
     is_lui                         ? {imm[31:12], 12'b0} :
     is_auipc                       ? pc + imm :
     is_jal                         ? pc + 32'd4 :
     is_jalr                        ? pc + 32'd4 :
     is_slt                         ? ((rs1_reg_file[31] == rs2_reg_file[31]) ?
                                       sltu_rslt : {31'b0, rs1_reg_file[31]}) :
     is_slti                        ? ((rs1_reg_file[31] == imm[31]) ?
                                       sltiu_rslt : {31'b0, rs1_reg_file[31]}) :
     is_sra | is_srai               ? sra_srai_rslt[31:0] :
`ifdef RV32M
     is_mul   | is_mulh |
     is_mulsu | is_mulu             ? mul_rslt[31:0]  :
     is_div   | is_divu             ? div_rslt[31:0]  :
     is_rem   | is_remu             ? rem_rslt[31:0]  :
`endif
     32'b0;

`ifdef RV32M
wire rs1_signed_mul = is_mulh | is_mulsu;
wire rs2_signed_mul = is_mulh;

// multiplication
reg [63:0] mul_rslt;
reg [31:0] rs1_mul_abs;
reg [31:0] rs2_mul_abs;
reg [4:0]  mul_bit;
reg mul_start;
reg mul_ready;
reg mul_valid;


localparam MUL_IDLE_BIT              = 0;
localparam MUL_CALC_BIT              = 1;
localparam MUL_VALID_BIT             = 2;

localparam MUL_IDLE                  = 1<<MUL_IDLE_BIT;
localparam MUL_CALC                  = 1<<MUL_CALC_BIT;
localparam MUL_VALID                 = 1<<MUL_VALID_BIT;

localparam NR_MUL_STATES             = 3;

(* onehot *)
reg [NR_MUL_STATES-1:0] mul_state;

wire [31:0] mul_rslt_upper_low = (is_mulh | is_mulu | is_mulsu) ? mul_rslt[63:32] : mul_rslt[31:0];
always @(posedge clk) begin
    if (!resetn) begin
        mul_state <= MUL_IDLE;
        mul_valid <= 1'b0;
        mul_ready <= 1'b0;
        mul_bit   <= 0;
    end else begin

        (* parallel_case, full_case *)
        case (1'b1)

            mul_state[MUL_IDLE_BIT]: begin
                mul_valid <= 1'b0;
                mul_ready <= 1'b1;
                if (mul_start) begin
                    mul_ready <= 1'b0;
                    rs1_mul_abs <= (rs1_signed_mul & rs1_reg_file[31]) ? ~rs1_reg_file + 1 : rs1_reg_file;
                    rs2_mul_abs <= (rs2_signed_mul & rs2_reg_file[31]) ? ~rs2_reg_file + 1 : rs2_reg_file;
                    mul_bit <= 0;
                    mul_rslt <= 0;
                    mul_state <= MUL_CALC;
                end
            end

            mul_state[MUL_CALC_BIT]: begin
                mul_rslt <= mul_rslt + ((rs1_mul_abs&{32{rs2_mul_abs[mul_bit]}})<<mul_bit);
                mul_bit <= mul_bit + 1'b1;
                if (&mul_bit) begin
                    mul_state <= MUL_VALID;
                end
            end

            mul_state[MUL_VALID_BIT]: begin
                mul_rslt <= ((rs1_signed_mul | rs2_signed_mul) & (rs1_reg_file[31] ^ rs2_reg_file[31])) ?
                ~mul_rslt_upper_low + 1 : mul_rslt_upper_low;
                mul_valid <= 1'b1;
                mul_state <= MUL_IDLE;
            end

        endcase

    end

end

// division radix-2 restoring
localparam DIV_IDLE_BIT              = 0;
localparam DIV_CALC_BIT              = 1;
localparam DIV_VALID_BIT             = 2;

localparam DIV_IDLE                  = 1<<DIV_IDLE_BIT;
localparam DIV_CALC                  = 1<<DIV_CALC_BIT;
localparam DIV_VALID                 = 1<<DIV_VALID_BIT;

localparam NR_DIV_STATES             = 3;

(* onehot *)
reg [NR_DIV_STATES-1:0] div_state;

reg [31:0] rem_rslt;
reg [31:0] tmp;
reg div_start;
reg div_ready;
reg div_valid;
reg [4:0] div_bit;

wire rs1_signed_div = is_div | is_rem;
wire rs2_signed_div = is_div | is_rem;

wire [31:0] rs1_div_abs = (rs1_signed_div & rs1_reg_file[31]) ? ~rs1_reg_file + 1 : rs1_reg_file;  // divident
wire [31:0] rs2_div_abs = (rs2_signed_div & rs2_reg_file[31]) ? ~rs2_reg_file + 1 : rs2_reg_file;  // divisor
wire div_by_zero_err = !rs2_div_abs;

reg [31:0] div_rslt;
wire [31:0] div_rslt_next = div_rslt << 1;
wire [31:0] rem_rslt_next = (rem_rslt << 1) | div_rslt[31];
wire [31:0] rem_rslt_sub_divident = rem_rslt_next - rs2_div_abs;

always @(posedge clk) begin
    if (!resetn) begin
        div_rslt <= 0;
        rem_rslt <= 0;
        div_state <= DIV_IDLE;
        div_valid <= 1'b0;
        div_ready <= 1'b0;
        div_bit <= 0;
    end else begin

        (* parallel_case, full_case *)
        case (1'b1)

            div_state[DIV_IDLE_BIT]: begin
                div_valid <= 1'b0;
                div_ready <= 1'b1;
                if (div_start) begin
                    div_ready <= 1'b0;
                    div_rslt <= rs1_div_abs;
                    rem_rslt <= 0;

                    div_bit <= 0;
                    div_state <= DIV_CALC;
                end
            end

            div_state[DIV_CALC_BIT]: begin
                div_bit <= div_bit + 1'b1;
                if (rem_rslt_sub_divident[31]) begin
                    rem_rslt <= rem_rslt_next;
                    div_rslt <= div_rslt_next | 1'b0;
                end else begin
                    rem_rslt <= rem_rslt_sub_divident;
                    div_rslt <= div_rslt_next | 1'b1;
                end

                if (&div_bit) begin
                    div_state <= DIV_VALID;
                end
            end

            div_state[DIV_VALID_BIT]: begin
                div_rslt <= ((rs1_signed_div | rs2_signed_div) & (rs1_reg_file[31] ^ rs2_reg_file[31])) ? ~div_rslt + 1 : div_rslt;
                rem_rslt <= (rs1_signed_div & rs1_reg_file[31]) ? ~rem_rslt + 1 : rem_rslt;
                div_valid <= 1'b1;
                div_state <= DIV_IDLE;
            end

        endcase

    end
end
`endif

// store memory alignment
reg [31:0] rs2_store_rslt;
reg [3:0]  mem_wmask_store;

always @* begin
    #10
     mem_wmask_store = 0;
    rs2_store_rslt  = 'hx;

    if (is_sb) begin
        rs2_store_rslt[7 :0]  = alu_rslt[1:0] == 2'b00 ? rs2_reg_file[7:0] : 'hx;
        rs2_store_rslt[15:8]  = alu_rslt[1:0] == 2'b01 ? rs2_reg_file[7:0] : 'hx;
        rs2_store_rslt[23:16] = alu_rslt[1:0] == 2'b10 ? rs2_reg_file[7:0] : 'hx;
        rs2_store_rslt[31:24] = alu_rslt[1:0] == 2'b11 ? rs2_reg_file[7:0] : 'hx;
        mem_wmask_store = 4'b0001 << alu_rslt[1:0];
    end

    if (is_sh) begin
        rs2_store_rslt[15 :0]  = ~alu_rslt[1] ? rs2_reg_file[15 :0] : 'hx;
        rs2_store_rslt[31:16]  =  alu_rslt[1] ? rs2_reg_file[31:16] : 'hx;
        mem_wmask_store = 4'b0011 << (alu_rslt[1]<<1'b1);
    end

    if (is_sw) begin
        rs2_store_rslt = rs2_reg_file;
        mem_wmask_store = 4'b1111;
    end
end

// load memory alignment
reg [31:0] rs2_load_rslt;
always @* begin
    #10
     rs2_load_rslt  = 'hx;

    if (is_lb | is_lbu) begin
        rs2_load_rslt[7:0] =
                     alu_rslt[1:0] == 2'b00 ? mem_dout[7  :0] :
                     alu_rslt[1:0] == 2'b01 ? mem_dout[15 :8] :
                     alu_rslt[1:0] == 2'b10 ? mem_dout[23:16] :
                     alu_rslt[1:0] == 2'b11 ? mem_dout[31:24] : 'hx;
        rs2_load_rslt = {is_lbu ? 24'b0 : {24{rs2_load_rslt[7]}}, rs2_load_rslt[7:0]};
    end

    if (is_lh | is_lhu) begin
        rs2_load_rslt[15:0] = ~alu_rslt[1] ? mem_dout[15  :0]  :
                               alu_rslt[1] ? mem_dout[31  :16] : 'hx;
        rs2_load_rslt = {is_lhu ? 16'b0 : {16{rs2_load_rslt[15]}}, rs2_load_rslt[15:0]};
    end

    if (is_lw) rs2_load_rslt = mem_dout;

end

`ifdef CSR_TIME_COUNTER
reg [31:0] csr_timer_cnt_result;
reg is_csr_timer_cnt_error;
always @(*) begin
    csr_timer_cnt_result   = 0;
    is_csr_timer_cnt_error = 0;
    (* parallel_case, full_case *)
    case (1'b1)
        is_rdcycle  | is_time   : csr_timer_cnt_result = cycle_counter[31:0];
        is_rdcycleh | is_timeh  : csr_timer_cnt_result = cycle_counter[63:32];

        is_instret              : csr_timer_cnt_result = instr_counter[31:0];
        is_instreth             : csr_timer_cnt_result = instr_counter[63:32];
        default:
        begin
            is_csr_timer_cnt_error     = 1'b1 & is_csr_timer_cnt;
            csr_timer_cnt_result       = 32'bx;
        end

    endcase
end
`endif

// program counter logic
wire taken_br =
     is_beq  ? rs1_reg_file == rs2_reg_file :
     is_bne  ? rs1_reg_file != rs2_reg_file :
     is_blt  ? (rs1_reg_file < rs2_reg_file)  ^ (rs1_reg_file[31] != rs2_reg_file[31]) :
     is_bge  ? (rs1_reg_file >= rs2_reg_file) ^ (rs1_reg_file[31] != rs2_reg_file[31]) :
     is_bltu ? (rs1_reg_file < rs2_reg_file) :
     is_bgeu ? (rs1_reg_file >= rs2_reg_file) :
     1'b0;

wire [31:0] next_pc =
     taken_br |
     is_jal  ? pc + imm  :
     is_jalr ? rs1_reg_file + imm :
     pc + 4;

localparam FETCH_INSTR_BIT              = 0;
localparam WAIT_INSTR_BIT               = 1;
localparam DECODE_BIT                   = 2;
localparam EXECUTE_BIT                  = 3;
localparam WRITE_BACK_BIT               = 4;
localparam NEXT_PC_BIT                  = 5;
localparam RV32M_BIT                    = 6;

localparam NR_CPU_STATES                = 7;

localparam FETCH_INSTR                  = 1 << FETCH_INSTR_BIT;
localparam WAIT_INSTR                   = 1 << WAIT_INSTR_BIT;
localparam DECODE                       = 1 << DECODE_BIT;
localparam EXECUTE                      = 1 << EXECUTE_BIT;
localparam WRITE_BACK                   = 1 << WRITE_BACK_BIT;
localparam NEXT_PC                      = 1 << NEXT_PC_BIT;
localparam RV32M                        = 1 << RV32M_BIT;

(* onehot *)
reg [NR_CPU_STATES-1:0] cpu_state;

always @* begin
    instr    = (cpu_state[WAIT_INSTR_BIT]) ? mem_dout : instr_reg;
end

reg [31:0] instr_reg;
always @(posedge clk) begin
    if (!resetn) begin
        instr_reg   <= 'hx;
        pc          <= reset_addr;
        mem_addr    <= reset_addr;

        mem_din     <= 0;
        mem_rd      <= 1'b1;
        mem_wmask   <= 4'b0;

        rd_wr       <= 1'b0;
        rd_reg_file <= 0;

`ifdef CSR_TIME_COUNTER
        // csr stuff
        cycle_counter <= 0;
        instr_counter <= 0;
`endif

        cpu_state     <= FETCH_INSTR;

    end else begin

`ifdef CSR_TIME_COUNTER
        cycle_counter <= cycle_counter + 1;
`endif

        (* parallel_case, full_case *)
        case (1'b1)

            /* fetch instruction */
            cpu_state[FETCH_INSTR_BIT]: begin
                if (mem_valid) begin
`ifdef CSR_TIME_COUNTER
                    instr_counter <= instr_counter + 1;
`endif
                    mem_rd  <= 1'b0;
                    cpu_state <= WAIT_INSTR;
                end
            end

            /* wait instruction */
            cpu_state[WAIT_INSTR_BIT]: begin
                instr_reg <= instr;
                cpu_state <= DECODE;
            end

            /* decode instruction */
            cpu_state[DECODE_BIT]: begin
                /* register file or load operation */
                mem_addr   <= alu_rslt;
                mem_rd     <= is_load;
                cpu_state  <= EXECUTE;
            end


            /* execute */
            cpu_state[EXECUTE_BIT]: begin
                mem_rd             <= is_load;
                if (!is_load || (mem_valid&is_load)) begin
`ifdef RV32M
                    (* parallel_case, full_case *)
                    case (1'b1)
                        is_mul_instr: begin
                            if (mul_ready) begin
                                mul_start <= 1'b1;
                                cpu_state <= RV32M;
                            end
                        end

                        is_div_instr: begin
                            if (div_ready) begin
                                div_start <= 1'b1;
                                cpu_state <= RV32M;
                            end
                        end

                        default:
                            cpu_state <= WRITE_BACK;
                    endcase
`else
                    cpu_state <= WRITE_BACK;
`endif
                end
            end

            /* write back */
            cpu_state[WRITE_BACK_BIT]: begin
                // data memory
                mem_rd            <= 1'b0;
                /* store memory */
                if (is_s_instr) begin
                    mem_din           <= rs2_store_rslt;

                    if (mem_ready) begin
                        mem_wmask <= mem_wmask_store;
                        cpu_state <= NEXT_PC;
                    end
                    /* register file */
                end else begin
                    rd_wr   <= rd_wback & |wr_idx; // do not write in r0

                    /* write back of csr counters, memory load or alu alu_rslt */
                    rd_reg_file <=
`ifdef CSR_TIME_COUNTER
                        is_csr_timer_cnt ? csr_timer_cnt_result :
`endif
                        is_load ? rs2_load_rslt : alu_rslt;
                    cpu_state <= NEXT_PC;
                end
            end

            /* program counter calculation */
            cpu_state[NEXT_PC_BIT]: begin
                if (!is_s_instr || (is_s_instr&mem_valid)) begin
                    mem_wmask <= 4'b0;
                    rd_wr     <= 1'b0;
                    pc        <= next_pc;
                    mem_addr  <= next_pc;

                    mem_rd    <= 1'b1;
                    cpu_state <= FETCH_INSTR;
                end

            end

`ifdef RV32M
            cpu_state[RV32M_BIT]: begin
                mul_start <= 1'b0;
                div_start <= 1'b0;
                if (mul_valid | div_valid) cpu_state <= WRITE_BACK;
            end
`endif
            default:
                cpu_state <= FETCH_INSTR;
        endcase
    end
end

`ifdef SIM
`include "kianv_debug.v"
`endif

endmodule
