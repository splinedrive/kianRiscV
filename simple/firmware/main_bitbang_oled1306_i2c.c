/* 2021 author Hirosh Dabui, kianRiscV example soc code */
#include "kianv_i2c_bitbang.h"
//#define I2C_RTC_ADDR 0x68
#define I2C_SD1306_ADDR      0x3c

#define SETCONTRAST          0x81
#define DISPLAYALLON_RESUME  0xA4
#define DISPLAYALLON         0xA5
#define NORMALDISPLAY        0xA6
#define INVERTDISPLAY        0xA7
#define DISPLAYOFF           0xAE
#define DISPLAYON            0xAF
#define SETDISPLAYOFFSET     0xD3
#define SETCOMPINS           0xDA
#define SETVCOMDETECT        0xDB
#define SETDISPLAYCLOCKDIV   0xD5
#define SETPRECHARGE         0xD9
#define SETMULTIPLEX         0xA8
#define SETLOWCOLUMN         0x00
#define SETHIGHCOLUMN        0x10
#define SETSTARTLINE         0x40
#define MEMORYMODE           0x20
#define COLUMNADDR           0x21
#define PAGEADDR             0x22
#define COMSCANINC           0xC0
#define COMSCANDEC           0xC8
#define SEGREMAP             0xA0
#define CHARGEPUMP           0x8D

void commandx(uint8_t data[], uint16_t length) {
  i2c_write_raw_u8(I2C_SD1306_ADDR, data, length);
}
void command0(uint8_t val) {
  uint8_t data[2];
  data[0] = 0; data[1] = val;
  i2c_write_raw_u8(I2C_SD1306_ADDR, data, 2);
}

void command(uint8_t reg, uint8_t val) {
  uint8_t data[3];

  data[0] = 0; data[1] = reg; data[2] = val;

  i2c_write_raw_u8(I2C_SD1306_ADDR, data, 3);
}

void setup() {
  command0(DISPLAYOFF);
  command(SETDISPLAYCLOCKDIV, 0x80); // # the suggested ratio 0x80

  command(SETMULTIPLEX, 0x3f);

  command(SETDISPLAYOFFSET, 0);
  command0(SETSTARTLINE | 0x0);
  command(CHARGEPUMP, 0x14);
  command(MEMORYMODE, 0x02);
  command0(SEGREMAP | 0x1);
  command0(COMSCANDEC);

  command(SETCOMPINS, 0x12);
  command(SETCONTRAST, 0x7f);
  command(SETPRECHARGE, 0xf1);

  command(SETVCOMDETECT, 0x40);
  command0(DISPLAYALLON_RESUME);

  //command0(NORMALDISPLAY);
  command0(INVERTDISPLAY);
  command0(DISPLAYON);

  uint8_t data[] = {
    0x00,
    0x29,
    0x00,
    0x00,
    0x00,
    0x07,
    0x01,
    0x2f
  };
  commandx(data, sizeof(data)/sizeof(data[0]));
  commandx(data, sizeof(data)/sizeof(data[0]));

  
}

void main() {
  IO_OUT(GPIO_OUTPUT, 0);
  setup();
  for (;;) {
    //i2c_write_u8(I2C_RTC_ADDR, 0, 0x17);
//    print_hex(i2c_read_u8(I2C_RTC_ADDR), 2);
//    printf("\n");
  }
}
