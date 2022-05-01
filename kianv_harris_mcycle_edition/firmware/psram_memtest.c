#include <stdint.h>
#define UART_TX 0x30000000//(1<<13)

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
  *((volatile uint32_t*) UART_TX) = c;
}

void print_chr(char ch) {
  *((volatile uint32_t*) UART_TX) = ch;
}

void print_str(char *p) {
  while (*p != 0) {
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
    *((volatile uint32_t*) UART_TX) = '0' + *(--p);
  }
}

void print_hex(unsigned int val, int digits) {
  for (int i = (4*digits)-4; i >= 0; i -= 4) {
    *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
  }
}


typedef  uint8_t datum;
#define SIZE (1024*1024*32)/sizeof(datum)
//#define SIZE (1024*1024)/sizeof(datum)
#define BASE (0x40000000)
datum *p = (volatile datum*) BASE;
void main() {

  int iter = 0;
  for (;;) {

    print_chr(10);
    print_str(GRN);
    print_str(BLINK);
    print_str(BOLD);
    print_str("Memory test iteration: ");
    print_dec(iter);
    print_chr(10);
    print_str(RESET);
    print_str(BLINK_OFF);
    print_str_ln("=========================================");
    print_str(MAG);
    print_str("Size of datum         : ");
    print_str(WHT);
    print_str("0x");
    print_hex((unsigned int) sizeof(datum), 8);
    print_chr(10);
    print_str(GRN);
    print_str("Size of memory to test: ");
    print_str(WHT);
    print_str("0x");
    print_hex((unsigned int) SIZE, 8);
    print_chr(10);
    print_chr(10);

    datum pattern = 1;
    datum antipattern = ~1;
    p = (volatile datum*) BASE;
    for (int i = 0; i < SIZE; i++, pattern++) {
      *p = pattern;
//      print_hex((unsigned int) p, 8);
 //     print_chr(10);
      p++;
    }

    print_str(CYN);
    print_str_ln("pattern write                       done!");

    pattern = 1;
    p = (volatile datum*) BASE;
    for (int i = 0; i < SIZE; i++, pattern++) {
//      print_hex((unsigned int) p, 8);
 //     print_chr(10);
      if (*p != pattern) {
        print_str(RED);
        print_str("Error pattern in:");
        print_chr(10);
        print_hex((unsigned int) pattern, 8);
        print_chr(10);
        print_hex((unsigned int) p, 8);
        print_chr(10);
        print_hex((unsigned int) *p, 8);
        print_chr(10);
    //    for (;;);
      }
      antipattern = ~pattern;
      *p = antipattern;
      p++;
    }

    print_str(YEL);
    print_str_ln("check pattern and antipattern write done!");

    p = (volatile datum*) BASE;
    pattern = 1;
    for (int i = 0; i < SIZE; i++, pattern++) {
      antipattern = ~pattern;
      if (*p != antipattern) {
        print_str(RED);
        print_str("Error antipattern in:");
        print_chr(10);
        print_hex((unsigned int) antipattern, 8);
        print_chr(10);
        print_hex((unsigned int) p, 8);
        print_chr(10);
        print_hex((unsigned int) *p, 8);
        print_chr(10);
        //for (;;);
      }
      *p = 0x00;
      p++;
    }
    print_str(WHT);
    print_str_ln("check antipattern and test          done!");
    print_str("\xa\xa\xa");

    iter++;
  }

}
