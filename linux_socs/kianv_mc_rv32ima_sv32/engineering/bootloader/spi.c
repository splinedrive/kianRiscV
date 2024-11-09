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

#include "spi.h"
#include <stdint.h>

// Define the SPI base address and assign control/data pointers
static spi_regs_t spi = {(volatile uint32_t *)0x10500000,
                         (volatile uint32_t *)0x10500004};

//-----------------------------------------------------------------
// spi_init: Initialise SPI master (empty in this example as no init needed)
//-----------------------------------------------------------------
void spi_init(void) {
  // Initialization routine can be added here if required.
}

//-----------------------------------------------------------------
// spi_cs: Set chip select
//-----------------------------------------------------------------
void spi_cs(uint32_t value) {
  *spi.ctrl = !value; // Set the chip select directly
}

//-----------------------------------------------------------------
// spi_xfer: Perform SPI transfer of a single byte
//-----------------------------------------------------------------
int spi_xfer(uint8_t *tx, uint8_t *rx) {
  // Wait until SPI is ready
  while ((*spi.ctrl & 0x80000000) != 0)
    ;

  // Send data (or 0 if tx is NULL)
  *spi.data = (tx) ? *tx : 0;

  // Wait until SPI transfer completes
  while ((*spi.ctrl & 0x80000000) != 0)
    ;

  // Retrieve received data if rx is not NULL
  if (rx) {
    *rx = (uint8_t)(*spi.data);
  }

  return 0;
}

//-----------------------------------------------------------------
// spi_sendrecv: Send or receive a character
//-----------------------------------------------------------------
uint8_t spi_sendrecv(uint8_t data) {
  uint8_t rx;
  spi_xfer(&data, &rx); // Send data and retrieve received data
  return rx;
}

//-----------------------------------------------------------------
// spi_readblock: Read a block of data from a device
//-----------------------------------------------------------------
void spi_readblock(uint8_t *ptr, int length) {
  for (int i = 0; i < length; i++) {
    *ptr++ = spi_sendrecv(0xFF); // Send 0xFF to read each byte
  }
}

//-----------------------------------------------------------------
// spi_writeblock: Write a block of data to a device
//-----------------------------------------------------------------
void spi_writeblock(uint8_t *ptr, int length) {
  for (int i = 0; i < length; i++) {
    spi_sendrecv(*ptr++); // Write each byte from the data pointer
  }
}
