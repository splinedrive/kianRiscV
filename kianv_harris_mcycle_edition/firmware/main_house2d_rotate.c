// kian riscv house rotation demo, author Hirosh Dabui
/* fast sin/cosine by https://www.atwillys.de/content/cc/sine-lookup-for-embedded-in-c/ */

#define DMA
#include <stdint.h>
#include <math.h>
#include <fenv.h>
#include "kianv_stdlib.h"

#define HRES 96
#define VRES 64

typedef struct {
  int x;
  int y;
} point;

uint16_t framebuffer[96*64];

point vector_model [] =
{
  {0,  10},   {5, 5},
  {5,  5},   {10, 10},
  {0,  10},   {10, 10},
  {10, 10},   {10, 20},
  {10, 20},  {0, 20},
  {0, 20},   {0, 10},

  {10-2, 20},   {10-2, 20-3},
  {10-2, 20-3},   {10-2-2, 20-3},
  {10-2-2, 20-3},   {10-2-2, 20},

  {1, 10+3}, {1+3, 10+3},
  {1+3, 10+3}, {1+3, 10+3+3},
  {1+3, 10+3+3}, {1, 10+3+3},
  {1, 10+3+3}, {1, 10+3}

};

#define Q15 (1.0/(float)((1<<15)-1))
#define TABLE_SIZE  (1<<5)
#define SCALER ((M_PI/2.0) / TABLE_SIZE)

#define COS_FAST(angle) (cos1((angle * 32768.0 / 360.0)) * Q15)
#define SIN_FAST(angle) (sin1((angle * 32768.0 / 360.0)) * Q15)

/*
 * The number of bits of our data type: here 16 (sizeof operator returns bytes).
 */
#define INT16_BITS  (8 * sizeof(int16_t))
#ifndef INT16_MAX
#define INT16_MAX   ((1<<(INT16_BITS-1))-1)
#endif

/*
 * "5 bit" large table = 32 values. The mask: all bit belonging to the table
 * are 1, the all above 0.
 */
#define TABLE_BITS  (5)
#define TABLE_SIZE  (1<<TABLE_BITS)
#define TABLE_MASK  (TABLE_SIZE-1)

/*
 * The lookup table is to 90DEG, the input can be -360 to 360 DEG, where negative
 * values are transformed to positive before further processing. We need two
 * additional bits (*4) to represent 360 DEG:
 */
#define LOOKUP_BITS (TABLE_BITS+2)
#define LOOKUP_MASK ((1<<LOOKUP_BITS)-1)
#define FLIP_BIT    (1<<TABLE_BITS)
#define NEGATE_BIT  (1<<(TABLE_BITS+1))
#define INTERP_BITS (INT16_BITS-1-LOOKUP_BITS)
#define INTERP_MASK ((1<<INTERP_BITS)-1)

/**
 * "5 bit" lookup table for the offsets. These are the sines for exactly
 * at 0deg, 11.25deg, 22.5deg etc. The values are from -1 to 1 in Q15.
 */
static int16_t sin90[TABLE_SIZE+1] = {
  0x0000,0x0647,0x0c8b,0x12c7,0x18f8,0x1f19,0x2527,0x2b1e,
  0x30fb,0x36b9,0x3c56,0x41cd,0x471c,0x4c3f,0x5133,0x55f4,
  0x5a81,0x5ed6,0x62f1,0x66ce,0x6a6c,0x6dc9,0x70e1,0x73b5,
  0x7640,0x7883,0x7a7c,0x7c29,0x7d89,0x7e9c,0x7f61,0x7fd7,
  0x7fff
};


/**
 * Sine calculation using interpolated table lookup.
 * Instead of radiants or degrees we use "turns" here. Means this
 * sine does NOT return one phase for 0 to 2*PI, but for 0 to 1.
 * Input: -1 to 1 as int16 Q15  == -32768 to 32767.
 * Output: -1 to 1 as int16 Q15 == -32768 to 32767.
 *
 * See the full description at www.AtWillys.de for the detailed
 * explanation.
 *
 * @param int16_t angle Q15
 * @return int16_t Q15
 */
int16_t sin1(int16_t angle)
{
  int16_t v0, v1;
  if(angle < 0) { angle += INT16_MAX; angle += 1; }
  v0 = (angle >> INTERP_BITS);
  if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
  v0 &= TABLE_MASK;
  v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
  if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
  return v1;
}

/**
 * Cosine calculation using interpolated table lookup.
 * Instead of radiants or degrees we use "turns" here. Means this
 * cosine does NOT return one phase for 0 to 2*PI, but for 0 to 1.
 * Input: -1 to 1 as int16 Q15  == -32768 to 32767.
 * Output: -1 to 1 as int16 Q15 == -32768 to 32767.
 *
 * @param int16_t angle Q15
 * @return int16_t Q15
 */
int16_t cos1(int16_t angle)
{
  if(angle < 0) { angle += INT16_MAX; angle += 1; }
  return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
}

/* 1: data, 0: cmd */
void oled_spi_tx (uint8_t tx, uint8_t data_cmd) {
  *((volatile uint32_t *) VIDEO_RAW) = (data_cmd << 8) | tx;
}

