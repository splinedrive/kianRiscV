#include <stdint.h>
#define UART_TX    (volatile uint32_t *) 0x30000000
#define UART_READY (volatile uint32_t *) 0x30000000
#define VIDEO      (volatile uint32_t *) 0x30000008



//uint64_t cycles() RV32_FASTCODE;
/*
uint64_t cycles() {
  static uint32_t cycles_lap_=0;
  static uint64_t cycles_=0;
  static uint32_t last_cycles32_=0;
  uint32_t cycles32_;

  if(cycles_lap_ == 0) {
    cycles_lap_ = FEMTORV32_COUNTER_BITS;
    if(cycles_lap_ == 32) {
      cycles_lap_ = ~0u;
    } else {
      cycles_lap_ = 1u << cycles_lap_;
    }
  }

  
  asm volatile ("rdcycle %0" : "=r"(cycles32_));
  // Detect counter overflow
  if(cycles32_ < last_cycles32_) {
    cycles_ += cycles_lap_;
  }
  cycles_ += cycles32_;
  cycles_ -= last_cycles32_;
  last_cycles32_ = cycles32_;
  return cycles_;
}
*/

void putchar(char c) {
  while (!*(UART_READY))
    ;
  *(UART_TX) = c;
}

void print_chr(char ch)
{
  while (!*(UART_READY))
    ;
  *(UART_TX) = ch;
}

void print_str(char *p)
{
  while (*p != 0) {
    while (!*(UART_READY))
      ;
    *(UART_TX) = *(p++);
  }
}

void print_dec(unsigned int val)
{
  char buffer[10];
  char *p = buffer;
  while (val || p == buffer) {
    *(p++) = val % 10;
    val = val / 10;
  }

  while (p != buffer) {
    while (!*(UART_READY))
      ;
    *(UART_TX) = '0' + *(--p);
  }
}

void print_hex(unsigned int val, int digits)
{
  for (int i = (4*digits)-4; i >= 0; i -= 4) {
    while (!*(UART_READY))
      ;
    *(UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
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


void show_csr_timer_cnt() {
  volatile uint32_t tmph0;
  volatile uint32_t tmpl0;
  volatile uint32_t tmph1;
  volatile uint32_t tmpl1;

  asm volatile ("rdcycleh %0" : "=r"(tmph0));
  asm volatile ("rdcycle  %0" : "=r"(tmpl0));

  asm volatile ("rdinstreth %0" : "=r"(tmph1));
  asm volatile ("rdinstret %0"  : "=r"(tmpl1));

  uint32_t cycles    = ((uint64_t)(tmph0)<<32) + tmpl0;
  uint32_t rdinstret = ((uint64_t)(tmph1)<<32) + tmpl1;

  putchar(10);
  print_str("rdcycle       :");
  print_dec64(cycles);
  putchar(10);
  print_str("rdinstret     :");
  print_dec64(rdinstret);
  putchar(10);
  putchar(10);

}

void main() {
  for (;;) {
    show_csr_timer_cnt();

  /*
  asm volatile ("time %0" : "=r"(tmp));
  print_str("rdcycle:");
  print_dec(tmp);
  putchar(10);

  asm volatile ("rdcycleh %0" : "=r"(tmp));
  print_str("rdcycleh:");
  print_dec(tmp);
  putchar(10);

  asm volatile ("rdinstret %0" : "=r"(tmp));
  print_str("rdinstret:");
  print_dec(tmp);
  putchar(10);

  asm volatile ("rdinstreth %0" : "=r"(tmp));
  print_str("rdinstreth:");
  print_dec(tmp);
  putchar(10);
  */
  }
}
