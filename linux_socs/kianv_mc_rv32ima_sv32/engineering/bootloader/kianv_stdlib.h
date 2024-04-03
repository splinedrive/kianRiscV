#include <math.h>
#include <stdint.h>

/* kian hardware register */
#define IO_BASE 0x10000000
#define UART_TX (volatile uint32_t *)(IO_BASE + 0x0000)
#define UART_LSR (volatile uint8_t *)(IO_BASE + 0x0005)
#define CPU_FREQ (volatile uint32_t *)(IO_BASE + 0x0014)

#define RED "\x1B[31m"
#define GRN "\x1B[32m"
#define YEL "\x1B[33m"
#define BLU "\x1B[34m"
#define MAG "\x1B[35m"
#define CYN "\x1B[36m"
#define WHT "\x1B[37m"
#define RESET "\x1B[0m"

#define CLS "\x1B[2J"
#define BOLD "\x1B[1m"
#define BLINK "\x1B[5m"
#define BLINK_OFF "\x1B[25m"

uint64_t get_cycles() {
  volatile uint32_t tmph0;
  volatile uint32_t tmpl0;

  asm volatile("rdcycleh %0" : "=r"(tmph0));
  asm volatile("rdcycle  %0" : "=r"(tmpl0));

  return ((uint64_t)(tmph0) << 32) + tmpl0;
}

inline uint32_t get_cpu_freq() { return *((volatile uint32_t *)CPU_FREQ); }

void wait_cycles(uint64_t wait) {
  uint64_t lim = get_cycles() + wait;
  while (get_cycles() < lim)
    ;
}

void usleep(uint32_t us) {
  if (us)
    wait_cycles(us * (get_cpu_freq() / 1000000));
}

void msleep(uint32_t ms) {
  if (ms)
    wait_cycles(ms * (get_cpu_freq() / 1000));
}

void sleep(uint32_t sec) {
  if (sec)
    wait_cycles(sec * get_cpu_freq());
}

uint64_t nanoseconds() {
  return get_cycles() / (uint64_t)(get_cpu_freq() / 1000000);
}

uint64_t milliseconds() {
  return get_cycles() / (uint64_t)(get_cpu_freq() / 1000);
}

uint64_t seconds() { return get_cycles() / (uint64_t)(get_cpu_freq()); }

void putchar(char c) {
  while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
    ;
  *((volatile uint32_t *)UART_TX) = c == 13 ? 10 : c;
}

void print_chr(char ch) { putchar(ch); }

void print_char(char ch) { print_chr(ch); }

void print_str(char *p) {
  while (*p != 0) {
    while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
      ;
    putchar(*(p++));
  }
}

void print_str_ln(char *p) {
  print_str(p);
  print_char(13);
}

void print_dec(unsigned int val) {
  char buffer[10];
  char *p = buffer;
  while (val || p == buffer) {
    *(p++) = val % 10;
    val = val / 10;
  }

  while (p != buffer) {
    while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
      ;
    *((volatile uint32_t *)UART_TX) = '0' + *(--p);
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
    while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
      ;
    *((volatile uint32_t *)UART_TX) = '0' + *(--p);
  }
}

void print_hex(unsigned int val, int digits) {
  for (int i = (4 * digits) - 4; i >= 0; i -= 4) {
    while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
      ;
    *((volatile uint32_t *)UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
  }
}
