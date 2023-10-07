#include <stdint.h>
//#define UART_TX (1<<13)
#define UART_TX 0x30000000//(1<<13)
#define UART_READY 0x30000004//(1<<13)

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

void putchar(char c) {
  while (!*((volatile uint32_t*) UART_READY))
    ;
  *((volatile uint32_t*) UART_TX) = c;
}

void print_chr(char ch) {
  while (!*((volatile uint32_t*) UART_READY))
    ;
  *((volatile uint32_t*) UART_TX) = ch;
}

void print_str(char *p) {
  while (*p != 0) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
    *((volatile uint32_t*) UART_TX) = *(p++);
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

void print_hex(unsigned int val, int digits) {
  for (int i = (4*digits)-4; i >= 0; i -= 4) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
    *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
  }
}

typedef short Pixel;


const int HRES = 640;
const int VRES = 480;


void setpixel(Pixel *fb, int x, int y, short color) {
  const int x_offset = x;
  const int y_offset = y*HRES;

  fb[x_offset + y_offset] = color;
}

#define mandel_shift 10
#define mandel_mul (1 << mandel_shift)
#define xmin -2*mandel_mul
#define ymax  2*mandel_mul
#define ymin -2*mandel_mul
#define xmax  2*mandel_mul
#define dx (xmax-xmin)/HRES
#define dy (ymax-ymin)/VRES
#define norm_max (4 << mandel_shift)

int indexed = 0;

void mandel(Pixel *framebuffer, short shift) {
  //  GL_write_window(0,0,W-1,H-1);
  int Ci = ymin;
  for(int Y = 0; Y < VRES; ++Y) {
    int Cr = xmin;
    for(int X = 0; X< HRES; ++X) {
      int Zr = Cr;
      int Zi = Ci;
      int iter = 15;
      while(iter > 0) {
        int Zrr = (Zr * Zr) >> mandel_shift;
        int Zii = (Zi * Zi) >> mandel_shift;
        int Zri = (Zr * Zi) >> (mandel_shift - 1);
        Zr = Zrr - Zii + Cr;
        Zi = Zri + Ci;
        if(Zrr + Zii > norm_max) {
          break;
        }
        --iter;
      }
      if(indexed) {
        //   GL_WRITE_DATA_UINT16(iter==0?0:(iter%15)+1);
          setpixel(framebuffer, X, Y, iter==0?0:(iter%15)+1);
      } else {
        //   GL_WRITE_DATA_UINT16((iter << 19)|(iter << 2));
          setpixel(framebuffer, X, Y, (iter << shift)|!(iter << shift)|(iter << shift));

      }

      Cr += dx;
    }
    Ci += dy;
  }
}


typedef unsigned char datum;
#define SIZE 256*1024*4/sizeof(datum)
//#define SIZE 10//680*480*2///sizeof(datum)//640*480//256*1024*4/sizeof(datum) 
#define BASE 0x10000000
datum *p = (volatile datum*) BASE;
void main() {

  short shift = 1;
  short *q = (volatile short*) BASE;
  int iter = 1;
  for (;;) {

  short *q = (volatile short*) BASE;

//  mandel(q, shift);

  shift = shift >= 8 ? 1 : shift + 1;
//  continue;
#if 0
    q = (volatile short*) BASE;
    for (int i = 0; i < 640*480; i++) {
      *q = 0x0ff00ff0;
      q++;
    }
    q = (volatile short*) BASE;
    for (int i = 0; i < 640*480; i++) {
      *q = 0x0f000f00;
      q++;
    }


    q = (volatile short*) BASE;
    for (int i = 0; i < 640*480; i++) {
      *q = 0x000f000f;
      q++;
    }
#endif

    print_char(13);
    print_str(GRN);
    print_str(BLINK);
    print_str(BOLD);
    print_str("Memory test iteration: ");
    print_dec(iter);
    print_char(13);
    print_str(RESET);
    print_str(BLINK_OFF);
    print_str_ln("=========================================");
    print_str(MAG);
    print_str("Size of datum         : ");
    print_str(WHT);
    print_str("0x");
    print_hex((unsigned int) sizeof(datum), 8);
    print_char(13);
    print_str(GRN);
    print_str("Size of memory to test: ");
    print_str(WHT);
    print_str("0x");
    print_hex((unsigned int) SIZE, 8);
    print_char(13);
    print_char(13);

    datum pattern = 1;
    datum antipattern = ~1;
    p = (volatile datum*) BASE;
    for (int i = 0; i < SIZE; i++, pattern++) {
      *p = pattern;
      p++;
    }

    print_str(CYN);
    print_str_ln("pattern write                       done!");

    pattern = 1;
    p = (volatile datum*) BASE;
    for (int i = 0; i < SIZE; i++, pattern++) {
//      print_hex((unsigned int) p, 8);
 //     print_char(13);
      if (*p != pattern) {
        print_str(RED);
        print_str("Error pattern in:");
        print_char(13);
        print_hex((unsigned int) pattern, 8);
        print_char(13);
        print_hex((unsigned int) p, 8);
        print_char(13);
        print_hex((unsigned int) *p, 8);
        print_char(13);
      }
      antipattern = ~pattern;
      *p = antipattern;
      p++;
    }

    print_str(YEL);
    print_str_ln("check pattern and antipattern write done!");

    p = (volatile datum*) BASE;
    pattern = 1;
    for (int i = 0; i < SIZE; i++, pattern++) {
      antipattern = ~pattern;
      if (*p != antipattern) {
        print_str(RED);
        print_str("Error antipattern in:");
        print_char(13);
        print_hex((unsigned int) antipattern, 8);
        print_char(13);
        print_hex((unsigned int) p, 8);
        print_char(13);
        print_hex((unsigned int) *p, 8);
        print_char(13);
      }
      *p = 0x00;
      p++;
    }
    print_str(WHT);
    print_str_ln("check antipattern and test          done!");
    print_str("\xa\xa\xa");

    iter++;
  }

}

