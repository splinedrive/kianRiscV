/* 2021 author Hirosh Dabui, kianRiscV example soc code */
#include <stdint.h>
#include "stdlib.c"
#include <stdbool.h>


// configure your spi pins here for pmod
/*
#define CS_PIN    0
#define SCLK_PIN  1
#define MOSI_PIN  2
#define MISO_PIN  3
*/
#define CS_PIN    0
#define MOSI_PIN  1
#define MISO_PIN  2
#define SCLK_PIN  3

#define DAT1_PIN  4
#define DAT2_PIN  5
#define CD_PIN    6

#define CS_HIGH      gpio_set_value(CS_PIN, 1)
#define CS_LOW       gpio_set_value(CS_PIN, 0)
#define SCLK_HIGH    gpio_set_value(SCLK_PIN, 1)
#define SCLK_LOW     gpio_set_value(SCLK_PIN, 0)
#define MOSI_HIGH    gpio_set_value(MOSI_PIN, 1)
#define MOSI_LOW     gpio_set_value(MOSI_PIN, 0)

#define DAT1_HIGH    gpio_set_value(DATA1_PIN, 1)
#define DAT1_LOW     gpio_set_value(DATA1_PIN, 0)
#define DAT2_HIGH    gpio_set_value(DATA2_PIN, 1)
#define DAT2_LOW     gpio_set_value(DATA2_PIN, 0)
#define CD_HIGH      gpio_set_value(CD_PIN, 1)
#define CD_LOW       gpio_set_value(CD_PIN, 0)

#define MISO_READ   gpio_get_input_value(MISO_PIN)

void spi_delay(void);
#define FAST_SPI 1
inline void spi_delay() {
#if FAST_SPI
  asm volatile ("add x0, x0, 0");
#else
  usleep(2);
#endif
}

void spi_init() {
  IO_OUT(GPIO_OUTPUT, 0);
  gpio_set_direction(CS_PIN, 1);
  gpio_set_direction(SCLK_PIN, 1);
  gpio_set_direction(MOSI_PIN, 1);
  gpio_set_direction(MISO_PIN, 0);
  gpio_set_direction(CD_PIN, 0);

  /*
  gpio_set_direction(DAT1_PIN, 0);
  gpio_set_direction(DAT2_PIN, 0);
  */
}

void set_spi_cs(bool high) {
  high ? CS_HIGH : CS_LOW;
  SCLK_LOW;
}

uint8_t spi_send(uint8_t tx) {
  uint8_t rx = 0;

  /*
  print_hex(tx, 2);
  printf("\n");
  */
  for (uint8_t i = 0; i < 8; i++) {
    rx <<= 1;
    (tx & 0x80) ? MOSI_HIGH : MOSI_LOW;
    spi_delay();
    SCLK_HIGH;
    rx |= MISO_READ;
    spi_delay();
    SCLK_LOW;
    spi_delay();
    tx <<= 1;
  }

  return rx;
}
