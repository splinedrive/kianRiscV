#include <stdint.h>
#include "stdlib.c"

typedef uint32_t datum;
void main()
{
  datum *q = (volatile datum *) (0x10000000);
  sleep(1);
  for (int i = 0; i < 10; i++)  {
    *q = 0xff00ff; 
//    print_hex(q, 8);
    q++;
 //   printf("\n");
  }
}
