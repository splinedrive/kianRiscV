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
`timescale 1 ns/100 ps
`default_nettype none

`define RV32M
`define CSR_TIME_COUNTER
module kianv #(
           parameter            RV32E               = 0,
           parameter            RESET_ADDR          = 0,
           parameter            SHOW_ASSEMBLER      = 0,
           parameter            STACKADDR           = 32'h ffff_ffff
       ) (
           input  wire          clk,
           input  wire          resetn,

           /* memory interface */
           input  wire          mem_ready,
           output reg           mem_valid,
           output reg  [ 3:0]   mem_wstrb,
           output reg           mem_rd,
           output reg  [31:0]   mem_addr,
           output reg  [31:0]   mem_wdata,
           input  wire [31:0]   mem_rdata,

           /* cpu signales */
           output reg  [31:0]   pc,
           output wire [NR_CPU_STATES -1:0]   state
       );

assign state = cpu_state;

localparam REG_FILE_IDX_WIDTH = $clog2(RV32E ? 16 : 32); // don't use zero reg

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

register_file #(
                  .REGISTER_ROWS(RV32E ? 16 : 32),
                  .STACKADDR(STACKADDR)
              )
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
    $display("%m: register file width:", REG_FILE_IDX_WIDTH);
end

// decode logic: instruction fields
wire is_r_instr = instr[6:2] == 5'b01011 || instr[6:2] == 5'b01100 ||
     instr[6:2] == 5'b01110 || instr[6:2] == 5'b10100
