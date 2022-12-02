#include <stdint.h>
#include <math.h>

/* kian hardware register */
#define IO_BASE 0x30000000
#define UART_TX             (volatile uint32_t *) (IO_BASE + 0x0000)
#define UART_READY          (volatile uint32_t *) (IO_BASE + 0x0000)
#define VIDEOENABLE         (volatile uint32_t *) (IO_BASE + 0x0008)
#define VIDEO               (volatile uint32_t *) (IO_BASE + 0x0008)
#define VIDEO_RAW           (volatile uint32_t *) (IO_BASE + 0x000C)
#define CPU_FREQ            (volatile uint32_t *) (IO_BASE + 0x0010)
// gpio hack stuff
#define GPIO_DIR            ( volatile uint32_t  *) (IO_BASE + 0x0014)
#define GPIO_PULLUP         ( volatile uint32_t  *) (IO_BASE + 0x0018) // not implemented
#define GPIO_OUTPUT         ( volatile uint32_t  *) (IO_BASE + 0x001C)
#define GPIO_INPUT          ( volatile uint32_t  *) (IO_BASE + 0x0020)
#define IO_OUT(reg, value) *((volatile uint32_t  *) (reg)) = (value)
#define IO_IN(reg)         *((volatile uint32_t  *) reg)
// dma stuff
#define DMA_SRC             ( volatile uint32_t  *) (IO_BASE + 0x002C)
#define DMA_DST             ( volatile uint32_t  *) (IO_BASE + 0x0030)
#define DMA_LEN             ( volatile uint32_t  *) (IO_BASE + 0x0034)
#define DMA_CTRL            ( volatile uint32_t  *) (IO_BASE + 0x0038)
#define DMA_MEMCPY          (1 << 0)
#define DMA_MEMSET          (1 << 1)

#define GPIO_INPUT_PIN  0
#define GPIO_OUTPUT_PIN 1
//#define RV32_FASTCODE __attribute((section(".fastcode")))
#define RV32_FASTCODE

//__attribute((section(".fastcode")))

#define RED   "\x1B[31m"
#define GRN   "\x1B[32m"
#define YEL   "\x1B[33m"
#define BLU   "\x1B[34m"
#define MAG   "\x1B[35m"
#define CYN   "\x1B[36m"
#define WHT   "\x1B[37m"
#define RESET "\x1B[0m"

#define CLS       "\x1B[2J"
#define BOLD      "\x1B[1m"
#define BLINK     "\x1B[5m"
#define BLINK_OFF "\x1B[25m"

// dma stuff
void dma_action(uint32_t src, uint32_t dst, uint32_t len, uint32_t ctrl) {
  *( (volatile uint32_t*) DMA_SRC  ) = src;
  *( (volatile uint32_t*) DMA_DST  ) = dst;
  *( (volatile uint32_t*) DMA_LEN  ) = len;
  *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
}

void set_reg(volatile uint32_t *p, int gpio, int bit) {
    if (bit) {
      *p |=  (0x01 << (gpio & 0x1f));
    } else {
      *p &= ~( 0x01 << (gpio & 0x1f));
    }
}

void gpio_set_value(int gpio, int bit) {
    set_reg(GPIO_OUTPUT, gpio, bit);
}

uint32_t gpio_get_input_value(int gpio) {
  uint32_t read = IO_IN(GPIO_INPUT);

  //  return ((read & (1<<gpio)) >> gpio);
  return ((read >> gpio) & 0x01);
}

void gpio_set_direction(int gpio, int bit) {
    set_reg(GPIO_DIR, gpio, bit);
}

uint64_t get_cycles() {
  volatile uint32_t tmph0;
  volatile uint32_t tmpl0;

  asm volatile ("rdcycleh %0" : "=r"(tmph0));
  asm volatile ("rdcycle  %0" : "=r"(tmpl0));

  return ((uint64_t)(tmph0)<<32) + tmpl0;
  //  uint64_t rdinstret = ((uint64_t)(tmph1)<<32) + tmpl1;
}

inline uint32_t get_cpu_freq() {
  return *((volatile uint32_t*) CPU_FREQ);
}

void wait_cycles(uint64_t wait) {
  uint64_t lim = get_cycles() + wait;
  while (get_cycles() < lim)
    ;
}

void usleep(uint32_t us) {
  if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
}

void msleep(uint32_t ms) {
  if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
}

void sleep(uint32_t sec) {
  if (sec) wait_cycles(sec * get_cpu_freq());
}

uint64_t nanoseconds() {
  return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
}

uint64_t milliseconds() {
  return get_cycles() / (uint64_t) (get_cpu_freq() / 1000);
}

uint64_t seconds() {
  return get_cycles() / (uint64_t) (get_cpu_freq());
}

void putchar(char c) {
  *((volatile uint32_t*) UART_TX) = c;
}

void print_chr(char ch) {
  *((volatile uint32_t*) UART_TX) = ch;
  if (ch == 13)
    *((volatile uint32_t*) UART_TX) = 13;
}

void print_str(char *p) {
  while (*p != 0) {
    *((volatile uint32_t*) UART_TX) = *(p++);
  }
}
void print_str_ln(char *p) {
  print_str(p);
  print_chr(13);
}

void print_dec(unsigned int val) {
  char buffer[10];
  char *p = buffer;
  while (val || p == buffer) {
    *(p++) = val % 10;
    val = val / 10;
  }

  while (p != buffer) {
    *((volatile uint32_t*) UART_TX) = '0' + *(--p);
  }
}

void print_dec64(uint64_t val) {
  char buffer[20];
  char *p = buffer;
  while (val || p == buffer) {
    *(p++) = val % 10;
    val = val / 10;
  }

  while (p != buffer) {
    *((volatile uint32_t*) UART_TX) = '0' + *(--p);
  }
}

void print_hex(unsigned int val, int digits) {
  for (int i = (4*digits)-4; i >= 0; i -= 4) {
    *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
  }
}



typedef uint32_t Pixel;


void setpixel(volatile Pixel *fb, int x, int y, uint32_t color) {
  const int x_offset = x;
  const int y_offset = y*80;

  fb[x_offset + y_offset] = color;
}

void draw_bresenham(volatile Pixel *fb, int x0, int y0, int x1, int y1, uint32_t color)
{

  int dx =  abs(x1 - x0);
  int sx = x0 < x1 ? 1 : -1;
  int dy = -abs(y1 - y0);
  int sy = y0 < y1 ? 1 : -1;
  int err = dx + dy, e2; /* error value e_xy */

  for(;;) {  /* loop */
    setpixel(fb, x0, y0, color);
    if (x0 == x1 && y0 == y1) break;
    e2 = 2*err;
    if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
    if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
  }
}

