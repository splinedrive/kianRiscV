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

/*
 * No cache: every fetch/load/store is a QSPI transaction. Word copy unrolled x8 is
 * ~10x faster than bytewise.
 * Copies whole words, so may overrun the end by up to 3 bytes.
 */
static void copy_words_8(uint32_t *d, const uint32_t *s, size_t words) {
    const uint32_t *end = s + (words & ~(size_t)7);
    while (s != end) {
        uint32_t a = s[0], b = s[1], c = s[2], e = s[3], f = s[4], g = s[5], h = s[6], k = s[7];
        d[0] = a; d[1] = b; d[2] = c; d[3] = e; d[4] = f; d[5] = g; d[6] = h; d[7] = k;
        s += 8; d += 8;
    }
    for (words &= 7; words; words--)
        *d++ = *s++;
}

/* Prints a dot per CHUNK_SIZE. */
static void copy_image_verbose(void *dest, const void *src, size_t count) {
    uint32_t *d = (uint32_t *)dest;
    const uint32_t *s = (const uint32_t *)src;
    const size_t words = (count + 3) / 4, chunk = CHUNK_SIZE / 4;

    for (size_t i = 0; i < words; i += chunk) {
        printf(".");
        copy_words_8(d + i, s + i, words - i < chunk ? words - i : chunk);
    }
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
  copy_image_verbose((void *)SDRAM_START, (const void *)KERNEL_IMAGE, IMAGE_SIZE);
  printf("\nstarting kernel\n");

  int hartId = 0;
  char *dtb = (char *)DTB_TARGET;
  void *kernel = (void *)SDRAM_START;
  func_ptr kernel_entry = (func_ptr)kernel;
  kernel_entry(hartId, dtb);
}
