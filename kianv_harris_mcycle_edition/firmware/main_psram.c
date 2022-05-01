#include <stdint.h>
#include "stdlib.c"

#define NR 10
#define OFFSET (1024*1024*28)
//#define OFFSET 0

typedef uint8_t datum;
void main()
{

  sleep(2);
  for (;;) {
    datum *q = (volatile datum *) (0x40000000 + OFFSET);
    for (int i = 0; i < NR; i++) {
      *q = i;
      q++;
    }
#if 1
    q = (volatile datum *) (0x40000000 + OFFSET);
    for (int i = 0; i < NR; i++) {
      print_hex(*q, 8);
      putchar(10);
      msleep(200);
      q++;
    }
#endif
    q = (volatile datum *) (0x40000000 + OFFSET);
    for (int i = 0; i < NR; i++) {
      print_hex(*q, 8);
      putchar(10);
      msleep(200);
      q++;
    }
    for (;;);
  }
  }