`ifdef RV32M
     || instr[6:2] == 5'b01100 /* RV32M */
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

// RV32M Multiply extension
`ifdef RV32M
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
reg mul_valid;
reg mul_ready;


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
        mul_ready <= 1'b0;
        mul_bit   <= 0;
    end else begin

        (* parallel_case, full_case *)
        case (1'b1)

            mul_state[MUL_IDLE_BIT]: begin
                mul_ready <= 1'b0;
                if (mul_valid) begin
                    rs1_mul_abs <= (rs1_signed_mul & rs1_reg_file[31]) ? ~rs1_reg_file + 1 : rs1_reg_file;
                    rs2_mul_abs <= (rs2_signed_mul & rs2_reg_file[31]) ? ~rs2_reg_file + 1 : rs2_reg_file;
                    mul_bit <= 0;
                    mul_rslt <= 0;
                    mul_state <= MUL_CALC;
                end
            end

            mul_state[MUL_CALC_BIT]: begin
                /* verilator lint_off WIDTH */
                mul_rslt <= mul_rslt + ((rs1_mul_abs&{32{rs2_mul_abs[mul_bit]}})<<mul_bit);
                /* verilator lint_on WIDTH */
                mul_bit <= mul_bit + 1'b1;
                if (&mul_bit) begin
                    mul_state <= MUL_VALID;
                end
            end

            mul_state[MUL_VALID_BIT]: begin
                /* verilator lint_off WIDTH */
                mul_rslt <= ((rs1_signed_mul | rs2_signed_mul) & (rs1_reg_file[31] ^ rs2_reg_file[31])) ?
                ~mul_rslt_upper_low + 1 : mul_rslt_upper_low;
                /* verilator lint_on WIDTH */
                mul_ready <= 1'b1;
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
reg div_valid;
reg div_ready;
reg [4:0] div_bit;

wire rs1_signed_div = is_div | is_rem;
wire rs2_signed_div = is_div | is_rem;

wire [31:0] rs1_div_abs = (rs1_signed_div & rs1_reg_file[31]) ? ~rs1_reg_file + 1 : rs1_reg_file;  // divident
wire [31:0] rs2_div_abs = (rs2_signed_div & rs2_reg_file[31]) ? ~rs2_reg_file + 1 : rs2_reg_file;  // divisor
/* verilator lint_off WIDTH */
wire div_by_zero_err = !rs2_div_abs;
/* verilator lint_on WIDTH */

reg [31:0] div_rslt;
wire [31:0] div_rslt_next = div_rslt << 1;
/* verilator lint_off WIDTH */
wire [31:0] rem_rslt_next = (rem_rslt << 1) | div_rslt[31];
/* verilator lint_on WIDTH */
wire [31:0] rem_rslt_sub_divident = rem_rslt_next - rs2_div_abs;

always @(posedge clk) begin
    if (!resetn) begin
        div_rslt <= 0;
        rem_rslt <= 0;
        div_state <= DIV_IDLE;
        div_ready <= 1'b0;
        div_bit <= 0;
    end else begin

        (* parallel_case, full_case *)
        case (1'b1)

            div_state[DIV_IDLE_BIT]: begin
                div_ready <= 1'b0;
                if (div_valid) begin
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
                    /* verilator lint_off WIDTH */
                    div_rslt <= div_rslt_next | 1'b0;
                    /* verilator lint_on WIDTH */
                end else begin
                    rem_rslt <= rem_rslt_sub_divident;
                    /* verilator lint_off WIDTH */
                    div_rslt <= div_rslt_next | 1'b1;
                    /* verilator lint_on WIDTH */
                end

                if (&div_bit) begin
                    div_state <= DIV_VALID;
                end
            end

            div_state[DIV_VALID_BIT]: begin
                div_rslt <= ((rs1_signed_div | rs2_signed_div) & (rs1_reg_file[31] ^ rs2_reg_file[31])) ? ~div_rslt + 1 : div_rslt;
                rem_rslt <= (rs1_signed_div & rs1_reg_file[31]) ? ~rem_rslt + 1 : rem_rslt;
                div_ready <= 1'b1;
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
    mem_wmask_store = 0;
    rs2_store_rslt  = 'hx;

    if (is_sb) begin
        rs2_store_rslt[7 :0]   = alu_rslt[1:0] == 2'b00 ? rs2_reg_file[7:0] : 8'hx;
        rs2_store_rslt[15:8]   = alu_rslt[1:0] == 2'b01 ? rs2_reg_file[7:0] : 8'hx;
        rs2_store_rslt[23:16]  = alu_rslt[1:0] == 2'b10 ? rs2_reg_file[7:0] : 8'hx;
        rs2_store_rslt[31:24]  = alu_rslt[1:0] == 2'b11 ? rs2_reg_file[7:0] : 8'hx;
        mem_wmask_store        = 4'b0001 << alu_rslt[1:0];
    end

    if (is_sh) begin
        rs2_store_rslt[15: 0]  = ~alu_rslt[1] ? rs2_reg_file[15: 0] : 16'hx;
        rs2_store_rslt[31:16]  =  alu_rslt[1] ? rs2_reg_file[15: 0] : 16'hx;
        mem_wmask_store        =  alu_rslt[1] ? 4'b 1100 : 4'b 0011;
    end

    if (is_sw) begin
        rs2_store_rslt         = rs2_reg_file;
        mem_wmask_store        = 4'b1111;
    end
end

// load memory alignment
reg [31:0] load_data;
reg [31:0] rs2_load_rslt;
always @* begin
    rs2_load_rslt  = 'hx;

    if (is_lb | is_lbu) begin
        rs2_load_rslt[7:0] =
                     alu_rslt[1:0] == 2'b00 ? load_data[7  :0] :
                     alu_rslt[1:0] == 2'b01 ? load_data[15 :8] :
                     alu_rslt[1:0] == 2'b10 ? load_data[23:16] :
                     alu_rslt[1:0] == 2'b11 ? load_data[31:24] : 8'hx;
        rs2_load_rslt = {is_lbu ? 24'b0 : {24{rs2_load_rslt[7]}}, rs2_load_rslt[7:0]};
    end

    if (is_lh | is_lhu) begin
        rs2_load_rslt[15:0] = ~alu_rslt[1] ? load_data[15  :0]  :
                     alu_rslt[1] ? load_data[31  :16] : 16'hx;
        rs2_load_rslt = {is_lhu ? 16'b0 : {16{rs2_load_rslt[15]}}, rs2_load_rslt[15:0]};
    end

    if (is_lw) rs2_load_rslt = load_data;

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
     is_beq  ? rs1_reg_file == rs2_reg_file   :
     is_bne  ? rs1_reg_file != rs2_reg_file   :
     is_blt  ? (rs1_reg_file < rs2_reg_file)  ^ (rs1_reg_file[31] != rs2_reg_file[31]) :
     is_bge  ? (rs1_reg_file >= rs2_reg_file) ^ (rs1_reg_file[31] != rs2_reg_file[31]) :
     is_bltu ? (rs1_reg_file < rs2_reg_file)  :
     is_bgeu ? (rs1_reg_file >= rs2_reg_file) :
     1'b0;

wire [31:0] next_pc =
     taken_br |
     is_jal  ? pc + imm  :
     is_jalr ? rs1_reg_file + imm :
     pc + 4;

localparam FETCH_INSTR_BIT              = 0;
localparam DECODE_BIT                   = 1;
localparam EXECUTE_BIT                  = 2;
localparam WRITE_BACK_BIT               = 3;
localparam NEXT_PC_BIT                  = 4;
localparam RV32M_BIT                    = 5;

localparam NR_CPU_STATES                = 6;

localparam FETCH_INSTR                  = 1 << FETCH_INSTR_BIT;
localparam DECODE                       = 1 << DECODE_BIT;
localparam EXECUTE                      = 1 << EXECUTE_BIT;
localparam WRITE_BACK                   = 1 << WRITE_BACK_BIT;
localparam NEXT_PC                      = 1 << NEXT_PC_BIT;
localparam RV32M                        = 1 << RV32M_BIT;

(* onehot *)
reg [NR_CPU_STATES-1:0] cpu_state;

wire mem_tx_done = mem_valid & mem_ready;

reg [31:0] instr_reg;
reg mem_valid_d;
always @(posedge clk) begin
    if (!resetn) begin
        instr_reg   <= 'hx;
        pc          <= RESET_ADDR;
        mem_addr    <= RESET_ADDR;

        mem_wdata   <= 0;
        mem_rd      <= 1'b1;
        mem_wstrb   <= 4'b0;
        mem_valid   <= 0;
        mem_valid_d <= 0;
        load_data   <= 0;

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
                mem_addr      <= pc;
                mem_rd        <= 1'b1;
                mem_valid_d   <= 1'b1;
                mem_valid     <= mem_valid_d;
                if (mem_tx_done) begin
`ifdef CSR_TIME_COUNTER
                    instr_counter <= instr_counter + 1;
`endif
                    instr         <= mem_rdata;
                    mem_valid_d   <= 1'b0;
                    mem_valid     <= 1'b0;
                    mem_rd        <= 1'b0;
                    cpu_state     <= DECODE;
                end
            end

            /* decode instruction */
            cpu_state[DECODE_BIT]: begin
                /* register file or load operation */
`ifdef SIM
                if (SHOW_ASSEMBLER)
                    $display("%00000000x:%s", pc, instr_ascii);
`endif

                mem_addr    <= alu_rslt;
                mem_rd      <= is_load;
                mem_valid_d <= is_load;
                mem_valid   <= mem_valid_d;

                if (!is_load || (mem_tx_done & is_load)) begin
                    load_data     <= mem_rdata;
                    mem_rd        <= 1'b0;
                    mem_valid_d   <= 1'b0;
                    mem_valid     <= 1'b0;
                    cpu_state     <= EXECUTE;
                end

            end

            /* decode instruction */
            cpu_state[EXECUTE_BIT]: begin
`ifdef RV32M
                (* parallel_case, full_case *)
                case (1'b1)
                    is_mul_instr: begin
                        mul_valid <= 1'b1;
                        cpu_state <= RV32M;
                    end

                    is_div_instr: begin
                        div_valid <= 1'b1;
                        cpu_state <= RV32M;
                    end

                    default:
                        cpu_state <= WRITE_BACK;
                endcase
`else
                cpu_state <= WRITE_BACK;
`endif
            end

            /* write back */
            cpu_state[WRITE_BACK_BIT]: begin
                /* store memory */
                if (is_s_instr) begin
                    mem_addr          <= alu_rslt;
                    mem_wdata         <= rs2_store_rslt;
                    mem_valid         <= 1'b1;
                    mem_wstrb         <= mem_wmask_store;

                    cpu_state         <= NEXT_PC;
                end else begin
                    rd_wr   <= rd_wback & |wr_idx; // do not write in r0

                    /* write back of csr counters, memory load or alu alu_rslt */
                    rd_reg_file <=
`ifdef CSR_TIME_COUNTER
                    is_csr_timer_cnt ? csr_timer_cnt_result :
`endif
                        is_load ? rs2_load_rslt : alu_rslt;
                    cpu_state         <= NEXT_PC;
                end
            end

            /* program counter calculation */
            cpu_state[NEXT_PC_BIT]: begin
                if (!is_s_instr || (mem_tx_done & is_s_instr)) begin
                    mem_valid <= 1'b0;
                    mem_wstrb <= 4'b0;
                    rd_wr     <= 1'b0;
                    mem_rd    <= 1'b0;

                    pc        <= next_pc;

                    cpu_state <= FETCH_INSTR;
                end

            end

`ifdef RV32M
            cpu_state[RV32M_BIT]: begin
                mul_valid <= 1'b0;
                div_valid <= 1'b0;
                if (mul_ready | div_ready) cpu_state <= WRITE_BACK;
            end
`endif
            default:
                cpu_state <= FETCH_INSTR;
        endcase
    end
end

`ifdef SIM
reg [255:0] cpu_state_ascii;
always @* begin
    cpu_state_ascii   = "";

    if (state[FETCH_INSTR_BIT])      cpu_state_ascii = "FETCH";
    if (state[DECODE_BIT])           cpu_state_ascii = "DECODE";
    if (state[EXECUTE_BIT])          cpu_state_ascii = "EXECUTE";
    if (state[WRITE_BACK_BIT])       cpu_state_ascii = "WRITE_BACK";
    if (state[NEXT_PC_BIT])          cpu_state_ascii = "NEXT_PC";
    if (state[RV32M_BIT])            cpu_state_ascii = "RV32M";
end

reg [255:0] instr_ascii;

always @* begin
    instr_ascii   = "";

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

    if (is_r_instr) begin
        $sformat(instr_ascii, "%s x%0d,x%0d,x%0d    #", instr_ascii, wr_idx, rs1_idx, rs2_idx);
    end
    if (is_i_instr) begin
        if (is_load)
            $sformat(instr_ascii, "%s x%0d,%0d(x%0d)    #%x", instr_ascii, wr_idx, $signed(imm), rs1_idx, imm);
        else
            $sformat(instr_ascii, "%s x%0d,x%0d,%0d    #%x", instr_ascii, wr_idx, rs1_idx, $signed(imm), imm);
    end
    if (is_s_instr) begin
        $sformat(instr_ascii, "%s x%0d,%0d(x%0d)    #%x", instr_ascii, rs2_idx, $signed(imm), rs1_idx, imm);
    end
    if (is_b_instr) begin
        $sformat(instr_ascii, "%s x%0d,x%0d,%0d    #%x", instr_ascii, rs1_idx, rs2_idx, $signed(imm), imm);
    end
    if (is_u_instr) begin
        $sformat(instr_ascii, "%s x%0d,%0d    #%x %d", instr_ascii, wr_idx, $signed(imm >> 12), $signed(imm >> 12), $signed(imm));
    end
    if (is_j_instr) begin
        $sformat(instr_ascii, "%s x%0d,%0d    #%0x", instr_ascii, wr_idx, $signed(imm), (pc + imm));
    end
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

`endif

endmodule
