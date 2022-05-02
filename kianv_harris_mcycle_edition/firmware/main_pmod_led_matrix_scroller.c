#include <stdint.h>
#include <math.h>
#include "stdlib.c"

#define M 4
#define N 4

uint16_t font4x4[] = 
{
  0b0000000000000000, 
  0b0110100111111001,
  0b1000111110011111,
  0b1111100010001111,
  0b0001111110011111,
  0b0110111110000110,
  0b1111111010001000,
  0b1111100010111111,
  0b1001100111111001,
  0b1111011001101111,
  0b0011001110111111,
  0b1011110010101001,
  0b1000100010001111,
  0b1111111110011001,
  0b1001110110111001,
  0b1111100110011111,
  0b1111100111111000,
  0b1111100110101101,
  0b1111100111101001,
  0b1111110000111111,
  0b1111011001100110,
  0b1001100110011111,
  0b1001100110010110,
  0b1001100111111111,
  0b1001011001101001,
  0b1001111101100110,
  0b1111001001001111
};

char led_matrix[M][N]; 

char scrollbuffer[M][N];

void clear_matrix() {
  char *p = led_matrix;
  for (int i = 0; i < N*M; i++) 
    *p++ = 0;
}

void update_matrix() {
  for (int col = 0; col < N; col++) {
    gpio_set_value(col + 4, 0);

    for (int row = 0; row < M; row++) {
      gpio_set_value(row, led_matrix[col][3 - row] == 1);
      gpio_set_value(row, 0);
    }

    gpio_set_value(col + 4, 1);
  }
}

int get_offset(char c) {
  int offset;

  if (c == ' ') 
    offset = 0;
  else
    offset = c - 'a' + 1;

  return offset;
}

uint16_t get_bitmap(char c) {
  return font4x4[get_offset(c)];
}

uint8_t get_tile(int row, char c) {
  uint16_t bmp = get_bitmap(c);
  uint8_t tile = (bmp >> ((3 - row) * 4)) & 0x0f;

  return tile;
}

uint8_t get_bit(int row, int col, int c) {
  uint16_t tile = get_tile(row, c);

  uint8_t bit = (tile >> (3 - col)) & 1;
  return bit;
}

void shift_scroller(char c, int xpos) {
  for (int row = 0; row < 4; row++) {
    for (int col = 1; col < 4; col++) {
      scrollbuffer[row][col - 1] = scrollbuffer[row][col];
    }
    scrollbuffer[row][3] = xpos >= 5 ? 0 : get_bit(row, xpos, c);

  }
}

void flush() {
  for (int row = 0; row < 4; row++) {
    for (int col = 0; col < 4; col++) {
      led_matrix[row][col] = scrollbuffer[row][col];
    }
  }
}

void set_char(char c) {

  for (int row = 0; row < 4; row++) {
    for (int col = 0; col < 4; col++) {
      led_matrix[row][col] = get_bit(row, col, c);
    }
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

  IO_OUT(GPIO_DIR, ~0);
  IO_OUT(GPIO_OUTPUT, 0);

  clear_matrix();

  char str[] = "hello i am kianv cpu";
  char *p = &str[0];
  //  set_char('a');
  int xpos = 0;
  for (;;) {
    flush();

    shift_scroller(*p, xpos);
    {
      uint64_t t0 = milliseconds();
      uint64_t t1 = 0;
      uint64_t delta = 0;
      while (delta < 200) {
        //      set_dot(x, y, 1);
        update_matrix();
        //      set_dot(x, y, 0);
        t1 = milliseconds();
        delta = t1 - t0;
      }
    }
    xpos++;

    if (!(xpos %= 6)) p++; 
    if (!*p) {
      p = &str[0]; 
    }
  }
}
