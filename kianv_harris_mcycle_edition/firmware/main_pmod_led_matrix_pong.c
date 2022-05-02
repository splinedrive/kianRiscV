// kian riscv house rotation demo, author Hirosh Dabui
// using matrix led pmod https://github.com/machdyne/matrix
#include <stdint.h>
#include <math.h>
#include "stdlib.c"

#define M 4
#define N 4
char led_matrix[M][N]; 

void clear_matrix() {
  char *p = led_matrix;
  for (int i = 0; i < N*M; i++) 
    *p++ = 0;
}

void update_matrix() {
  for (int col = 0; col < N; col++) {
    gpio_set_value(col + 4, 0);

    for (int row = 0; row < M; row++) {
      gpio_set_value(row, led_matrix[col][row] == 1);
      gpio_set_value(row, 0);
    }

    gpio_set_value(col + 4, 1);
  }
}

void set_dot(char x, char y, char on) {
  led_matrix[y][x] = on;
}

void main() {
  int x, y;
  int sx = 1;
  int sy = 1;
  int frame = 0;
  uint64_t t0 = 0;
  uint64_t t1 = 0;
  uint64_t delta = 0;

  IO_OUT(GPIO_DIR, ~0);
  IO_OUT(GPIO_OUTPUT, 0);

  clear_matrix();
  x = 1;
  y = 2;

  for (;;) {
    t0 = milliseconds();
    t1 = 0;
    delta = 0;
    while (delta < 125) {
      set_dot(x, y, 1);
      update_matrix();
      set_dot(x, y, 0);
      t1 = milliseconds();
      delta = t1 - t0;
    }


    x += sx;
    y += sy;

    if (x <= 0 || x >= (M-1)) sx *= -1;
    if (y <= 0 || y >= (N-1)) sy *= -1;

  }
}
