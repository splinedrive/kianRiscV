#include <stdint.h>
#include <fenv.h>
#include "stdlib.c"
#define N 50 
void main()
{
  for (;;) { 
    int prim[N];

    for (int i = 1; i < N; i++) prim[i] = 1;

    for (int i = 2; i < (N>>1); i++) {
      if (prim[i])
        for (int j = i*i; j < N; j += i) {
          prim[j] = 0;
        }
    }
    for (int i = 1; i < N; i++) 
      if (prim[i]) printf("%d\n", i);
  }

}
