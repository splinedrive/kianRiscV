/*
 *  kianv harris RISCV project
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
#include "stdlib.c"
#include <stddef.h>
#include <stdint.h>

#define DTB_TARGET (SPI_ADDR_BASE + (1024*1024 + 512*1024))
#define KERNEL_IMAGE (SPI_ADDR_BASE + 1024 * 1024 * 2)
#define MEMORY_BASE 0x80000000
#define MEMORY_SIZE (1024*1024*7 - (1024*64))
#define PROGRESS_INTERVAL (512*1024)
#define SDRAM_END (0x80000000 + 1024 * 1024 * 8)
#define SDRAM_START (0x80000000)
#define SPI_ADDR_BASE 0x20000000


typedef void (*func_ptr)(int, char *);
#define CHUNK_SIZE  (512 * 1024)

void* memcpy_verbose(void* dest, const void* src, size_t count) {
    char* d = (char*)dest;
    const char* s = (const char*)src;

    for (size_t i = 0; i < count; i++) {
        if (i % CHUNK_SIZE == 0) {

            printf(".");
        }
        d[i] = s[i];
    }

    return dest;
}

int main() {
  uint32_t freq = CPU_FREQ;
  *((volatile uint32_t *) 0x10000010) = ((freq/10000) << 16) | (freq/BAUDRATE);
#if defined(SOC_HAS_SPI)
#if SOC_HAS_SPI == 1
  *((volatile uint32_t *) 0x10500010) = (freq/SPI_FREQ);
#endif
#endif

  printf("\nKianV RISC-V uLinux ASIC Tiny Tapeout SOC\n");
  printf("-----------------------------------------\n");


  printf("loading kernel Image from flash ");
  memcpy_verbose(SDRAM_START, KERNEL_IMAGE, IMAGE_SIZE);
  printf("\nstarting kernel\n");

  int hartId = 0;
  char *dtb = (char *)DTB_TARGET;
  void *kernel = (void *)SDRAM_START;
  func_ptr kernel_entry = (func_ptr)kernel;
  kernel_entry(hartId, dtb);
}
