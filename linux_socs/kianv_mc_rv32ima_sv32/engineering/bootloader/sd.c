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

// #include <stdio.h>
#include "sd.h"
#include "custom_stdlib.h"
#include "spi.h"
#include "timer.h"

//-----------------------------------------------------------------
// Defines
//-----------------------------------------------------------------
#define CMD0_GO_IDLE_STATE 0
#define CMD1_SEND_OP_COND 1
#define CMD8_SEND_IF_COND 8
#define CMD17_READ_SINGLE_BLOCK 17
#define CMD24_WRITE_SINGLE_BLOCK 24
#define CMD32_ERASE_WR_BLK_START 32
#define CMD33_ERASE_WR_BLK_END 33
#define CMD38_ERASE 38
#define ACMD41_SD_SEND_OP_COND 41
#define CMD55_APP_CMD 55
#define CMD58_READ_OCR 58

#define CMD_START_BITS 0x40
#define CMD0_CRC 0x95
#define CMD8_CRC 0x87

#define OCR_SHDC_FLAG 0x40
#define CMD_OK 0x01

#define CMD8_3V3_MODE_ARG 0x1AA

#define ACMD41_HOST_SUPPORTS_SDHC 0x40000000

#define CMD_START_OF_BLOCK 0xFE
#define CMD_DATA_ACCEPTED 0x05

#define MAX_RETRIES 2

//-----------------------------------------------------------------
// Locals
//-----------------------------------------------------------------
static int _sdhc_card = 0;

