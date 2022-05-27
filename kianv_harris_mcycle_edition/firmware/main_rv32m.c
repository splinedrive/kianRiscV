#include <stdint.h>
#define IO_BASE 0x30000000
#define UART_TX             (volatile uint32_t *) (IO_BASE + 0x0000)
#define UART_READY          (volatile uint32_t *) (IO_BASE + 0x0000)
//#include "kianv_stdlib.h"
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


void main() {
  for (;;) {
    /*
    asm volatile("addi x1,x0,5");
    asm volatile("addi x2,x0,3");
    asm volatile("mul  x3,x1,x2");
    asm volatile("div  x4,x3,x2");
    */
    for (unsigned int i = 1; i < 1<<16; i++) {
      unsigned int square = i*i;
      print_str("Multiplication and Division:");
      print_dec(i);
      print_chr('*');
      print_dec(i);
      print_chr('=');
      print_dec(square);
      print_chr('/');
      print_dec(i);
      print_chr('=');
      print_dec(square/i);
      print_chr(10);
    }

    for (unsigned int i = 1<<16; i >= 1; i--) {
      unsigned int square = i*i;
      print_str("Multiplication and Division:");
      print_dec(i);
      print_chr('*');
      print_dec(i);
      print_chr('=');
      print_dec(square);
      print_chr('/');
      print_dec(i);
      print_chr('=');
      print_dec(square/i);
      print_chr(10);
    }
  }
}
