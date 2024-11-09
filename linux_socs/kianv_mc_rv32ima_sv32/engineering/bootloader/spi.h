/*
 * Code adapted from https://github.com/ultraembedded/fat_io_lib
 * and customized for the Kianv bootloader.
 *
 * Original library provides functionality for handling FAT file systems,
 * and this version includes modifications specific to the Kianv SoC
 * environment.
 *
 * Adjustments include compatibility with Kianv hardware registers,
 * integration with bootloader routines, and optimizations for
 * the resource constraints of the Kianv platform.
 */
#pragma once
#include <stdint.h>

typedef struct {
  volatile unsigned int *ctrl;
  volatile unsigned int *data;
} spi_regs_t;

//-----------------------------------------------------------------
// Prototypes:
//-----------------------------------------------------------------
void spi_init(void);
void spi_cs(uint32_t value);
uint8_t spi_sendrecv(uint8_t ch);
void spi_readblock(uint8_t *ptr, int length);
void spi_writeblock(uint8_t *ptr, int length);
