// kian riscv glx lib for oled sdd1331, author Hirosh Dabui
#ifndef GFX_LIB_H
#define GFX_LIB_H

#define HRES 96
#define VRES 64

#define SIZEOF(arr) sizeof(arr) / sizeof(*arr)

typedef int SCALAR;
typedef struct {
  SCALAR x;
  SCALAR y;
  SCALAR z;
} point;

uint16_t framebuffer[96*64];

/* fast sin/cosine by https://www.atwillys.de/content/cc/sine-lookup-for-embedded-in-c/ */
#define Q15 (1.0/(float)((1<<15)-1))
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
  for (int i = 0; i < (VRES*HRES); i++) {
    framebuffer[i] = rgb;
  }
}

point mirror_x_axis(point *p) {
  point transformed = {p->x, 1.0 * p->y};
  return transformed;
}

point mirror_y_axis(point *p) {
  point transformed = {-1.0 * p->x, p->y};
  return transformed;
}

point mirror_z_axis(point *p) {
  point transformed = {p->x, p->y, -1.0 * p->z};
  return transformed;
}

point scale(point *p, float sx, float sy, float sz) {
  point transformed = {p->x*sx, p->y*sy, p->z*sz};
  return transformed;
}

point translate(point *p, int tx, int ty, int tz) {
  point transformed = {p->x + tx, p->y + ty, p->z + tz};
  return transformed;
}


point rotateX_pivot(point *p, point *pivot, int angle) {
  point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};

  point transformed;

  float sin_theta = SIN_FAST(angle);
  float cos_theta = COS_FAST(angle);

  transformed.x = p->x;//pivot->x + p->x;
  transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
  transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);

  return transformed;
}

point rotateY_pivot(point *p, point *pivot, int angle) {
  point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};

  point transformed;

  float sin_theta = SIN_FAST(angle);
  float cos_theta = COS_FAST(angle);

  transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
  transformed.y = p->y;//pivot->y + p->y;
  transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);

  return transformed;
}

point rotateZ_pivot(point *p, point *pivot, int angle) {
  point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};

  point transformed;

  float sin_theta = SIN_FAST(angle);
  float cos_theta = COS_FAST(angle);

  transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
  transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
  transformed.z = p->z;//pivot->z + p->z;

  return transformed;
}
#endif // GFX_LIB_H
