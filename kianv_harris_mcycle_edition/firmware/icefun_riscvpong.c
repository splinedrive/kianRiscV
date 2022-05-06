/*
 *  icefun_riscvpong - RISC-V rv32im
 *
 *  copyright (c) 2022 hirosh dabui <hirosh@dabui.de>
 *
 *  permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  the software is provided "as is" and the author disclaims all warranties
 *  with regard to this software including all implied warranties of
 *  merchantability and fitness. in no event shall the author be liable for
 *  any special, direct, indirect, or consequential damages or any damages
 *  whatsoever resulting from loss of use, data or profits, whether in an
 *  action of contract, negligence or other tortious action, arising out of
 *  or in connection with the use or performance of this software.
 *
 */
#include <stdint.h>
#include "stdlib.c"


#define LED_FB 0x30000028
uint32_t *fb = (volatile uint32_t *) (LED_FB);

set_led_pixel(int x, int y, int set) {
  uint32_t pixel = (x % 8) + (y<<3);
  *fb = set ? *fb | 1<<pixel : *fb & ~1<<pixel;
}
int get_led_pixel(int x, int y) {
  uint32_t pixel = (x % 8) + (y<<3);
  return *fb & ~1<<pixel;
}

int test_button(int pin)
{
  uint32_t button = ((~IO_IN(GPIO_INPUT) & 0x0f)>>pin) & 0x01;

  uint64_t debounce_time = milliseconds() + 100;
  if (button) {
    while (milliseconds() < debounce_time) {
      if (button != ((~IO_IN(GPIO_INPUT) & 0x0f) >> pin) & 0x01) {
        button = 0;
        break;
      }
    }
  }
  return button;
}

int get_button()
{
  static int last_button = 0;
  int        button = 0;

  if (test_button(0)) {
    button = 1;
  }
  else if (test_button(1)) {
    button = 2;
  }
  else if (test_button(2)) {
    button = 3;
  }
  else if (test_button(3)) {
    button = 4;
  }

  /*
     if (last_button == button)
     {
     button = 0;
     }
     else
     {
     last_button = button;
     }
     */

  return button;
}

void main()
{
  int xs;
  int ys;
  int  x;
  int  y;

  int xs_ball;
  int ys_ball;
  int  x_ball;
  int  y_ball;

  uint64_t ballt0;
  uint32_t button;

  int collision;
  int mute = 0;
  int auto_pilot = 0;

start:
  collision = 0;
  x_ball = 2;
  y_ball = 0;
  xs_ball = 1;
  ys_ball = 1;

  x = 3;
  y = 3;
  *fb = 0;
  gpio_set_direction(4, 1);
  gpio_set_direction(5, 1);
  for (;;) {
    set_led_pixel(x+2, y, 1);
    set_led_pixel(x+1, y, 1);
    set_led_pixel(x, y, 1);
    //
    //   while (!(button = get_button()));
    //printf("%d\n", button);

    if ((milliseconds() >= ballt0) || collision) {
      set_led_pixel(x_ball, y_ball, 0);
      x_ball += xs_ball;
      y_ball += ys_ball;


      if (x_ball <= 0 || x_ball >= 7) xs_ball *= -1;
      if (y_ball <= 0 || y_ball >= 3) ys_ball *= -1;
      if (x_ball >= x && x_ball <= (x+2) && (y_ball == 2))
      {
        ys_ball *= -1;
        if (!mute) {
          for (int i = 0; i < 20; i++) {
            gpio_set_value(4, 0);
            gpio_set_value(5, 1);
            msleep(1);
            gpio_set_value(4, 1);
            gpio_set_value(5, 0);
            msleep(1);
          }
        }

      }; //xs_ball *= -1;}

    if (y_ball == 3) {
      if (!mute) {
        for (int i = 0; i < 200; i++) {
          gpio_set_value(4, 0);
          gpio_set_value(5, 1);
          msleep(10);
          gpio_set_value(4, 1);
          gpio_set_value(5, 0);
          msleep(10);
        }
      }
      goto start;
    }

      ballt0 = milliseconds() + 300;
      collision = 0;
    }

    set_led_pixel(x_ball, y_ball, 1);
    button = get_button();
    set_led_pixel(x + 2, y, 0);
    set_led_pixel(x + 1, y, 0);
    set_led_pixel(x    , y, 0);

//      if (y_ball == y) { ys_ball *= -1; collision = 1;}
    if (button == 1) x += 1;
    if (button == 2) x -= 1;
    //if (button == 3) y += 1;
    //if (button == 4) y -= 1;
    if (button == 3) auto_pilot ^= 1;
    if (button == 4) mute ^= 1;

    if (auto_pilot) { 
      if (x  < x_ball) x += 1;
      if (x >= x_ball) x -= 1;
    }

    if (x <= 0)  x = 0;
    if (y <= 0)  y = 0;
    if (x >= 7-2)  x = 7-2;
    if (y >= 3)  y = 3;
  }

}

/*
   void main()
   {
   uint8_t bmp[4] = {
   0b00111100,
   0b01000100,
   0b00000000,
   0b00000000
   };

   uint32_t bmp32 = bmp[0]<<24 | bmp[1]<<16 | bmp[2]<<8 | bmp[3];

 *fb = bmp32;

 }
 */

/*
#define N 2
void main()
{
int xs[N];
int ys[N];
int  x[N];
int  y[N];

for (int i = 0; i < N; i++) {
xs[i] = -1;
ys[i] = -1;

x[i] = rand() % 8;
y[i] = rand() % 4;
}


for (;;) {
for (int i = 0; i < N; i++) {
set_led_pixel(x[i], y[i], 0);
}
for (int i = 0; i < N; i++) {
x[i] += xs[i];
y[i] += ys[i];

if (get_led_pixel(x[i], y[i])) {
xs[i] *= -1;
ys[i] *= -1;
}

if (x[i] <= 0 | x[i] >= 7) xs[i] *= -1;
if (y[i] <= 0 | y[i] >= 7) ys[i] *= -1;

set_led_pixel(x[i], y[i], 1);
}
msleep(100);
}
}
*/
