/*
 *  kianv harris multicycle RISC-V rv32im
 *
 *  copyright (c) 2023 hirosh dabui <hirosh@dabui.de>
 *
 *  permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  the software is provided "as is" and the author disclaims all warranties
 *  with regard to this software including all implied warranties of
 *  merchantability and fitness. in no event shall the author be liable for
 *  any special, direct, indirect, or consequential damages or any damages
 *  whatsoever resulting from loss of use, data or profits, whether in an
 *  action of contract, negligence or other tortious action, arising out of
 *  or in connection with the use or performance of this software.
 *
 */
`ifndef KIANV_SOC
`define KIANV_SOC

`define CPU_FREQ_REG_ADDR 32'h 30_000_010
`define BAUDRATE          3_000_000

`define UART_TX_ADDR      32'h 10_000_000
`define UART_RX_ADDR      32'h 10_000_000
`define UART_LSR_ADDR     32'h 10_000_005


`define RV32M
`define FAKE_MULTIPLIER
`define LED_ULX3S

`define QUAD_SPI_FLASH_MODE 1'b1

`define UART_TX
`define UART_RX

`define SDRAM_MEM_ADDR_START      32'h 80_000_000
`define SDRAM_SIZE                (1024*1024*32)
`define SDRAM_MEM_ADDR_END        ((`SDRAM_MEM_ADDR_START) + (`SDRAM_SIZE))

`define SYSTEM_CLK        70_000_000
`define SYSTEM_CLK_MHZ    (`SYSTEM_CLK / 1_000_000)

`define SPI_NOR_MEM_ADDR_START    32'h 20_000_000

`define SPI_MEMORY_OFFSET         (1024*1024)
`define SPI_NOR_MEM_ADDR_END      ((`SPI_NOR_MEM_ADDR_START) + (16*1024*1024))

`define RESET_ADDR        (`SPI_NOR_MEM_ADDR_START + `SPI_MEMORY_OFFSET)
`define FIRMWARE_BRAM     ""
`define BRAM_WORDS        (1024*16)

`endif
