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

//-----------------------------------------------------------------
// Prototypes:
//-----------------------------------------------------------------

// sd_init: Return 0 on success, non zero of failure
int sd_init(void);

// sd_writesector: Return 1 on success, 0 on failure
int sd_writesector(uint32_t sector, uint8_t *buffer, uint32_t sector_count);

// sd_readsector: Return 1 on success, 0 on failure
int sd_readsector(uint32_t sector, uint8_t *buffer, uint32_t sector_count);
