// kian riscv house rotation demo, author Hirosh Dabui
/* fast sin/cosine by https://www.atwillys.de/content/cc/sine-lookup-for-embedded-in-c/ */

#include <stdint.h>
#include <fenv.h>
#include "stdlib.c"
#include "gfx_lib_hdmi.h"
#include <math.h>

#define N 360 
#define STEP 20 
point stars [N];

void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
  for (int i = 0; i < s - 1; i = i + 1) {
    point p0 = points[i];


    p0 = scale(&p0, scalef, scalef, scalef);

    p0 = translate(&p0, HRES/2 - 30, VRES/2, 0);

    //point pivot = {HRES/2, VRES/2, 15};


    point pivot = {HRES/2, VRES/2 -15*scalef, 0};
//    p0 = rotateX_pivot(&p0, &pivot, angle_x);
    p0 = rotateY_pivot(&p0, &pivot, angle_y);

    p0 = rotateZ_pivot(&p0, &pivot, angle_z);

    //fb_setpixel(framebuffer, p0.x, p0.y, RGB256(0x07, 0x03, 0x03));  // i);
    fb_setpixel(framebuffer, p0.x, p0.y, ~0);

  }
}

// abstand r = sqrt((q1-p1)^2 ... (q3-p3)^2));
// f = GmM/r^2
// f = m*a => a = f/m
// V = a*t; s = V*t
#define SIZEOF(arr) sizeof(arr) / sizeof(*arr)

#define FRAMEBUFFER (volatile short *) 0x10000000
#define FB_CTRL     (volatile short *) 0x30000024
void main() {
  fill_oled(framebuffer, 0x0000);

  int angle = 0;
  int delta_angle = 4; /* speedup rotation, - for left rotation */

  float s = 1;
  float delta_scale = 0.0;//0.8; /* speedup scale */

  /*
  for (int i = 0; i < N; i++) {
    stars[i].x = rand() % 96;
    stars[i].y = rand() % 64;
    stars[i].z = rand() % 96;
  }
  */
  int index = 0;
  for (int t = 0; t < 360; t += STEP) {
    for (int u = 0; u < 360/2; u += STEP) {
      stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
      stars[index].y = sinf(u*M_PI/180.0)*sinf(t*M_PI/180.0) * 35;
      stars[index].z = cosf(u*M_PI/180.0) * 35;
      index++;
      if (index >= N) break;
    }
  }

  /*
  for (int t = 0; t < 360; t += STEP) {
    for (int u = 0; u < 360/2; u += STEP) {
      stars[index].x = u/2;
      stars[index].y = t/2;
      stars[index].z = u/2;
      index++;
      if (index >= N) break;
    }
  }
  */

  uint32_t *fb_ctrl = FB_CTRL;
  *fb_ctrl = 0;

  IO_OUT(GPIO_DIR, ~0);
  uint8_t led = 0x01;
  for (;;) {
    render_lines(stars, SIZEOF(stars), angle, angle, angle, s);
    oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
    *fb_ctrl ^= 1;
    angle += delta_angle;

    if (s >= 2) delta_scale = -delta_scale;
    if (s <= 0) delta_scale = -delta_scale;
    if (angle >= 359) delta_angle = -delta_angle;
    if (angle <= 0) delta_angle = -delta_angle;
    s += delta_scale;

    fill_oled(framebuffer, 0);
    IO_OUT(GPIO_OUTPUT, 0);
    led &= 7;
    //gpio_set_value((1 << led) | ((led >> 7) & 1)  , 1);
    gpio_set_value(led++, 1);

  }

}