void draw_line_oled(int x0, int y0, int x1, int y1, short color) {

  if  ( x0 > HRES ) x0 = HRES;
  if  ( y0 > VRES ) y0 = VRES;
  if  ( x1 > HRES ) x1 = HRES;
  if  ( y1 > VRES ) y1 = VRES;

  //  oled_spi_tx(0x26, 0);
  //  oled_spi_tx(0x00, 0);
  oled_spi_tx(0x21, 0);
  oled_spi_tx(x0, 0);
  oled_spi_tx(y0, 0);
  oled_spi_tx(x1, 0);
  oled_spi_tx(y1, 0);
  oled_spi_tx((color>>11 & 0x1f)<<1, 0);  // b
  oled_spi_tx(color>>5 & 0x3f, 0);  // g
  oled_spi_tx((color & 0x1f)<<1, 0);  // r
}

void oled_max_window() {
  oled_spi_tx(0x15, 0); oled_spi_tx(0, 0); oled_spi_tx(0x5f, 0);
  oled_spi_tx(0x75, 0); oled_spi_tx(0, 0); oled_spi_tx(0x3f, 0);
}

void oled_show_fb(uint16_t *framebuffer) {
  oled_spi_tx(0x15, 0); oled_spi_tx(0, 0); oled_spi_tx(0x0, 0);
  oled_spi_tx(0x75, 0); oled_spi_tx(0, 0); oled_spi_tx(0x00, 0);

  oled_spi_tx(0x15, 0); oled_spi_tx(0, 0); oled_spi_tx(95, 0);
  oled_spi_tx(0x75, 0); oled_spi_tx(0, 0); oled_spi_tx(63, 0);

  for (int i = 0; i < (VRES*HRES); i++) {
    unsigned char buf[2];

    buf[0] = (framebuffer[i] >> 8) & 0xff;
    buf[1] = (framebuffer[i]) & 0xff;
    oled_spi_tx(buf[0], 1);
    oled_spi_tx(buf[1], 1);
  }

  oled_max_window();
}


void fb_setpixel(uint16_t *fb, int x, int y, short color) {
  /*
     const int x_offset = x;
     const int y_offset = y*HRES;

     fb[x_offset + y_offset] = color;
     */
  if  ( x > (HRES-1) ) return;
  if  ( y > (VRES-1) ) return;
  if  ( x <= 0 ) return;
  if  ( y <= 0) return;
  fb[x + y*HRES] = color;
}

void fb_draw_bresenham(uint16_t *fb, int x0, int y0, int x1, int y1, short color)
{

  int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
  int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
  int err = dx + dy, e2; /* error value e_xy */

  for(;;) {  /* loop */
    fb_setpixel(fb, x0, y0, color);
    if (x0 == x1 && y0 == y1) break;

    e2 = 2*err;
    if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
    if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
  }
}

void fill_oled(uint16_t *framebuffer, int rgb) {
  /*
     for (int y = 0; y < 64; y++) {
     for (int x = 0; x < 96; x++) {
   *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
   }
   }
   */
  for (int i = 0; i < (VRES*HRES); i++) {
    framebuffer[i] = rgb;
  }
}

point scale(point *p, float sx, float sy) {
  point transformed = {p->x*sx, p->y*sy};
  return transformed;
}

point translate(point *p, int tx, int ty) {
  point transformed = {p->x+tx, p->y+ty};
  return transformed;
}

point rotate(point *p, int angle) {
  point transformed = {p->x, p->y};

  transformed.x = transformed.x*COS_FAST(angle) - transformed.y*SIN_FAST(angle);
  transformed.y = transformed.x*SIN_FAST(angle) + transformed.y*COS_FAST(angle);

  return transformed;
}

point rotate_pivot(point *p, point *pivot, int angle) {
  point shifted_point = {p->x - pivot->x, p->y - pivot->y};

  point transformed;
  transformed.x = pivot->x + (shifted_point.x * COS_FAST(angle)
      - shifted_point.y * SIN_FAST(angle));
  transformed.y = pivot->y + (shifted_point.x * SIN_FAST(angle)
      + shifted_point.y * COS_FAST(angle));

  return transformed;
}

point mirror_x_axis(point *p) {
  point transformed = {p->x, 1.0 * p->y};
  return transformed;
}

point mirror_y_axis(point *p) {
  point transformed = {-1.0 * p->x, p->y};
  return transformed;
}

void main() {
  init_oled1331();
  fill_oled(framebuffer, 0x0000);

  int angle = 0;
  int delta_angle = 1; /* speedup rotation, - for left rotation */

  float s = 1;
  float delta_scale = 0.2; /* speedup scale */
  for (;;) {
    for (int i = 0; i < (sizeof(vector_model) / sizeof(vector_model[0])) - 1; i = i + 2) {
      point p0 = vector_model[i];
      point p1 = vector_model[i + 1];

      p0 = scale(&p0, s, s);
      p1 = scale(&p1, s, s);

      p0 = translate(&p0, HRES/2 -5*s, VRES/2 -15*s);
      p1 = translate(&p1, HRES/2 -5*s, VRES/2 -15*s);

      point pivot = {HRES/2, VRES/2};

      p0 = rotate_pivot(&p0, &pivot, angle);
      p1 = rotate_pivot(&p1, &pivot, angle);

      fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, 0xffff);

    }
    oled_show_fb(framebuffer);
    angle += delta_angle;

    if (angle >= 359) angle = 0;
    if (s >= 20) delta_scale = -delta_scale;
    if (s <= 0) delta_scale = -delta_scale;
    s += delta_scale;

    fill_oled(framebuffer, 0);

  }

}
