// kian riscv house rotation demo, author Hirosh Dabui

#include <stdint.h>
#include <math.h>
#include "stdlib.c"
#include "gfx_lib_hdmi.h"

typedef struct {
  int x;
  int y;
  int xdelta;
  int ydelta;
  int color;
} pixel;

#define N 10

pixel pixels[N];
#define SIZEOF(arr) sizeof(arr) / sizeof(*arr)

#define FRAMEBUFFER (volatile short *) 0x10000000
#define FB_CTRL     (volatile short *) 0x30000024

void render_pixels() {
  for (int i = 0; i < N; i++) {
    fb_setpixel(framebuffer, pixels[i].x, pixels[i].y, pixels[i].color);
  }
}

void move_pixels() {
  for (int i = 0; i < N; i++) {
    int *x = &pixels[i].x;
    int *y = &pixels[i].y;
    int *xdelta = &pixels[i].xdelta;
    int *ydelta = &pixels[i].ydelta;

//#define BOUNCE 1
#if BOUNCE
    for (int j = 0; j < N; j++) {
      int *xj = &pixels[j].x;
      int *yj = &pixels[j].y;
      if (j != i) {

        if (*x == *xj) *xdelta *= -1;
        else if (*y == *yj) *ydelta *= -1;
#endif
        if (*x >= (HRES-1) || *x < 0) *xdelta *= -1;
        if (*y >= (VRES-1) || *y < 0) *ydelta *= -1;

        *x += *xdelta;
        *y += *ydelta;
#if BOUNCE
      }
    }
#endif


  }
}


void main() {
  int led = 0;
//  init_oled8bit_colors();
  fill_oled(framebuffer, 0x0000);

  for (int i = 0; i < N; i++) {
    pixels[i].x = random() % HRES;
    pixels[i].y = random() % VRES;
    pixels[i].xdelta = (random() % 2) + 1;
    pixels[i].ydelta = (random() % 2) + 1;
    pixels[i].color = (random() % 0xffffff);
  }

  uint32_t *fb_ctrl = FB_CTRL;
  *fb_ctrl = 0;
  IO_OUT(GPIO_DIR, ~0);
  for (;;) {

    render_pixels();

    oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
    *fb_ctrl ^= 1;
    move_pixels();


    IO_OUT(GPIO_OUTPUT, 0);
    led &= 7;
    gpio_set_value(led++, 1);
    msleep(20);
    fill_oled(framebuffer, 0x000000);
  }

}
