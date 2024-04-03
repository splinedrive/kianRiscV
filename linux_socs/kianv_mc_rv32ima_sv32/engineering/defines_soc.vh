/*
 *  kianv harris multicycle RISC-V rv32im
 *
 *  copyright (c) 2023/2024 hirosh dabui <hirosh@dabui.de>
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

//`define SYSTEM_CLK 60_000_000 // defined in Makefile
`define KIANV_SPI_CTRL0_FREQ 35_000_000 // sdcard
`define SYSTEM_CLK_MHZ (`SYSTEM_CLK / 1_000_000)
`define ENABLE_ACCESS_FAULT (1'b1) // It will slow down the design when is enabled

`define FPGA_MULTIPLIER
// Defines the number of entries for both instruction and data TLB
`define NUM_ENTRIES_PER_TLB 64
`define ICACHE_ENTRIES_PER_WAY 64

`define REBOOT_ADDR 32'h 11_100_000
`define REBOOT_DATA 16'h 7777
`define HALT_DATA 16'h 5555

`define DIV_ADDR 32'h 10_000_010
`define CPU_FREQ_REG_ADDR 32'h 10_000_014
`define KIANV_GPIO_DIR 32'h 10_000_700
`define KIANV_GPIO_OUTPUT 32'h 10_000_704
`define KIANV_GPIO_INPUT 32'h 10_000_708

`define UART_TX_ADDR0 32'h 10_000_000
`define UART_RX_ADDR0 32'h 10_000_000
`define UART_LSR_ADDR0 32'h 10_000_005

`define UART_TX_ADDR1 32'h 10_000_100
`define UART_RX_ADDR1 32'h 10_000_100
`define UART_LSR_ADDR1 32'h 10_000_105

`define UART_TX_ADDR2 32'h 10_000_200
`define UART_RX_ADDR2 32'h 10_000_200
`define UART_LSR_ADDR2 32'h 10_000_205

`define UART_TX_ADDR3 32'h 10_000_300
`define UART_RX_ADDR3 32'h 10_000_300
`define UART_LSR_ADDR3 32'h 10_000_305

`define UART_TX_ADDR4 32'h 10_000_400
`define UART_RX_ADDR4 32'h 10_000_400
`define UART_LSR_ADDR4 32'h 10_000_405

// sd card
`define KIANV_SPI_CTRL0 32'h 10_500_000
`define KIANV_SPI_DATA0 32'h 10_500_004

// network
`define KIANV_SPI_CTRL1 32'h 10_500_100
`define KIANV_SPI_DATA1 32'h 10_500_104
`define KIANV_SPI_CTRL1_FREQ 13_000_000

// oled display
`define KIANV_SPI_CTRL2 32'h 10_500_200
`define KIANV_SPI_DATA2 32'h 10_500_204
`define KIANV_SPI_CTRL2_FREQ 20_000_000

`define KIANV_SND_REG 32'h 10_500_300
`define KIANV_AUDIO_PWM_BUFFER (1 << 16)

`define SDRAM_MEM_ADDR_START 32'h 80_000_000
`define SDRAM_SIZE (1024*1024*32)
`define SDRAM_MEM_ADDR_END ((`SDRAM_MEM_ADDR_START) + (`SDRAM_SIZE))

`define QUAD_SPI_FLASH_MODE 1'b1
`define SPI_NOR_MEM_ADDR_START 32'h 20_000_000
`define SPI_MEMORY_OFFSET (1024*1024*1)
`define SPI_NOR_MEM_ADDR_END ((`SPI_NOR_MEM_ADDR_START) + (16*1024*1024))

`define HAS_BRAM
`define RESET_ADDR 0 //(`SPI_NOR_MEM_ADDR_START + `SPI_MEMORY_OFFSET)
`define FIRMWARE_BRAM "bootloader/bootloader.hex"
`define BRAM_WORDS (1024*3)

`endif  // KIANV_SOC
