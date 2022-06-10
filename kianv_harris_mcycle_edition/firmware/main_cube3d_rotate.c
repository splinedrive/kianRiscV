// kian riscv house rotation demo, author Hirosh Dabui
/* fast sin/cosine by https://www.atwillys.de/content/cc/sine-lookup-for-embedded-in-c/ */

#define DMA
#include <stdint.h>
#include <math.h>
#include "stdlib.c"
#include "gfx_lib.h"

point front [] =
{
  /*
     {0,  10, 0},  {5, 5, 0},
     {5,  5,  0},  {10, 10, 0},
     */
  {0,  10, 0},  {10, 10, 0},
  {10, 10, 0},  {10, 20, 0},
  {10, 20, 0},  {0, 20, 0},
  {0, 20,  0},  {0, 10, 0},

  /*
     {10-2, 20, 0},   {10-2, 20-3, 0},
     {10-2, 20-3, 0},   {10-2-2, 20-3, 0},
     {10-2-2, 20-3, 0},   {10-2-2, 20, 0},

     {1, 10+3, 0}, {1+3, 10+3, 0},
     {1+3, 10+3, 0}, {1+3, 10+3+3, 0},
     {1+3, 10+3+3, 0}, {1, 10+3+3, 0},
     {1, 10+3+3, 0}, {1, 10+3, 0},
     */

};

point back [] =
{
  /*
     {0,  10, 10},  {5, 5, 10},
     {5,  5,  10},  {10, 10, 10},
     */
  {0,  10, 10},  {10, 10, 10},
  {10, 10, 10},  {10, 20, 10},
  {10, 20, 10},  {0, 20, 10},
  {0, 20,  10},  {0, 10, 10},
};

point left_top [] =
{
  {0,  10, 0},  {0, 10, 10},
};

point left_bottom [] =
{
  {0,  20, 0},  {0, 20, 10},
};

point right_top [] =
{
  {10,  10, 0},  {10, 10, 10},
};

point right_bottom [] =
{
  {10,  20, 0},  {10, 20, 10},
};

point roof [] =
{
  {5,  5, 0},  {5, 5, 10},
};

void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
  for (int i = 0; i < s - 1; i = i + 2) {
    point p0 = points[i];
    point p1 = points[i + 1];


    p0 = scale(&p0, scalef, scalef, scalef);
    p1 = scale(&p1, scalef, scalef, scalef);

    p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
    p1 = translate(&p1, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);

    point pivot = {HRES/2, VRES/2, 0};

    p0 = rotateX_pivot(&p0, &pivot, -angle_x);
    p1 = rotateX_pivot(&p1, &pivot, -angle_x);
    p0 = rotateY_pivot(&p0, &pivot, -angle_y);
    p1 = rotateY_pivot(&p1, &pivot, -angle_y);
    p0 = rotateZ_pivot(&p0, &pivot, angle_z);
    p1 = rotateZ_pivot(&p1, &pivot, angle_z);


    fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, RGB256(0x07, 0x03, 0x3));

  }
}

#define SIZEOF(arr) sizeof(arr) / sizeof(*arr)

void main() {
  init_oled8bit_colors();
  fill_oled(framebuffer, 0x0000);

  int angle = 0;
  int delta_angle = -4; /* speedup rotation, - for left rotation */

  float s = 4;
  float delta_scale = 0.1;//0.8; /* speedup scale */

  IO_OUT(GPIO_DIR, ~0);
  uint8_t led;
  for (;;) {
    render_lines(front, SIZEOF(front), angle, angle, angle, s);
    render_lines(back, SIZEOF(back), angle,angle, angle,  s);
    render_lines(left_bottom, SIZEOF(left_bottom), angle,angle, angle,  s);
    render_lines(left_top, SIZEOF(left_top), angle,angle, angle,  s);
    render_lines(right_bottom, SIZEOF(left_bottom), angle,angle, angle,  s);
    render_lines(right_top, SIZEOF(left_top), angle,angle, angle,  s);
    //   render_lines(roof, SIZEOF(roof), angle,angle, angle,  s);

    oled_show_fb_8or16(framebuffer, 1);
    angle += delta_angle;

    if (angle >= 359) angle = 0;
    if (s >= 10) delta_scale = -delta_scale;
    if (s <= 0) delta_scale = -delta_scale;
    s += delta_scale;

    fill_oled(framebuffer, 0);
    IO_OUT(GPIO_OUTPUT, 0);
    led &= 7;
    gpio_set_value(led++, 1);
  }

}
