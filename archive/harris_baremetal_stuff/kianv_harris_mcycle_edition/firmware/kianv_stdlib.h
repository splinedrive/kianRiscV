#include <stdint.h>
#include <math.h>
#include "SSD1331.h"

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

void _sendCmd(uint8_t c)
{
    //digitalWrite(_dc,LOW);
    //digitalWrite(_cs,LOW);
    // SPI.transfer(c);
    *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
    //digitalWrite(_cs,HIGH);
}

void _sendData(uint8_t c)
{
    //digitalWrite(_dc,LOW);
    //digitalWrite(_cs,LOW);
    // SPI.transfer(c);
    *((volatile uint32_t *) VIDEO_RAW) = ((0x01) << 8) | c;
    //digitalWrite(_cs,HIGH);
}

void init_oled1331(void)
{
    //pinMode(_dc, OUTPUT);
    //pinMode(_cs, OUTPUT);

    //SPI.begin();

    _sendCmd(CMD_DISPLAY_OFF);	//Display Off
    _sendCmd(CMD_SET_CONTRAST_A);	//Set contrast for color A
    _sendCmd(0x91);		//145
    _sendCmd(CMD_SET_CONTRAST_B);	//Set contrast for color B
    _sendCmd(0x80);		//80
    _sendCmd(CMD_SET_CONTRAST_C);	//Set contrast for color C
    _sendCmd(0x7D);		//125
    _sendCmd(CMD_MASTER_CURRENT_CONTROL);	//master current control
    _sendCmd(0x06);		//6
    _sendCmd(CMD_SET_PRECHARGE_SPEED_A);	//Set Second Pre-change Speed For ColorA
    _sendCmd(0x64);		//100
    _sendCmd(CMD_SET_PRECHARGE_SPEED_B);	//Set Second Pre-change Speed For ColorB
    _sendCmd(0x78);		//120
    _sendCmd(CMD_SET_PRECHARGE_SPEED_C);	//Set Second Pre-change Speed For ColorC
    _sendCmd(0x64);		//100
    _sendCmd(CMD_SET_REMAP);	//set remap & data format
    _sendCmd(0x72);		//0x72
    _sendCmd(CMD_SET_DISPLAY_START_LINE);	//Set display Start Line
    _sendCmd(0x0);
    _sendCmd(CMD_SET_DISPLAY_OFFSET);	//Set display offset
    _sendCmd(0x0);
    _sendCmd(CMD_NORMAL_DISPLAY);	//Set display mode
    _sendCmd(CMD_SET_MULTIPLEX_RATIO);	//Set multiplex ratio
    _sendCmd(0x3F);
    _sendCmd(CMD_SET_MASTER_CONFIGURE);	//Set master configuration
    _sendCmd(0x8E);
    _sendCmd(CMD_POWER_SAVE_MODE);	//Set Power Save Mode
    _sendCmd(0x00);		//0x00
    _sendCmd(CMD_PHASE_PERIOD_ADJUSTMENT);	//phase 1 and 2 period adjustment
    _sendCmd(0x31);		//0x31
    _sendCmd(CMD_DISPLAY_CLOCK_DIV);	//display clock divider/oscillator frequency
    _sendCmd(0xF0);
    _sendCmd(CMD_SET_PRECHARGE_VOLTAGE);	//Set Pre-Change Level
    _sendCmd(0x3A);
    _sendCmd(CMD_SET_V_VOLTAGE);	//Set vcomH
    _sendCmd(0x3E);
    _sendCmd(CMD_DEACTIVE_SCROLLING);	//disable scrolling
    _sendCmd(CMD_NORMAL_BRIGHTNESS_DISPLAY_ON);	//set display on
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
  while (!*((volatile uint32_t*) UART_READY))
    ;
  *((volatile uint32_t*) UART_TX) = c;
   if (c == 13) {
    *((volatile uint32_t*) UART_TX) = 10;
  }
}

void print_chr(char ch) {
  putchar(ch);
}

void print_char(char ch) {
  print_chr(ch);
}

void print_str(char *p) {
  while (*p != 0) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
    putchar(*(p++));
  }
}

void print_str_ln(char *p) {
  print_str(p);
  print_char(13);
}

void print_dec(unsigned int val) {
  char buffer[10];
  char *p = buffer;
  while (val || p == buffer) {
    *(p++) = val % 10;
    val = val / 10;
  }

  while (p != buffer) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
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
    while (!*((volatile uint32_t*) UART_READY))
      ;
    *((volatile uint32_t*) UART_TX) = '0' + *(--p);
  }
}

void print_hex(unsigned int val, int digits) {
  for (int i = (4*digits)-4; i >= 0; i -= 4) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
    *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
  }
}



typedef short Pixel;


void setpixel(volatile Pixel *fb, int x, int y, short color) {
/*
  const int x_offset = x;
  const int y_offset = y*HRES;

  fb[x_offset + y_offset] = color;
*/
*((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
}

void draw_bresenham(volatile Pixel *fb, int x0, int y0, int x1, int y1, short color)
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
