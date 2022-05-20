/*
 *  kianv harris multicycle RISC-V rv32im
 *
 *  copyright (c) 2022 hirosh dabui <hirosh@dabui.de>
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

/////////////////////////////////
// Hardware register
`define FB_ADDR0          32'h 10_000_000
`define FB_ADDR1         (32'h 10_000_000 + 8192*4)
`define UART_TX_ADDR      32'h 30_000_000
`define UART_READY_ADDR   32'h 30_000_000
`define VIDEOENABLE_ADDR  32'h 30_000_008
`define VIDEO_ADDR        32'h 30_000_008
`define VIDEO_RAW_ADDR    32'h 30_000_00C
`define CPU_FREQ_REG_ADDR 32'h 30_000_010
`define GPIO_DIR_ADDR     32'h 30_000_014
`define GPIO_PULLUP_ADDR  32'h 30_000_018
`define GPIO_OUTPUT_ADDR  32'h 30_000_01C
`define GPIO_INPUT_ADDR   32'h 30_000_020
`define FRAME_BUFFER_CTRL 32'h 30_000_024
`define LED8X4_FB_ADDR    32'h 30_000_028
/////////////////////////////////


`ifdef ULX3S
`define LED_ULX3S
`define ECP5
`define GPIO
`endif

`ifdef COLORLIGHT_I5_I9
`define ECP5
`define GPIO
`endif

`ifdef NEXYSA7
`define FAKE_MULTIPLIER
`define CPU_HALT 1'b 1
`define PC_OUT
`define DDR_HDMI_TRANSFER 1'b 0
`define DIGILENT
`elsif ARTY7
`define FAKE_MULTIPLIER
`define DDR_HDMI_TRANSFER 1'b 1
`define DIGILENT
`elsif NEXYS_VIDEO
`define FAKE_MULTIPLIER
`define DDR_HDMI_TRANSFER 1'b 1
`define DIGILENT
`elsif ECP5
`define DDR_HDMI_TRANSFER 1'b 1
`else
`define DDR_HDMI_TRANSFER 1'b 1
`endif

`ifdef DIGILENT
`define SPI_NOR_PRESCALER_ENABLE
`define SPI_NOR_PRESCALER_DIVIDER 7
//`define OLED_SD1331
`define HDMI_VIDEO_FB
`define GPIO
`endif

`ifdef GPIO
`define GPIO_NR 8  // 0->32
`endif

`ifdef ICEBREAKER
`define OLED_SD1331
`define SPRAM
`endif

`ifdef ICEFUN
//`define PC_OUT
`define OLED_SD1331
`define LED_MATRIX8X4_FB
`endif


`define BAUDRATE          115200
//`define BAUDRATE          3_000_000

`ifdef KROETE
`define SYSTEM_CLK        30_000_000

`elsif ICEBREAKER
`define SYSTEM_CLK        19_000_000

`elsif ICEFUN
`define SYSTEM_CLK        30_000_000

`elsif ECP5
//`define SYSTEM_CLK        80_000_000
`define SYSTEM_CLK        70_000_000
`elsif ARTIX7
`ifdef ARTY7
`define SYSTEM_CLK        180_000_000
`elsif NEXYSA7
`define SYSTEM_CLK        150_000_000
`elsif NEXYS_VIDEO
`define SYSTEM_CLK        180_000_000
`elsif WUKONG
`define SYSTEM_CLK        175_000_000
//`define SYSTEM_CLK        25_000_000
`endif
`else
`define SYSTEM_CLK        25_000_000
`endif

`define SYSTEM_CLK_MHZ    (`SYSTEM_CLK / 1_000_000)

// sim stuff
`define DISABLE_WAVE      1'b0
`define SHOW_MACHINECODE  1'b0
`define SHOW_REGISTER_SET 1'b0
`define DUMP_MEMORY       1'b0

// cpu
`define RV32M             1'b1
//`undef RV32M

`define CSR_TIME_COUNTER  1'b1
//`undef CSR_TIME_COUNTER

// features
`define IOMEM_INTERFACING
`define IOMEM_INTERFACING_EXTERNAL
`undef IOMEM_INTERFACING_EXTERNAL
//`undef IOMEM_INTERFACING

// hdmi video buffer
`ifdef ECP5
`define FAKE_MULTIPLIER
`define HDMI_VIDEO_FB
//`define OLED_SD1331
//`define PSRAM_MEMORY_32MB
`endif
//`undef HDMI_VIDEO_FB

// offset for simulation only
`define SPI_NOR_MEM_ADDR_START    32'h 20_000_000
`ifdef KROETE
`define SPI_MEMORY_OFFSET         (135*1024)
`define SPI_NOR_MEM_ADDR_END      ((`SPI_NOR_MEM_ADDR_START) + (1024*256))
`elsif ICEFUN
`define SPI_MEMORY_OFFSET         (256*1024)
`define SPI_NOR_MEM_ADDR_END      ((`SPI_NOR_MEM_ADDR_START) + (32'h C0000))
`elsif ARTIX7

`ifdef ARTY7
`define SPI_MEMORY_OFFSET         (1024*1024*4)
`define SPI_NOR_MEM_ADDR_END      ((`SPI_NOR_MEM_ADDR_START) + (16*1024*1024))
`elsif NEXYSA7
`define SPI_MEMORY_OFFSET         (1024*1024*4)
`define SPI_NOR_MEM_ADDR_END      ((`SPI_NOR_MEM_ADDR_START) + (16*1024*1024))
`elsif NEXYS_VIDEO
`define SPI_MEMORY_OFFSET         (1024*1024*10)
`define SPI_NOR_MEM_ADDR_END      ((`SPI_NOR_MEM_ADDR_START) + (32*1024*1024))
`endif

`else
`define SPI_MEMORY_OFFSET         (1024*1024)
`define SPI_NOR_MEM_ADDR_END      ((`SPI_NOR_MEM_ADDR_START) + (16*1024*1024))
`endif

// PSRAM
`ifdef ECP5
//`define PSRAM_CACHE
`define CACHE_LINES (64)
`define PSRAM_MEM_ADDR_START      32'h 40_000_000
`define PSRAM_MEM_ADDR_END        ((`PSRAM_MEM_ADDR_START) + (32*1024*1024))
`define PSRAM_QUAD_MODE           1'b1
`define PSRAM_DEBUG_LA            1'b1
`undef PSRAM_DEBUG_LA
`endif

// SPRAM
`ifdef SPRAM
`define SPRAM_SIZE                (1024*128)
`define SPRAM_MEM_ADDR_START      32'h 10_000_000
`define SPRAM_MEM_ADDR_END        ((`SPRAM_MEM_ADDR_START) + (`SPRAM_SIZE))
`endif

`ifdef SIM
`define BRAM_FIRMWARE
`endif

//`define BRAM_FIRMWARE
`ifdef BRAM_FIRMWARE

`define RESET_ADDR        0
`define FIRMWARE_BRAM     "./firmware/firmware.hex"
`define FIRMWARE_SPI      ""
//`define BRAM_WORDS        (1024*2)
`define BRAM_WORDS        ('h10_000)
`else

`define RESET_ADDR        (`SPI_NOR_MEM_ADDR_START + `SPI_MEMORY_OFFSET)
`define FIRMWARE_BRAM     ""
`define FIRMWARE_SPI      "./firmware/firmware.hex"
`ifdef ECP5
`define BRAM_WORDS        (1024*16)
`elsif ARTIX7
`define BRAM_WORDS        (1024*16)
`else
`define BRAM_WORDS        (1024*2)
`endif
`endif


`endif  // KIANV_SOC
