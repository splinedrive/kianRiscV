/*
   SPI - Serial Peripheral Interface
   Memory-mapped SD-Card registers
   Base address: 0x10001000

RW:   Write -> send 8 bits
      Read  -> last received byte
CTR:  Control lines
      CTR[0] = CSN (chip select not)
      CTR[1] = SCK
*/

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "proc.h"
#include "defs.h"

// register offsets
#define RW   0
#define CTR  4
#define SS   (1<<0)
#define SCK  (1<<1)

// SD commands
#define CMD0   0    // GO_IDLE_STATE
#define CMD8   8    // SEND_IF_COND
#define CMD16 16    // SET_BLOCKLEN
#define CMD17 17    // READ_SINGLE_BLOCK
#define CMD24 24    // WRITE_BLOCK
#define CMD55 55    // APP_CMD
#define CMD58 58    // READ_OCR
#define ACMD41 41   // SD_SEND_OP_COND

#define SD_BLOCK_OFFSET ((1024*1024*2)/512)

struct spinlock sdlock;

struct spi_regs {
  volatile uint32 *ctrl;
  volatile uint32 *data;
};

// memory mapped SPI base
struct spi_regs spi = {
  (volatile uint32 *)SDCARD0_CTRL,
  (volatile uint32 *)SDCARD0_DATA
};

// -----------------------------------------------------------------------------
// Helpers

static inline void CS_ENABLE(void)  { *spi.ctrl = 0; }
static inline void CS_DISABLE(void) { *spi.ctrl = 1; }

// simple blocking byte transfer
static inline unsigned char spi_rw(unsigned char c) {
  while (*spi.ctrl & SDCARD0_SPI_BUSY_BIT);
  *spi.data = c;
  while (*spi.ctrl & SDCARD0_SPI_BUSY_BIT);
  return (unsigned char)(*spi.data);
}

// read 32-bit word from SPI
static inline unsigned int spi_r(void) {
  unsigned int r = 0;
  r = (r << 8) | spi_rw(0xFF);
  r = (r << 8) | spi_rw(0xFF);
  r = (r << 8) | spi_rw(0xFF);
  r = (r << 8) | spi_rw(0xFF);
  return r;
}

// send command with args and crc, return R1 response
static inline char spi_cmd(char cmd, char a0, char a1, char a2, char a3, char crc) {
  spi_rw(0xFF);
  spi_rw(0x40 | cmd);
  spi_rw(a0);
  spi_rw(a1);
  spi_rw(a2);
  spi_rw(a3);
  spi_rw(crc);
  int i = 0; unsigned char r;
  do { r = spi_rw(0xFF); i++; } while (r == 0xFF && i < 10);
  return r;
}

// -----------------------------------------------------------------------------
// Init and timing

// read mtime
unsigned long long mtime() {
  unsigned int h1, l, h2;
  asm volatile("csrr %0, 0xC80" : "=r"(h1));
  asm volatile("csrr %0, 0xC00" : "=r"(l));
  asm volatile("csrr %0, 0xC80" : "=r"(h2));
  if (h1 != h2) return mtime();
  return (((unsigned long long)h1) << 32) | l;
}

// busy-wait sleep (µs)
void msleep(unsigned int dt) {
  dt = dt * 32;
  unsigned long long t = mtime();
  while (mtime() - t < dt);
}

int spi_init() {
  initlock(&sdlock, "sd");

  msleep(1000);
  CS_DISABLE();
  for (int i = 0; i < 100; i++) {
    msleep(1);
    CS_ENABLE();
    msleep(1);
    CS_DISABLE();
  }
  msleep(1);

  spi_cmd(CMD0, 0, 0, 0, 0, 0x95);
  spi_cmd(CMD8, 0, 0, 1, 0xAA, 0x87);
  spi_r();

  for (int i = 0; i < 10; i++) {
    msleep(100000);
    spi_cmd(CMD55, 0, 0, 0, 0, 0);
    spi_cmd(ACMD41, 0x40, 0, 0, 0, 0);
    if (spi_rw(0xFF) == 0) break;
  }
  spi_cmd(CMD58, 0, 0, 0, 0, 0);
  int ocr = spi_r();
  if (~(ocr & (1 << 30)))
    spi_cmd(CMD16, 0, 0, 2, 0, 0);
  return 0;
}

// -----------------------------------------------------------------------------
// Read/Write blocks

void spi_rb(unsigned int block, unsigned char *buf) {
  acquire(&sdlock);
  block += SD_BLOCK_OFFSET;

  if (spi_cmd(CMD17,
              (block >> 24) & 0xFF,
              (block >> 16) & 0xFF,
              (block >> 8)  & 0xFF,
              block & 0xFF, 0) == 0) {
    // wait for start token
    unsigned char tok; int i = 0;
    do { tok = spi_rw(0xFF); i++; } while (tok == 0xFF && i < 100000);
    if (tok != 0xFE) {
      release(&sdlock);
      panic("sd: no start token");
    }

    // read 512 bytes
    for (int k = 0; k < 512; k++)
      buf[k] = spi_rw(0xFF);

    // discard CRC
    spi_rw(0xFF); spi_rw(0xFF);
  }

  release(&sdlock);
}

void spi_wb(unsigned int block, unsigned char *buf) {
  acquire(&sdlock);
  block += SD_BLOCK_OFFSET;

  if (spi_cmd(CMD24,
              (block >> 24) & 0xFF,
              (block >> 16) & 0xFF,
              (block >> 8)  & 0xFF,
              block & 0xFF, 0) != 0) {
    release(&sdlock);
    panic("sd: CMD24");
  }

  // wait for ready
  int i = 0;
  while (spi_rw(0xFF) != 0xFF) {
    if (i++ > 100000) {
      release(&sdlock);
      panic("sd: not ready before write");
    }
  }

  // start token
  spi_rw(0xFE);

  // write 512 bytes
  for (int k = 0; k < 512; k++)
    spi_rw(buf[k]);

  // dummy CRC
  spi_rw(0xFF); spi_rw(0xFF);

  // check data response
  unsigned char resp = spi_rw(0xFF) & 0x1F;
  if (resp != 0x05) {
    release(&sdlock);
    panic("sd: data reject");
  }

  // busy until card releases
  i = 0;
  while (spi_rw(0xFF) != 0xFF) {
    if (i++ > 1000000) {
      release(&sdlock);
      panic("sd: write busy timeout");
    }
  }

  release(&sdlock);
}

