/*
 *  kianv c simulation RISC-V
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
#include <errno.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <termios.h>
#include <unistd.h>

#define SB(offset, data) *(uint8_t *)(memory + offset) = data
#define SH(offset, data) *(uint16_t *)(memory + offset) = data
#define SW(offset, data) *(uint32_t *)(memory + offset) = data

#define LB(offset) *(int8_t *)(memory + offset)
#define LH(offset) *(int16_t *)(memory + offset)
#define LW(offset) *(uint32_t *)(memory + offset)
#define LBU(offset) *(uint8_t *)(memory + offset)
#define LHU(offset) *(uint16_t *)(memory + offset)

#define MEM_SIZE (1024 * 1024 * 32)
#define EXCEPTION(l)                                                           \
  do {                                                                         \
    printf("Exception found in %d\n", l);                                      \
    for (;;)                                                                   \
      ;                                                                        \
  } while (0)

typedef enum {
  kLoad = 0b0000011,
  kStore = 0b0100011,
  kRtype = 0b0110011,
  kItype = 0b0010011,
  kJal = 0b1101111,
  kJalr = 0b1100111,
  kBranch = 0b1100011,
  kLui = 0b0110111,
  kAupic = 0b0010111,
  kSystem = 0b1110011,
  kIllegal = -1
} OP_t;

typedef enum {
  ALU_CTRL_ADD_ADDI,
  ALU_CTRL_SUB,
  ALU_CTRL_XOR_XORI,
  ALU_CTRL_OR_ORI,
  ALU_CTRL_AND_ANDI,
  ALU_CTRL_SLL_SLLI,
  ALU_CTRL_SRL_SRLI,
  ALU_CTRL_SRA_SRAI,
  ALU_CTRL_SLT_SLTI,
  ALU_CTRL_SLTU_SLTIU,
  ALU_CTRL_LUI,
  ALU_CTRL_AUIPC,
  ALU_CTRL_BEQ,
  ALU_CTRL_BNE,
  ALU_CTRL_BLT,
  ALU_CTRL_BGE,
  ALU_CTRL_BLTU,
  ALU_CTRL_BGEU
} AluControl_t;

typedef enum {
  ALU_OP_ADD,
  ALU_OP_SUB,
  ALU_OP_ARITH_LOGIC,
  ALU_OP_LUI,
  ALU_OP_AUIPC,
  ALU_OP_BRANCH
} AluOp_t;

typedef enum { RTYPE, ITYPE, STYPE, BTYPE, UTYPE, JTYPE } IMMSRC_t;

uint8_t *memory;
uint32_t test_memory;
uint32_t RegisterFile[32];
uint32_t PC;

static void ResetKeyboardTerm() {
  struct termios term;
  tcgetattr(0, &term);
  term.c_lflag |= ICANON | ECHO;
  tcsetattr(0, TCSANOW, &term);
}

void SetKeyboardTerm() {
  struct termios term;
  tcgetattr(0, &term);
  term.c_lflag &= ~(ICANON | ECHO);
  tcsetattr(0, TCSANOW, &term);
}

uint32_t MEMORY_IOMEM_LOAD(uint32_t addr) {
  //   printf("LOAD MEMORY_IOMEM:%08x\n", addr);
  if (addr == 0x10000000) {
    return test_memory;
  } else if (addr == 0x30000000) {
    return 1;
  } else if (addr == 0x3000003C) {
    char c;
    read(fileno(stdin), (char *)&c, 1) > 0 ? c : EOF;
    return c == EOF ? ~0 : c;
  } else {
    printf("read to none supported hw address:%08x\n", addr);
    EXCEPTION(__LINE__);
  }
  return 0;
}

void MEMORY_IOMEM_STORE(uint32_t addr, uint32_t data) {
  if (addr == 0x10000000) {
    test_memory = (test_memory << 8) | (data & 0xff);
  } else if (addr == 0x30000000) {
    printf("%c", data);
    fflush(stdout);
  } else {
    printf("write to none supported hw address:%08x\n", addr);
    EXCEPTION(__LINE__);
  }
}

void ebreak() {
  if ((test_memory & 0x00ffffff) == 0x4f4b0a)
    printf("passed\n");
  else
    printf("failed\n");
  fflush(stdout);
  exit(0);
}

uint32_t GetMask(uint32_t n) { return 0xffffffffUL >> (32 - n); }

uint32_t GetBits(uint32_t v, uint32_t h, uint32_t l) {
  uint32_t len = h - l + 1;
  return ((v >> l) & GetMask(len));
}

uint32_t GetBit(uint32_t v, uint32_t n) { return (v >> n) & 0x01; }

uint32_t RegisterFile[32];

void execute(uint32_t instr) {
  uint32_t rs1 = GetBits(instr, 19, 15);
  uint32_t rs2 = GetBits(instr, 24, 20);
  uint32_t rd = GetBits(instr, 11, 7);

  uint32_t op = GetBits(instr, 6, 0);
  uint32_t funct3 = GetBits(instr, 14, 12);
  uint32_t funct7b5 = GetBit(instr, 30);
  uint32_t funct7b1 = GetBit(instr, 25);
  uint32_t opbit5 = GetBit(op, 5);

  bool is_load = false;
  bool is_store = false;
  bool is_rtype = false;
  bool is_itype = false;
  bool is_jal = false;
  bool is_jalr = false;
  bool is_branch = false;
  bool is_lui = false;
  bool is_auipc = false;
  bool is_system = false;
  bool is_illegal = false;

  AluOp_t aluOp;
  switch (op) {
  case (kLoad):
    aluOp = ALU_OP_ADD;
    is_load = true;
    break;
  case (kStore):
    aluOp = ALU_OP_ADD;
    is_store = true;
    break;
  case (kRtype):
    if (!funct7b1)
      aluOp = ALU_OP_ARITH_LOGIC;
    else {
      printf("m-extension not implemented\n");
      EXCEPTION(__LINE__);
    }
    is_rtype = true;
    break;
  case (kItype):
    aluOp = ALU_OP_ARITH_LOGIC;
    is_itype = true;
    break;
  case (kJal):
    aluOp = ALU_OP_ADD;
    is_jal = true;
    break;
  case (kJalr):
    aluOp = ALU_OP_ADD;
    is_jalr = true;
    break;
  case (kBranch):
    aluOp = ALU_OP_BRANCH;
    is_branch = true;
    break;
  case (kLui):
    aluOp = ALU_OP_LUI;
    is_lui = true;
    break;
  case (kAupic):
    aluOp = ALU_OP_AUIPC;
    is_auipc = true;
    break;
  case (kSystem):
    aluOp = ALU_OP_ADD;
    is_system = true;
    break;
  default:
    aluOp = ALU_OP_ADD;
    is_illegal = true;
  }

  IMMSRC_t ImmSrc = is_rtype                                     ? RTYPE
                    : (is_itype | is_jalr | is_load | is_system) ? ITYPE
                    : (is_store)                                 ? STYPE
                    : (is_branch)                                ? BTYPE
                    : (is_lui | is_auipc)                        ? UTYPE
                                                                 : JTYPE;

  uint32_t immext;
  uint32_t msb;
  uint32_t extend;
  uint32_t aluop;
  switch (ImmSrc) {
  case (ITYPE):
    msb = GetBit(instr, 31);
    extend = msb ? GetMask(20) : 0;
    immext = (extend << 12) | GetBits(instr, 31, 20);
    break;

  case (STYPE):
    msb = GetBit(instr, 31);
    extend = msb ? GetMask(20) : 0;
    immext = (extend << 12) | (GetBits(instr, 31, 25) << 5) |
             (GetBits(instr, 11, 7));
    break;

  case (BTYPE):
    msb = GetBit(instr, 31);
    extend = msb ? GetMask(20) : 0;
    immext = (extend << 12) | (GetBit(instr, 7) << 11) |
             (GetBits(instr, 30, 25) << 5) | (GetBits(instr, 11, 8) << 1);
    break;

  case (JTYPE):
    msb = GetBit(instr, 31);
    extend = msb ? GetMask(12) : 0;
    immext = (extend << 20) | (GetBits(instr, 19, 12) << 12) |
             (GetBit(instr, 20) << 11) | (GetBits(instr, 30, 21) << 1);
    break;

  case (UTYPE):
    msb = GetBit(instr, 31);
    immext = (GetBits(instr, 31, 12) << 12);
    break;

  case (RTYPE):
    immext = 0;
    break;

  default:
    EXCEPTION(__LINE__);
    break;
  }
  if (is_system && funct3 == 0b000 && immext == 0x01) {
    ebreak();
  }

  uint32_t imm_bit10 = GetBit(immext, 10);

  bool is_rtype_sub = opbit5 & funct7b5;
  bool is_srl_srli = (opbit5 && !funct7b5) || (!opbit5 && !imm_bit10);

  AluControl_t aluControl;
  switch (aluOp) {
  case (ALU_OP_ADD):
    aluControl = ALU_CTRL_ADD_ADDI;
    break;
  case (ALU_OP_SUB):
    aluControl = ALU_CTRL_SUB;
    break;
  case (ALU_OP_AUIPC):
    aluControl = ALU_CTRL_AUIPC;
    break;
  case (ALU_OP_LUI):
    aluControl = ALU_CTRL_LUI;
    break;
  case (ALU_OP_BRANCH):
    switch (funct3) {
    case (0b000):
      aluControl = ALU_CTRL_BEQ;
      break;
    case (0b001):
      aluControl = ALU_CTRL_BNE;
      break;
    case (0b100):
      aluControl = ALU_CTRL_BLT;
      break;
    case (0b101):
      aluControl = ALU_CTRL_BGE;
      break;
    case (0b110):
      aluControl = ALU_CTRL_BLTU;
      break;
    case (0b111):
      aluControl = ALU_CTRL_BGEU;
      break;
    default:
      EXCEPTION(__LINE__);
    }
    break;
  case (ALU_OP_ARITH_LOGIC):
    switch (funct3) {
    case (0b000):
      aluControl = is_rtype_sub ? ALU_CTRL_SUB : ALU_CTRL_ADD_ADDI;
      break;
    case (0b100):
      aluControl = ALU_CTRL_XOR_XORI;
      break;
    case (0b110):
      aluControl = ALU_CTRL_OR_ORI;
      break;
    case (0b111):
      aluControl = ALU_CTRL_AND_ANDI;
      break;
    case (0b010):
      aluControl = ALU_CTRL_SLT_SLTI;
      break;
    case (0b001):
      aluControl = ALU_CTRL_SLL_SLLI;
      break;
    case (0b011):
      aluControl = ALU_CTRL_SLTU_SLTIU;
      break;
    case (0b101):
      aluControl = is_srl_srli ? ALU_CTRL_SRL_SRLI : ALU_CTRL_SRA_SRAI;
      break;
    default:
      EXCEPTION(__LINE__);
    }
    break;
  default:
    EXCEPTION(__LINE__);
  }
  uint32_t a = is_auipc | is_jal | is_jalr ? PC : RegisterFile[rs1];
  uint32_t b = is_itype | is_load | is_store | is_auipc | is_lui ? immext
               : is_jal | is_jalr                                ? 4
                                  : RegisterFile[rs2];
  uint32_t result = 0;

  switch (aluControl) {
  case (ALU_CTRL_ADD_ADDI):
    result = a + b;
    break;
  case (ALU_CTRL_SUB):
    result = a - b;
    break;
  case (ALU_CTRL_XOR_XORI):
    result = a ^ b;
    break;
  case (ALU_CTRL_OR_ORI):
    result = a | b;
    break;
  case (ALU_CTRL_AND_ANDI):
    result = a & b;
    break;
  case (ALU_CTRL_SLL_SLLI):
    result = a << GetBits(b, 4, 0);
    break;
  case (ALU_CTRL_SRL_SRLI):
    result = a >> GetBits(b, 4, 0);
    break;
  case (ALU_CTRL_SRA_SRAI):
    result = (int32_t)(a) >> GetBits(b, 4, 0);
    break;
  case (ALU_CTRL_SLT_SLTI):
    result = (int32_t)(a) < (int32_t)(b) ? 1 : 0;
    break;
  case (ALU_CTRL_SLTU_SLTIU):
    result = (a < b) ? 1 : 0;
    break;
  case (ALU_CTRL_LUI):
    result = b;
    break;
  case (ALU_CTRL_AUIPC):
    result = a + b;
    break;
  case (ALU_CTRL_BEQ):
    result = a == b;
    break;
  case (ALU_CTRL_BNE):
    result = a != b;
    break;
  case (ALU_CTRL_BLT):
    result = (int32_t)(a) < (int32_t)(b);
    break;
  case (ALU_CTRL_BGE):
    result = (int32_t)(a) >= (int32_t)(b);
    break;
  case (ALU_CTRL_BLTU):
    result = a < b ? 1 : 0;
    break;
  case (ALU_CTRL_BGEU):
    result = a >= b ? 1 : 0;
    break;
  default:
    EXCEPTION(__LINE__);
    result = 0;
    break;
  }
  bool zero = result == 0;

  bool is_lb = funct3 == 0b000;
  bool is_lh = funct3 == 0b001;
  bool is_lw = funct3 == 0b010;
  bool is_lbu = funct3 == 0b100;
  bool is_lhu = funct3 == 0b101;

  bool is_sb = funct3 == 0b00;
  bool is_sh = funct3 == 0b01;
  bool is_sw = funct3 == 0b10;

  uint32_t addr = result;
  if (is_store) {
    if (addr >= 10000000) {
      if (is_sb) {
        MEMORY_IOMEM_STORE(addr, (uint8_t)RegisterFile[rs2]);
      } else if (is_sh) {
        MEMORY_IOMEM_STORE(addr, (uint16_t)RegisterFile[rs2]);
      } else if (is_sw) {
        MEMORY_IOMEM_STORE(addr, (uint32_t)RegisterFile[rs2]);
      }
    } else {
      if (is_sb) {
        SB(addr, RegisterFile[rs2]);
      } else if (is_sh) {
        SH(addr, RegisterFile[rs2]);
      } else if (is_sw) {
        SW(addr, RegisterFile[rs2]);
      }
    }
  } else if (is_load) {
    if (addr >= 10000000) {
      if (is_lb | is_lbu) {
        result = is_lb ? (uint8_t)MEMORY_IOMEM_LOAD(addr)
                       : (int16_t)MEMORY_IOMEM_LOAD(addr);
      } else if (is_lh | is_lhu) {
        result = is_lh ? (uint16_t)MEMORY_IOMEM_LOAD(addr)
                       : (int16_t)MEMORY_IOMEM_LOAD(addr);
      } else if (is_lw) {
        result = MEMORY_IOMEM_LOAD(addr);
      }
    } else {
      if (is_lb | is_lbu) {
        result = is_lb ? LB(addr) : LBU(addr);
      } else if (is_lh | is_lhu) {
        result = is_lh ? LH(addr) : LHU(addr);
      } else if (is_lw) {
        result = LW(addr);
      }
    }
  } else if (is_lui) {
  } else if (is_auipc) {
  } else if (is_jal) {
  } else if (is_jalr) {
  } else if (is_itype || is_rtype) {
  } else if (is_branch) {
  }

  if (is_rtype | is_itype | is_load | is_jal | is_jalr | is_lui | is_auipc) {
    if (rd) {
      RegisterFile[rd] = result;
    }
  }
  PC = is_jal || (is_branch && !zero) ? PC += immext
       : is_jalr                      ? RegisterFile[rs1] + immext
                                      : PC + 4;
}
uint32_t GetInstr() { return LW(PC); }
void LoadFirmware(char *firmware) {
  FILE *fp = fopen(firmware, "rb");
  fseek(fp, 0, SEEK_END);
  long size = ftell(fp);
  fseek(fp, 0, SEEK_SET);
  fread(memory, size, 1, fp);
  fclose(fp);
}

int main(int argc, char **argv) {
  atexit(ResetKeyboardTerm);
  SetKeyboardTerm();
  memory = malloc(MEM_SIZE);
  memset(memory, 0, MEM_SIZE);

  LoadFirmware("firmware.bin");

  PC = 0;
  do {
    execute(GetInstr());
  } while (1);

  return 0;
}
