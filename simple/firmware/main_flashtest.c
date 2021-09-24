#include <stdint.h>
//#define UART_TX (1<<13)
#define UART_TX 0x30000000//(1<<13)
#define UART_READY 0x30000000//(1<<13)
#define RV32_FASTCODE __attribute((section(".fastcode")))


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

void print_hex(unsigned int val, int digits) {
  for (int i = (4*digits)-4; i >= 0; i -= 4) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
    *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
  }
}

//typedef unsigned int datum;
//#define SIZE 256*1024*4/sizeof(datum)
//#define SIZE 640*480*2/sizeof(datum)
//#define BASE 0x10000000
#define SIZE 10
#define FLASH_BASE (0x20000000)
//datum *p = (volatile datum*) FLASH;
//void main() RV32_FASTCODE;
void main() {

  for (;;) {
    uint32_t *p = (volatile uint32_t*) FLASH_BASE;
    for (int i = 0; i < 64; i++) {
      print_hex((unsigned int) p, 8);
      print_chr(':');
      print_hex((unsigned int) *p, 8);
      print_chr(10);
      p++;
    }

    print_str("=================================");
    print_chr(10);

  }

}

