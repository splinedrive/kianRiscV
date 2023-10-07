#include "kianv_spi_bitbang.h"

/* loopback test */
/* for pin adjustments look into kianv_spi_bitbang.h */
void main() {
  spi_init();
  set_spi_cs(true);
  printf("spi bitbanging kianRiscV\n");

  uint8_t tx;

  for (;;) {
    set_spi_cs(false);
    uint8_t rx = spi_send(tx);
    set_spi_cs(true);
    if (tx != rx) {
        printf("error\n");
        for (;;);
    } else tx++;
    print_hex(rx, 2);
    printf("\n");
  }
}
