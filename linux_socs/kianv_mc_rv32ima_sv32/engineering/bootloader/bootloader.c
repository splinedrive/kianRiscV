/*
 *  kianv.v - RISC-V rv32ima
 *
 *  copyright (c) 2024 hirosh dabui <hirosh@dabui.de>
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
#include "custom_stdlib.h"
#include "kianv_io_utils.h"
#include "sd.h"
#include <stddef.h>
#include <stdint.h>

/* Hardware and Memory Addresses */
#define SPI_ADDR_BASE 0x20000000
#define KERNEL_IMAGE (SPI_ADDR_BASE + 1024 * 1024 * 1)
#define SDRAM_START 0x80000000
#define SDRAM_END (SDRAM_START + (*SDRAM_SIZE)) // Dereference SDRAM_SIZE to get size in bytes
#define IMAGE_MB_SIZE 20
#define SD_BLOCK_OFFSET (1024 * 1024 / 512)
#define CHUNK_SIZE 512

/* Frequency and Register Settings */
const volatile uint32_t* BASE_FREQ_ADDR = (volatile uint32_t*) 0x10000014;
const volatile uint32_t* const SDRAM_SIZE =
    (volatile uint32_t*) 0x10000018; // Pointer to SDRAM size register
const uint32_t DIVISOR_1 = 5000000;
const uint32_t DIVISOR_2 = 115200; // Baudrate
volatile uint32_t* HW_REGISTER_ADDR = (volatile uint32_t*) 0x10000010;

/* Type definition for function pointer */
typedef void (*func_ptr)(int, char*);

/* Clear SDRAM memory */
void clear_sdram() {
  uint32_t* sdram_ptr = (uint32_t*) SDRAM_START;
  uint32_t* sdram_end = (uint32_t*) (SDRAM_START + *SDRAM_SIZE);

  while (sdram_ptr < sdram_end) { *sdram_ptr++ = 0; }
}

/* Main Bootloader Function */
void main() {
  char spinner[] = "|/-\\";
  int spinner_index = 0;

  delay_seconds(1);

  /* Configure hardware register */
  *HW_REGISTER_ADDR = (2 << 16) | (*BASE_FREQ_ADDR / DIVISOR_2);

  /* Display Bootloader Header */
  printf(COLOR_BLUE);
  printf("\n***************************************\n");
  printf("*   KianV RISC-V RV32IMA SSTC, ZICNTR *\n");
  printf("*   SV32 RLE ROM Bootloader v0.2      *\n");
  printf("***************************************\n");
  printf(COLOR_RESET);
  clear_sdram();

  /* Wait for SD Card */
  while (1) {
    printf("\0337"); // Save cursor position
    printf(COLOR_YELLOW ">> Insert SD CARD %c" COLOR_RESET, spinner[spinner_index]);

    if (sd_init() == 0) {
      printf("\033[K\r[OK] SD Card initialized.\n");
      break;
    } else {
      printf("\0338"); // Restore cursor position
    }
    spinner_index = (spinner_index + 1) % 4;
  }

  /* Load RLE Image from SD Storage */
  printf(COLOR_PURPLE ">> Loading RLE image from SD storage...\n" COLOR_RESET);

  uint8_t buffer[CHUNK_SIZE];
  int block_index = 0;
  int sdram_offset = 0;
  unsigned char* sdram_ptr = (unsigned char*) SDRAM_START;

  for (int loaded_bytes = 0; loaded_bytes < IMAGE_MB_SIZE * 1024 * 1024;
       loaded_bytes += CHUNK_SIZE) {
    if (sd_readsector(SD_BLOCK_OFFSET + block_index++, buffer, 1)) {
      for (size_t j = 0; j < CHUNK_SIZE; j += 2) {
        unsigned char value = buffer[j];
        unsigned char count = buffer[j + 1];

        if (count == 0) {
          printf(COLOR_GREEN "[OK] Loaded RLE image: %d bytes" COLOR_RESET, loaded_bytes);
          printf("\n");
          goto end_of_image;
        }

        for (unsigned char k = 0; k < count; ++k) { *(sdram_ptr + sdram_offset++) = value; }
      }

      /* Show progress at every 1 MiB loaded */
      if (loaded_bytes % (1024 * 1024) == 0) {
        printf("\033[s"); // Save cursor position
        printf(COLOR_GREEN "Loaded %d MiB" COLOR_RESET, loaded_bytes / (1024 * 1024));
        printf("\033[u"); // Restore cursor position
      }

    } else {
      printf("\nError reading sector\r\n");
      break;
    }
  }

end_of_image:
  printf(COLOR_GREEN "[OK] Decompressed RLE image size: %d bytes\n" COLOR_RESET, sdram_offset);

  /* Execute Loaded Image */
  printf(COLOR_BOLD "\n[Executing loaded image... ]\n\n" COLOR_RESET);
  ((func_ptr) SDRAM_START)(0, 0);
}
