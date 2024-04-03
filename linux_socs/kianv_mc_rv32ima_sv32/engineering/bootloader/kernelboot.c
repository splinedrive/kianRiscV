/*
 *  kianv harris RISCV project
 *
 *  copyright (c) 2023/2024 hirosh dabui <hirosh@dabui.de>
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

#include <stdint.h>
#include "sdcard.c"
#include "stdlib.c"
#include <stddef.h>

#define COLOR_RED "\x1b[31m"
#define COLOR_GREEN "\x1b[32m"
#define COLOR_YELLOW "\x1b[33m"
#define COLOR_BLUE "\x1b[34m"
#define COLOR_PURPLE "\x1b[35m"
#define COLOR_RESET "\x1b[0m"

#define SPI_ADDR_BASE 0x20000000
#define KERNEL_IMAGE (SPI_ADDR_BASE + 1024 * 1024 * 1)
#define DTB_IMAGE (SPI_ADDR_BASE + 1024 * 1024 / 2)
#define SDRAM_START (0x80000000)
#define SDRAM_END (SDRAM_START + 1024 * 1024 * 32); // - (1024 * 8))
#define DTB_TARGET SDRAM_END
#define IMAGE_MB_SIZE 12

typedef void (*func_ptr)(int, char *);

#define CHUNK_SIZE (1024 * 1024)
typedef void (*func_ptr)(int, char *);

const volatile uint32_t *BASE_FREQ_ADDR = (volatile uint32_t *)0x10000014;
const uint32_t DIVISOR_1 = 5000000;
const uint32_t DIVISOR_2 = 1500000;
volatile uint32_t *HW_REGISTER_ADDR = (volatile uint32_t *)0x10000010;

struct spi_regs {
  volatile uint32_t *ctrl;
  volatile uint32_t *data;
};

struct spi_regs spi = {(volatile uint32_t *)0x10500000,
                       (volatile uint32_t *)0x10500004};

static void spi_set_cs(int cs_n) { *spi.ctrl = cs_n; /* 1 is low */ }

static int spi_xfer(char *tx, char *rx) {
  while ((*spi.ctrl & 0x80000000) != 0)
    ;
  *spi.data = (tx != NULL) ? *tx : 0;
  while ((*spi.ctrl & 0x80000000) != 0)
    ;
  if (rx != NULL) {
    *rx = (char)(*spi.data);
  }

  return 0;
}

uint8_t SPI_transfer(char tx) {
  uint8_t rx;
  spi_xfer(&tx, &rx);
  return rx;
}

CS_ENABLE() { spi_set_cs(1); }

CS_DISABLE() { spi_set_cs(0); }

#define CHUNK_SIZE 512

void main() {
  //*HW_REGISTER_ADDR = ((*BASE_FREQ_ADDR / DIVISOR_1) << 16) | (*BASE_FREQ_ADDR
  /// DIVISOR_2);
  *HW_REGISTER_ADDR = (2 << 16) | (*BASE_FREQ_ADDR / DIVISOR_2);

  sleep(1);

  printf(COLOR_BLUE);
  printf(
      "\nKianV RISC-V Bootloader v0.1\n");
  printf(COLOR_RESET);

  /*
    printf(" __  __ __               ___ ___ _____   __\n");
    printf("|  |/  |__|.---.-.-----.|   |   |     |_|__|.-----.--.--.--.--.\n");
    printf("|     <|  ||  _  |     ||   |   |       |  ||     |  |  |_   _|\n");
    printf("|__|\\__|__||___._|__|__| \\_____/|_______|__||__|__|_____|__.__|\n\n\n");
    */

  printf(COLOR_YELLOW);
    printf("  _  ___         __      __  _____  _       __      __   _______      ______ ___  \n");
    printf(" | |/ (_)        \\ \\    / / |  __ \\(_)      \\ \\    / /  / ____\\ \\    / /___ \\__ \\ \n");
    printf(" | ' / _  __ _ _ _\\ \\  / /  | |__) |_ ___  __\\ \\  / /  | (___  \\ \\  / /  __) | ) |\n");
    printf(" |  < | |/ _` | '_ \\ \\/ /   |  _  /| / __|/ __\\ \\/ /    \\___ \\  \\ \\/ /  |__ < / / \n");
    printf(" | . \\| | (_| | | | \\  /    | | \\ \\| \\__ \\ (__ \\  /     ____) |  \\  /   ___) / /_ \n");
    printf(" |_|\\_\\_|\\__,_|_| |_|\\/     |_|  \\_\\_|___/\\___| \\/     |_____/    \\/   |____/____|\n\n\n");
  printf(COLOR_RESET);

  char spinner[] = "|/-\\";
  int spinIndex = 0;

  do {
    printf("\0337");
    printf(" ");
    static char spinner[] = "|/-\\";
    static int spinIndex = 0;
    printf("Insert SD CARD %c", spinner[spinIndex]);
    sleep(1);

    if (SD_init() == SD_SUCCESS) {
      printf("\033[K");
      printf("\rSD Card initialized.\n");
      break;
    } else {
      printf("\0338");
    }

    spinIndex = (spinIndex + 1) % 4;
  } while (1);

  sleep(2);
  printf(COLOR_PURPLE "Loading RLE kernel image from sd storage...\n" COLOR_RESET);

  uint8_t buffer[CHUNK_SIZE];
  uint8_t token;
  uint8_t res[5];

  int block = 0;
  int pos = 0;
  unsigned char *sdram_ptr = (unsigned char *)SDRAM_START;
  for (int i = 0; i < IMAGE_MB_SIZE * 1024 * 1024; i += 512) {
    res[0] = SD_readSingleBlock(2048 + block++, buffer, &token);

    if (SD_R1_NO_ERROR(res[0]) && (token == 0xFE)) {
      for (size_t j = 0; j < CHUNK_SIZE; j += 2) {
        unsigned char value = buffer[j];
        unsigned char count = buffer[j + 1];

        if (count == 0) {
          printf("\n");
          goto eoi;
        }

        for (unsigned char k = 0; k < count; ++k) {
          *(sdram_ptr + pos++) = value;
        }
      }

      if (i % (1024 * 1024) == 0) {
        printf("\033[s");
        printf(COLOR_GREEN "Loaded %d MiB" COLOR_RESET, i / (1024 * 1024));
        printf("\033[u");
      }
    } else {
      printf("\nError reading sector\r\n");
      break;
    }
  }
eoi:
  printf("decompressed RLE data:%d\n", pos);

  ((func_ptr)SDRAM_START)(0, 0);
}