//-----------------------------------------------------------------
// _sd_send_command: Send a command to the SD card over SPI
//-----------------------------------------------------------------
static uint8_t _sd_send_command(uint8_t cmd, uint32_t arg) {
  uint8_t response = 0xFF;
  uint8_t status;
  t_time tStart;

  // If non-SDHC card, use byte addressing rather than block (512) addressing
  if (_sdhc_card == 0) {
    switch (cmd) {
    case CMD17_READ_SINGLE_BLOCK:
    case CMD24_WRITE_SINGLE_BLOCK:
    case CMD32_ERASE_WR_BLK_START:
    case CMD33_ERASE_WR_BLK_END:
      arg *= 512;
      break;
    }
  }

  // Send command
  spi_sendrecv(cmd | CMD_START_BITS);
  spi_sendrecv((arg >> 24));
  spi_sendrecv((arg >> 16));
  spi_sendrecv((arg >> 8));
  spi_sendrecv((arg >> 0));

  // CRC required for CMD8 (0x87) & CMD0 (0x95) - default to CMD0
  if (cmd == CMD8_SEND_IF_COND)
    spi_sendrecv(CMD8_CRC);
  else
    spi_sendrecv(CMD0_CRC);

  tStart = timer_now();

  // Wait for response (i.e MISO not held high)
  while ((response = spi_sendrecv(0xFF)) == 0xff) {
    // Timeout
    if (timer_diff(timer_now(), tStart) >= 500)
      break;
  }

  // CMD58 has a R3 response
  if (cmd == CMD58_READ_OCR && response == 0x00) {
    // Check for SDHC card
    status = spi_sendrecv(0xFF);
    if (status & OCR_SHDC_FLAG)
      _sdhc_card = 1;
    else
      _sdhc_card = 0;

    // Ignore other response bytes for now
    spi_sendrecv(0xFF);
    spi_sendrecv(0xFF);
    spi_sendrecv(0xFF);
  }

  // Additional 8 clock cycles over SPI
  spi_sendrecv(0xFF);

  return response;
}
//-----------------------------------------------------------------
// _sd_init: Initialize the SD/SDHC card in SPI mode
//-----------------------------------------------------------------
static int _sd_init(void) {
  uint8_t response;
  uint8_t sd_version;
  int retries = 0;
  int i;

  // Initial delay to allow card to power-up
  timer_sleep(100);

  spi_cs(1);

  // Send 80 SPI clock pulses before performing init
  for (i = 0; i < 10; i++)
    spi_sendrecv(0xff);

  spi_cs(0);

  // Reset to idle state (CMD0)
  retries = 0;
  do {
    response = _sd_send_command(CMD0_GO_IDLE_STATE, 0);
    if (retries++ > MAX_RETRIES) {
      spi_cs(1);
      return -1;
    }
  } while (response != CMD_OK);

  spi_sendrecv(0xff);
  spi_sendrecv(0xff);

  // Set to default to compliance with SD spec 2.x
  sd_version = 2;

  // Send CMD8 to check for SD Ver2.00 or later card
  retries = 0;
  do {
    // Request 3.3V (with check pattern)
    response = _sd_send_command(CMD8_SEND_IF_COND, CMD8_3V3_MODE_ARG);
    if (retries++ > MAX_RETRIES) {
      // No response then assume card is V1.x spec compatible
      sd_version = 1;
      break;
    }
  } while (response != CMD_OK);

  retries = 0;
  do {
    // Send CMD55 (APP_CMD) to allow ACMD to be sent
    response = _sd_send_command(CMD55_APP_CMD, 0);

    timer_sleep(100);

    // Inform attached card that SDHC support is enabled
    response =
        _sd_send_command(ACMD41_SD_SEND_OP_COND, ACMD41_HOST_SUPPORTS_SDHC);

    if (retries++ > MAX_RETRIES) {
      spi_cs(1);
      return -2;
    }
  } while (response != 0x00);

  // Query card to see if it supports SDHC mode
  if (sd_version == 2) {
    retries = 0;
    do {
      response = _sd_send_command(CMD58_READ_OCR, 0);
      if (retries++ > MAX_RETRIES)
        break;
    } while (response != 0x00);
  }
  // Standard density only
  else
    _sdhc_card = 0;

  return 0;
}
//-----------------------------------------------------------------
// sd_init: Initialize the SD/SDHC card in SPI mode
//-----------------------------------------------------------------
int sd_init(void) {
  int retries = 0;

  // Peform SD init
  while (retries++ < 3) {
    if (_sd_init() == 0)
      return 0;

    timer_sleep(500);
  }

  return -1;
}
//-----------------------------------------------------------------
// sd_readsector: Read a number of blocks from SD card
//-----------------------------------------------------------------
int sd_readsector(uint32_t start_block, uint8_t *buffer,
                  uint32_t sector_count) {
  uint8_t response;
  // uint32_t ctrl;
  t_time tStart;
  // int i;

  if (sector_count == 0)
    return 0;

  while (sector_count--) {
    // Request block read
    response = _sd_send_command(CMD17_READ_SINGLE_BLOCK, start_block++);
    if (response != 0x00) {
      printf("sd_readsector: Bad response %x\n", response);
      return 0;
    }

    tStart = timer_now();

    // Wait for start of block indicator
    while (spi_sendrecv(0xFF) != CMD_START_OF_BLOCK) {
      // Timeout
      if (timer_diff(timer_now(), tStart) >= 1000) {
        printf("sd_readsector: Timeout waiting for data ready\n");
        return 0;
      }
    }

    // Perform block read (512 bytes)
    spi_readblock(buffer, 512);

    buffer += 512;

    // Ignore 16-bit CRC
    spi_sendrecv(0xFF);
    spi_sendrecv(0xFF);

    // Additional 8 SPI clocks
    spi_sendrecv(0xFF);
  }

  return 1;
}
//-----------------------------------------------------------------
// sd_writesector: Write a number of blocks to SD card
//-----------------------------------------------------------------
int sd_writesector(uint32_t start_block, uint8_t *buffer,
                   uint32_t sector_count) {
  uint8_t response;
  t_time tStart;
  // int i;

  while (sector_count--) {
    // Request block write
    response = _sd_send_command(CMD24_WRITE_SINGLE_BLOCK, start_block++);
    if (response != 0x00) {
      printf("sd_writesector: Bad response %x\n", response);
      return 0;
    }

    // Indicate start of data transfer
    spi_sendrecv(CMD_START_OF_BLOCK);

    // Send data block
    spi_writeblock(buffer, 512);
    buffer += 512;

    // Send CRC (ignored)
    spi_sendrecv(0xff);
    spi_sendrecv(0xff);

    // Get response
    response = spi_sendrecv(0xFF);

    if ((response & 0x1f) != CMD_DATA_ACCEPTED) {
      printf("sd_writesector: Data rejected %x\n", response);
      return 0;
    }

    tStart = timer_now();

    // Wait for data write complete
    while (spi_sendrecv(0xFF) == 0) {
      // Timeout
      if (timer_diff(timer_now(), tStart) >= 1000) {
        printf("sd_writesector: Timeout waiting for data write complete\n");
        return 0;
      }
    }

    // Additional 8 SPI clocks
    spi_sendrecv(0xff);

    tStart = timer_now();

    // Wait for data write complete
    while (spi_sendrecv(0xFF) == 0) {
      // Timeout
      if (timer_diff(timer_now(), tStart) >= 1000) {
        printf("sd_writesector: Timeout waiting for return to idle\n");
        return 0;
      }
    }
  }

  return 1;
}
