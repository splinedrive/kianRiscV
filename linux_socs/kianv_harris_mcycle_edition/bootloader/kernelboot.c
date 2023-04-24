/*
 *  kianv harris RISCV project
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
#include "stdlib.c"
#include <stddef.h>
#include <stdint.h>

#define SPI_ADDR_BASE 0x20000000
#define KERNEL_IMAGE (SPI_ADDR_BASE + 1024 * 1024 * 2)
#define DTB_IMAGE (SPI_ADDR_BASE + 1024 * 1024 * 7)
#define BINARY_SRC (SPI_ADDR_BASE + 1024 * 1024 * 2)
#define SDRAM_START (0x80000000)
#define SDRAM_END (0x80000000 + 1024 * 1024 * 32)
#define DTB_TARGET (SDRAM_END - 2048)

uint32_t crc32_table[256];

void generate_crc32_table() {
  uint32_t polynomial = 0x04C11DB7;
  for (uint32_t i = 0; i < 256; i++) {
    uint32_t crc = i << 24;
    for (int j = 0; j < 8; j++) {
      crc = (crc << 1) ^ ((crc & 0x80000000) ? polynomial : 0);
    }
    crc32_table[i] = crc;
  }
}

uint32_t crc32(uint8_t *data, size_t len) {
  uint32_t crc = 0xFFFFFFFF;
  for (size_t i = 0; i < len; i++) {
    uint8_t index = (crc >> 24) ^ data[i];
    crc = (crc << 8) ^ crc32_table[index];
  }
  return ~crc;
}

typedef void (*func_ptr)(int, char *);
void main() {
  // function_ptr_t kernel_entry = (function_ptr_t) SDRAM_START;
  // memset(SDRAM_START, 1, 1024*1024*32);
  generate_crc32_table();
  printf("\nKianV RISC-V Linux SOC\n");
  printf("----------------------\n");
  printf("loading kernel Image from flash...\n");
  memcpy(SDRAM_START, KERNEL_IMAGE, 1024 * 1024 * 4);
  printf("loading dtb Image from flash...\n");
  memcpy(DTB_TARGET, DTB_IMAGE, 2048);
  // uint32_t *q = (volatile uint32_t *) (DTB_TARGET);
  //  putchar(13);
  //  printf("(DTB START):0x");
  //  print_hex(*q, 8);
  uint32_t crc_32;
  crc_32 = crc32(SDRAM_START, 4 * 1024 * 1024);
  printf("\nCRC-32 checksum of kernel: 0x");
  print_hex(crc_32, 8);
  putchar(13);
  crc_32 = crc32(DTB_TARGET, 2048);
  printf("CRC-32 checksum of DTB   : 0x");
  print_hex(crc_32, 8);
  putchar(13);
  printf("\nstarting kernel at 0x80000000...\n");

  int hartId = 0;
  char *dtb = (char *)DTB_IMAGE;
  void *kernel = (void *)SDRAM_START;
  func_ptr kernel_entry = (func_ptr)kernel;
  kernel_entry(hartId, dtb);
}
