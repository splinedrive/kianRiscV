// borrowed from https://github.com/ryanj1234
// adjusted for kianV SoC by hirosh dabui <hirosh@dabui.de>
#include "sdcard.h"
extern uint8_t SPI_transfer(char tx);
/*******************************************************************************
 Initialize SD card
*******************************************************************************/
uint8_t SD_init() {
  uint8_t res[5], cmdAttempts = 0;

  SD_powerUpSeq();

  while ((res[0] = SD_goIdleState()) != SD_IN_IDLE_STATE) {
    cmdAttempts++;
    if (cmdAttempts == CMD0_MAX_ATTEMPTS) {
      return SD_ERROR;
    }
  }

  _delay_ms(1);

  SD_sendIfCond(res);
  if (res[0] != SD_IN_IDLE_STATE) {
    return SD_ERROR;
  }

  if (res[4] != 0xAA) {
    return SD_ERROR;
  }

  cmdAttempts = 0;
  do {
    if (cmdAttempts == CMD55_MAX_ATTEMPTS) {
      return SD_ERROR;
    }

    res[0] = SD_sendApp();
    if (SD_R1_NO_ERROR(res[0])) {
      res[0] = SD_sendOpCond();
    }

    _delay_ms(1);

    cmdAttempts++;
  } while (res[0] != SD_READY);

  _delay_ms(1);

  SD_readOCR(res);

  return SD_SUCCESS;
}

/*******************************************************************************
 Run power up sequence
*******************************************************************************/
void SD_powerUpSeq() {
  // make sure card is deselected
  CS_DISABLE();

  // give SD card time to power up
  _delay_ms(10);

  // select SD card
  SPI_transfer(0xFF);
  CS_DISABLE();

  // send 80 clock cycles to synchronize
  for (uint8_t i = 0; i < SD_INIT_CYCLES; i++)
    SPI_transfer(0xFF);
}

/*******************************************************************************
 Send command to SD card
*******************************************************************************/
void SD_command(uint8_t cmd, uint32_t arg, uint8_t crc) {
  // transmit command to sd card
  SPI_transfer(cmd | 0x40);

  // transmit argument
  SPI_transfer((uint8_t)(arg >> 24));
  SPI_transfer((uint8_t)(arg >> 16));
  SPI_transfer((uint8_t)(arg >> 8));
  SPI_transfer((uint8_t)(arg));

  // transmit crc
  SPI_transfer(crc | 0x01);
}

/*******************************************************************************
 Read R1 from SD card
*******************************************************************************/
uint8_t SD_readRes1() {
  uint8_t i = 0, res1;

  // keep polling until actual data received
  while ((res1 = SPI_transfer(0xFF)) == 0xFF) {
    i++;

    // if no data received for 8 bytes, break
    if (i > 8)
      break;
  }

  return res1;
}

/*******************************************************************************
 Read R2 from SD card
*******************************************************************************/
void SD_readRes2(uint8_t *res) {
  // read response 1 in R2
  res[0] = SD_readRes1();

  // read final byte of response
  res[1] = SPI_transfer(0xFF);
}

/*******************************************************************************
 Read R3 from SD card
*******************************************************************************/
void SD_readRes3(uint8_t *res) {
  // read response 1 in R3
  res[0] = SD_readRes1();

  // if error reading R1, return
  if (res[0] > 1)
    return;

  // read remaining bytes
  SD_readBytes(res + 1, R3_BYTES);
}

/*******************************************************************************
 Read R7 from SD card
*******************************************************************************/
void SD_readRes7(uint8_t *res) {
  // read response 1 in R7
  res[0] = SD_readRes1();

  // if error reading R1, return
  if (res[0] > 1)
    return;

  // read remaining bytes
  SD_readBytes(res + 1, R7_BYTES);
}

/*******************************************************************************
 Read specified number of bytes from SD card
*******************************************************************************/
void SD_readBytes(uint8_t *res, uint8_t n) {
  while (n--)
    *res++ = SPI_transfer(0xFF);
}

/*******************************************************************************
 Command Idle State (CMD0)
*******************************************************************************/
uint8_t SD_goIdleState() {
  // assert chip select
  SPI_transfer(0xFF);
  CS_ENABLE();
  SPI_transfer(0xFF);

  // send CMD0
  SD_command(CMD0, CMD0_ARG, CMD0_CRC);

  // read response
  uint8_t res1 = SD_readRes1();

  // deassert chip select
  SPI_transfer(0xFF);
  CS_DISABLE();
  SPI_transfer(0xFF);

  return res1;
}

/*******************************************************************************
 Send Interface Conditions (CMD8)
*******************************************************************************/
void SD_sendIfCond(uint8_t *res) {
  // assert chip select
  SPI_transfer(0xFF);
  CS_ENABLE();
  SPI_transfer(0xFF);

  // send CMD8
  SD_command(CMD8, CMD8_ARG, CMD8_CRC);

  // read response
  SD_readRes7(res);
  // SD_readBytes(res + 1, R7_BYTES);

  // deassert chip select
  SPI_transfer(0xFF);
  CS_DISABLE();
  SPI_transfer(0xFF);
}

