/*
   SPI - Serial Peripheral Interface

   Provides memory-mapped registers to control SPI connection to SD-Card
   Base address: 0x10001000

RW:     Write to RW to send 8 bits to SDO with the appropriate SCK pulses
Read from RW the last byte received at SDI
CTR:    Control the control wires:
CTR[0] = CSN: Chip Select not
CTR[1] = SCK: serial clock

register  offset  size       reset
-----------------------------------------
RW        0x00    8 bits    0x00
CTR       0x04    8 bits    0x00
*/

#define RW  0                 // read and write byte
#define CTR 4                 // control lines
#define SS  1<<0
#define SCK 1<<1

// SPI Command Defines
#define CMD0  0    // GO_IDLE_STATE
#define CMD8  8    // SEND_IF_COND
#define CMD16 16   // SET_BLOCKLEN
#define CMD17 17   // READ_SINGLE_BLOCK
#define CMD24 24   // WRITE_BLOCK
#define CMD55 55   // APP_CMD
#define CMD58 58   // READ_OCR
#define ACMD41 41  // SD_SEND_OP_COND

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "proc.h"
#include "defs.h"

#define SD_BLOCK_OFFSET  ((1024*1024*2)/512)
//#define BLOCK_OFFSET  (0)
struct spinlock sdlock;

// get the time from register mtime
unsigned long long mtime(){
  unsigned int h1, l, h2;
  asm volatile("csrr %0, 0xC80" : "=r" (h1) );
  asm volatile("csrr %0, 0xC00" : "=r" (l) );
  asm volatile("csrr %0, 0xC80" : "=r" (h2) );
  if (h1 != h2) return mtime();
  return (((unsigned long long)h1) << 32) | l;
}

// msleep given time t in microseconds
void msleep(unsigned int dt){
  dt = dt * 32;
  unsigned long long t = mtime();
  while (mtime() - t < dt);
}

struct spi_regs {
  volatile uint32 *ctrl;
  volatile uint32 *data;
};

struct spi_regs spi = {(volatile uint32 *)SDCARD0_CTRL,
  (volatile uint32 *)SDCARD0_DATA};

static void spi_set_cs(int cs_n) {
  *spi.ctrl = cs_n; // Set chip select line
}

static unsigned char spi_xfer(unsigned char *tx, unsigned char *rx) {
  while (*spi.ctrl & SDCARD0_SPI_BUSY_BIT);
  *spi.data = (tx != 0) ? *tx : 0;
  while (*spi.ctrl & SDCARD0_SPI_BUSY_BIT);
  if (rx != 0) {
    *rx = (unsigned char)(*spi.data);
  }
  return 0;
}

unsigned char SPI_transfer(unsigned char tx) {
  unsigned char rx;
  spi_xfer(&tx, &rx);
  return rx;
}

void CS_ENABLE() {
  spi_set_cs(1); // Enable chip select
}

void CS_DISABLE() {
  spi_set_cs(0); // Disable chip select
}

char rx = 0;
void WriteReg(unsigned char reg, unsigned char value) {
  if (reg == RW) {
    rx = SPI_transfer(value);
  } else if (reg == CTR) {
    if (value) CS_DISABLE(); else CS_ENABLE();
  }
}

unsigned char ReadReg(char reg) {
  return rx;
}

// writes byte c to SPI and returns the received byte
unsigned char spi_rw(unsigned char c) {
  WriteReg(RW, c);
  return ReadReg(RW);
}

// returns the CRC16 checksum
int getCRC16(unsigned char message[], int length) {
  int i, j, crc = 0x0000;
  for (i = 0; i < length; i++) {
    crc ^= message[i] << 8;
    for (j = 0; j < 8; j++) {
      crc <<= 1;
      if (crc & (1 << 16)) {
        crc ^= 0x11021;
      }
    }
  }
  return crc;
}

// sends command with 4 args and crc to SD-Card and returns response
char spi_cmd(char cmd, char arg0, char arg1, char arg2, char arg3, char crc) {
  WriteReg(RW, 255);
  WriteReg(RW, 64 | cmd);
  WriteReg(RW, arg0);
  WriteReg(RW, arg1);
  WriteReg(RW, arg2);
  WriteReg(RW, arg3);
  WriteReg(RW, crc);

  int i = 0;
  while ((i < 10) && (spi_rw(255) == 255)) ++i;
  return ReadReg(RW);
}

// read 32 bit word from SPI
unsigned int spi_r() {
  unsigned int r = 0;
  for (int i = 0; i < 4; ++i) {
    r = (r << 8) | spi_rw(255);
  }
  return r;
}

// initialises the SD-Card
int spi_init() {
  initlock(&sdlock, "sd");
  msleep(1000);
  WriteReg(CTR, 1);
  for (int i = 0; i < 100; ++i) {
    msleep(1);
    WriteReg(CTR, 3);
    msleep(1);
    WriteReg(CTR, 1);
  }
  msleep(1);
  WriteReg(CTR, 0);

  spi_cmd(CMD0, 0, 0, 0, 0, 0x95);
  spi_cmd(CMD8, 0, 0, 1, 0xaa, 0x87);
  spi_r();

  for (int i = 0; i < 10; i++) {
    msleep(100000);
    spi_cmd(CMD55, 0, 0, 0, 0, 0);
    spi_cmd(ACMD41, 0x40, 0, 0, 0, 0);
    if (ReadReg(RW) == 0) break;
  }
  spi_cmd(CMD58, 0, 0, 0, 0, 0);
  int ocr = spi_r();
  if (~(ocr & (1 << 30)))
    spi_cmd(CMD16, 0, 0, 2, 0, 0);
  return 0;
}

// reads a specific block of 512 bytes from SD-Card into buffer
void spi_rb(unsigned int block, unsigned char* buf) {
  acquire(&sdlock);
  block += SD_BLOCK_OFFSET;
  int b1 = (block >> 24) & 0xff;
  int b2 = (block >> 16) & 0xff;
  int b3 = (block >> 8) & 0xff;
  int b4 = block & 0xff;
  if (spi_cmd(CMD17, b1, b2, b3, b4, 0) == 0) {
    int i = 0;
    while ((i < 100000) && (spi_rw(255) == 255)) ++i;
    for (int i = 0; i < 514; ++i) {
      buf[i] = spi_rw(255);
    }
  }
  if (getCRC16(buf, 514)) panic("CRC16 error\n");
  release(&sdlock);
}

// write block to SD-Card
void spi_wb(unsigned int block, unsigned char* buf) {
  acquire(&sdlock);
  block += SD_BLOCK_OFFSET;
  int b1 = (block >> 24) & 0xff;
  int b2 = (block >> 16) & 0xff;
  int b3 = (block >> 8) & 0xff;
  int b4 = block & 0xff;
  spi_cmd(CMD24, b1, b2, b3, b4, 0);
  int i = 0;
  while (spi_rw(255) != 255) {
    if (i > 100000) panic("spi_wb1\n");
    i++;
  }
  spi_rw(254);
  for (int i = 0; i < 514; ++i) {
    spi_rw(buf[i]);
  }
  spi_rw(255);
  i = 0;
  while (spi_rw(255) != 255) {
    if (i > 100000) panic("spi_wb2\n");
    i++;
  }
  release(&sdlock);
}
