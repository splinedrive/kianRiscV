#include <stdint.h>
#define UART_TX 0x30000000
#define UART_READY 0x30000000
#define VIDEOENABLE (volatile uint32_t*) 0x30000008
#define VIDEO      (volatile uint32_t *) 0x30000008
#define VIDEO_RAW  (volatile uint32_t *) 0x3000000C

//#define RV32_FASTCODE __attribute((section(".fastcode")))
#define RV32_FASTCODE

//__attribute((section(".fastcode")))

#define RED   "\x1B[31m"
#define GRN   "\x1B[32m"
#define YEL   "\x1B[33m"
#define BLU   "\x1B[34m"
#define MAG   "\x1B[35m"
#define CYN   "\x1B[36m"
#define WHT   "\x1B[37m"
#define RESET "\x1B[0m"

#define CLS       "\x1B[2J"
#define BOLD      "\x1B[1m"
#define BLINK     "\x1B[5m"
#define BLINK_OFF "\x1B[25m"

uint64_t get_cycle() {
  volatile uint32_t tmph0;
  volatile uint32_t tmpl0;

  asm volatile ("rdcycleh %0" : "=r"(tmph0));
  asm volatile ("rdcycle  %0" : "=r"(tmpl0));

  return ((uint64_t)(tmph0)<<32) + tmpl0;
  //  uint64_t rdinstret = ((uint64_t)(tmph1)<<32) + tmpl1;

}

void wait_cycles(uint64_t wait) {
  uint64_t lim = get_cycle() + wait;
  while (get_cycle() < lim)
    ;
}

void putchar(char c) {
  while (!*((volatile uint32_t*) UART_READY))
    ;
  *((volatile uint32_t*) UART_TX) = c;
}

void print_chr(char ch) {
  while (!*((volatile uint32_t*) UART_READY))
    ;
  *((volatile uint32_t*) UART_TX) = ch;
}

void print_str(char *p) {
  while (*p != 0) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
    *((volatile uint32_t*) UART_TX) = *(p++);
  }
}
void print_str_ln(char *p) {
  print_str(p);
  print_chr(10);
}

void print_dec(unsigned int val) {
  char buffer[10];
  char *p = buffer;
  while (val || p == buffer) {
    *(p++) = val % 10;
    val = val / 10;
  }

  while (p != buffer) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
    *((volatile uint32_t*) UART_TX) = '0' + *(--p);
  }
}

void print_dec64(uint64_t val) {
  char buffer[20];
  char *p = buffer;
  while (val || p == buffer) {
    *(p++) = val % 10;
    val = val / 10;
  }

  while (p != buffer) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
    *((volatile uint32_t*) UART_TX) = '0' + *(--p);
  }
}

void print_hex(unsigned int val, int digits) {
  for (int i = (4*digits)-4; i >= 0; i -= 4) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
    *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
  }
}

typedef short Pixel;

void setpixel(volatile Pixel *fb, int x, int y, short color) {
/*
  const int x_offset = x;
  const int y_offset = y*HRES;

  fb[x_offset + y_offset] = color;
*/
*((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
}