/*******************************************************************************
 Read Status
*******************************************************************************/
void SD_sendStatus(uint8_t *res) {
  // assert chip select
  SPI_transfer(0xFF);
  CS_ENABLE();
  SPI_transfer(0xFF);

  // send CMD13
  SD_command(CMD13, CMD13_ARG, CMD13_CRC);

  // read response
  SD_readRes2(res);

  // deassert chip select
  SPI_transfer(0xFF);
  CS_DISABLE();
  SPI_transfer(0xFF);
}

/*******************************************************************************
 Read single 512 byte block
 token = 0xFE - Successful read
 token = 0x0X - Data error
 token = 0xFF - timeout
*******************************************************************************/
uint8_t SD_readSingleBlock(uint32_t addr, uint8_t *buf, uint8_t *token) {
  uint8_t res1, read;
  uint16_t readAttempts;

  // set token to none
  *token = 0xFF;

  // assert chip select
  SPI_transfer(0xFF);
  CS_ENABLE();
  SPI_transfer(0xFF);

  // send CMD17
  SD_command(CMD17, addr, CMD17_CRC);

  // read R1
  res1 = SD_readRes1();

  // if response received from card
  if (res1 != 0xFF) {
    // wait for a response token (timeout = 100ms)
    readAttempts = 0;
    while (++readAttempts != SD_MAX_READ_ATTEMPTS)
      if ((read = SPI_transfer(0xFF)) != 0xFF)
        break;

    // if response token is 0xFE
    if (read == SD_START_TOKEN) {
      // read 512 byte block
      for (uint16_t i = 0; i < SD_BLOCK_LEN; i++)
        *buf++ = SPI_transfer(0xFF);

      // read 16-bit CRC
      SPI_transfer(0xFF);
      SPI_transfer(0xFF);
    }

    // set token to card response
    *token = read;
  }

  // deassert chip select
  SPI_transfer(0xFF);
  CS_DISABLE();
  SPI_transfer(0xFF);

  return res1;
}

#define SD_MAX_WRITE_ATTEMPTS 3907

/*******************************************************************************
Write single 512 byte block
token = 0x00 - busy timeout
token = 0x05 - data accepted
token = 0xFF - response timeout
*******************************************************************************/
uint8_t SD_writeSingleBlock(uint32_t addr, uint8_t *buf, uint8_t *token) {
  uint16_t readAttempts;
  uint8_t res1, read;

  // set token to none
  *token = 0xFF;

  // assert chip select
  SPI_transfer(0xFF);
  CS_ENABLE();
  SPI_transfer(0xFF);

  // send CMD24
  SD_command(CMD24, addr, CMD24_CRC);

  // read response
  res1 = SD_readRes1();

  // if no error
  if (res1 == SD_READY) {
    // send start token
    SPI_transfer(SD_START_TOKEN);

    // write buffer to card
    for (uint16_t i = 0; i < SD_BLOCK_LEN; i++)
      SPI_transfer(buf[i]);

    // wait for a response (timeout = 250ms)
    readAttempts = 0;
    while (++readAttempts != SD_MAX_WRITE_ATTEMPTS)
      if ((read = SPI_transfer(0xFF)) != 0xFF) {
        *token = 0xFF;
        break;
      }

    // if data accepted
    if ((read & 0x1F) == 0x05) {
      // set token to data accepted
      *token = 0x05;

      // wait for write to finish (timeout = 250ms)
      readAttempts = 0;
      while (SPI_transfer(0xFF) == 0x00)
        if (++readAttempts == SD_MAX_WRITE_ATTEMPTS) {
          *token = 0x00;
          break;
        }
    }
  }

  // deassert chip select
  SPI_transfer(0xFF);
  CS_DISABLE();
  SPI_transfer(0xFF);

  return res1;
}

/*******************************************************************************
 Reads OCR from SD Card
*******************************************************************************/
void SD_readOCR(uint8_t *res) {
  // assert chip select
  SPI_transfer(0xFF);
  CS_ENABLE();
  uint8_t tmp = SPI_transfer(0xFF);

  if (tmp != 0xFF)
    while (SPI_transfer(0xFF) != 0xFF)
      ;

  // send CMD58
  SD_command(CMD58, CMD58_ARG, CMD58_CRC);

  // read response
  SD_readRes3(res);

  // deassert chip select
  SPI_transfer(0xFF);
  CS_DISABLE();
  SPI_transfer(0xFF);
}

/*******************************************************************************
 Send application command (CMD55)
*******************************************************************************/
uint8_t SD_sendApp() {
  // assert chip select
  SPI_transfer(0xFF);
  CS_ENABLE();
  SPI_transfer(0xFF);

  // send CMD0
  SD_command(CMD55, CMD55_ARG, CMD55_CRC);

  // read response
  uint8_t res1 = SD_readRes1();

  // deassert chip select
  SPI_transfer(0xFF);
  CS_DISABLE();
  SPI_transfer(0xFF);

  return res1;
}

/*******************************************************************************
 Send operating condition (ACMD41)
*******************************************************************************/
uint8_t SD_sendOpCond() {
  // assert chip select
  SPI_transfer(0xFF);
  CS_ENABLE();
  SPI_transfer(0xFF);

  // send CMD0
  SD_command(ACMD41, ACMD41_ARG, ACMD41_CRC);

  // read response
  uint8_t res1 = SD_readRes1();

  // deassert chip select
  SPI_transfer(0xFF);
  CS_DISABLE();
  SPI_transfer(0xFF);

  return res1;
}
