/* 2021 author Hirosh Dabui, kianRiscV example soc code */
#include <stdint.h>
#include "stdlib.c"
#include <stdbool.h>
/*  got knowhow and skelleton from http://www.bitbanging.space/posts/bitbang-i2c */
/*  i2c i2c_start sequence */

#define SCL_PIN  0
#define SDA_PIN  1

#define SDA_ON     gpio_set_value(SDA_PIN, 1)
#define SDA_OFF    gpio_set_value(SDA_PIN, 0)
#define SCL_ON     gpio_set_value(SCL_PIN, 1)
#define SCL_OFF    gpio_set_value(SCL_PIN, 0)
#define SDA_READ   gpio_get_input_value(SDA_PIN)
#define SCL_READ   gpio_get_input_value(SCL_PIN)

#define I2C_WR_FLAG 0x00
#define I2C_RD_FLAG 0x01
void i2c_delay(void);
//#define FAST_I2C 1
inline void i2c_delay() {
#if FAST_I2C
  asm volatile ("add x0, x0, 0");
#else
  usleep(2);
#endif
}

void i2c_start(){
  gpio_set_direction(SCL_PIN, GPIO_OUTPUT_PIN);
  gpio_set_direction(SDA_PIN, GPIO_OUTPUT_PIN);
  SDA_ON;
  i2c_delay();
  SCL_ON;
  i2c_delay();
  SDA_OFF;
  i2c_delay();
  SCL_OFF;
  i2c_delay();
}

/*  i2c i2c_stop sequence */
void i2c_stop(){
  gpio_set_direction(SCL_PIN, GPIO_OUTPUT_PIN);
  gpio_set_direction(SDA_PIN, GPIO_OUTPUT_PIN);
  SDA_OFF;
  i2c_delay();
  SCL_ON;
  i2c_delay();
  SDA_ON;
  i2c_delay();
}

/* Transmit 8 bit data to slave */
bool i2c_tx(uint8_t dat) {
  gpio_set_direction(SCL_PIN, GPIO_OUTPUT_PIN);
  gpio_set_direction(SDA_PIN, GPIO_OUTPUT_PIN);
  i2c_delay();

  for(uint8_t i = 8; i; i--) {
    (dat & 0x80) ? SDA_ON : SDA_OFF; //Mask for the eigth bit
    dat <<= 1;
    i2c_delay();
    SCL_ON;
    i2c_delay();
    SCL_OFF;
    i2c_delay();
  }
  //  SDA_ON;
  gpio_set_direction(SDA_PIN, GPIO_INPUT_PIN); // set input pin
  SCL_ON;
  i2c_delay();
  bool ack = !SDA_READ;    // Acknowledge bit
  SCL_OFF;
  gpio_set_direction(SDA_PIN, GPIO_OUTPUT_PIN); // set output pin
  return ack;
}

uint8_t i2c_rx(bool ack) {
  uint8_t dat = 0;
  SDA_ON;
  gpio_set_direction(SDA_PIN, GPIO_INPUT_PIN);
  gpio_set_direction(SCL_PIN, GPIO_OUTPUT_PIN);
  for(uint8_t i = 0; i < 8; i++){
    dat <<= 1;
    //    do{
    //      gpio_set_direction(SCL_PIN, GPIO_OUTPUT_PIN);
    SCL_ON;
    //     gpio_set_direction(SCL_PIN, GPIO_INPUT_PIN);
    //    } while(SCL_READ == 0);  //clock stretching
    i2c_delay();
    dat |= SDA_READ; /* 0 or 1 */
    i2c_delay();
    SCL_OFF;
  }

  gpio_set_direction(SDA_PIN, GPIO_OUTPUT_PIN);
  ack ? SDA_OFF : SDA_ON;
  SCL_ON;
  i2c_delay();
  SCL_OFF;
  return(dat);
}

uint8_t i2c_read_u8(uint8_t addr){
  uint8_t val;
  i2c_start();
  i2c_tx((addr<<1) | I2C_WR_FLAG);
  SDA_ON;
  i2c_delay();
  i2c_tx(0);
  i2c_stop();

  i2c_start();
  i2c_tx((addr<<1) | I2C_RD_FLAG);
  SDA_ON;
  i2c_delay();
  val = i2c_rx(0);
  i2c_stop();
  return val;
}

void i2c_write_u8(uint8_t addr, uint8_t reg, uint8_t value){
  i2c_start();
  i2c_tx((addr<<1) | I2C_WR_FLAG);
  SDA_ON;
  i2c_delay();
  i2c_tx(reg);
  SDA_ON;
  i2c_delay();
  i2c_tx(value);
  i2c_stop();
}

void i2c_write_raw_u8(uint8_t addr, uint8_t *data, uint16_t length) {
  i2c_start();
  i2c_tx((addr<<1) | I2C_WR_FLAG);

  SDA_ON;
  i2c_delay();
  for (int i = 0; i < length; i++) {
    i2c_tx(*(data + i));
    SDA_ON;
    i2c_delay();
  }
  i2c_stop();
}

