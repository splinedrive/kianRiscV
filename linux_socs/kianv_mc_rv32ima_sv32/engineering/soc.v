/*
 *  kianv.v - RISC-V rv32ima
 *
 *  copyright (c) 2023/2025 hirosh dabui <hirosh@dabui.de>
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

`default_nettype none `timescale 1 ns / 100 ps
`include "defines_soc.vh"
module soc #(
    parameter NUM_UARTS = 2
) (
    input wire clk_osc,

    output wire [NUM_UARTS-1:0] uart_tx,
    input  wire [NUM_UARTS-1:0] uart_rx,

`ifdef SOC_HAS_8LEDS
    output wire [7:0] led,
`endif
`ifdef SOC_HAS_1LED
    output wire led,
`endif

`ifdef SOC_HAS_EXT_FLASH
    output wire flash_csn,
    inout  wire flash_miso,
    inout  wire flash_mosi,
    inout  wire flash_io2,
    inout  wire flash_io3,
`endif
`ifdef SOC_HAS_SDRAM_W9864G6JT
    output wire        sdram_clk,
    output wire        sdram_cke,
    output wire [ 1:0] sdram_dqm,
    output wire [11:0] sdram_addr,  //  A0-A10 row address, A0-A7 column address
    output wire [ 1:0] sdram_ba,    // bank select A11,A12
    output wire        sdram_csn,
    output wire        sdram_wen,
    output wire        sdram_rasn,
    output wire        sdram_casn,
    inout  wire [15:0] sdram_dq,
`elsif SOC_HAS_SDRAM_M12L64322A
    output wire        sdram_clk,
    //    output wire        sdram_cke,
    //    output wire [ 1:0] sdram_dqm,
    output wire [10:0] sdram_addr,  //  A0-A10 row address, A0-A7 column address
    output wire [ 1:0] sdram_ba,    // bank select A11,A12
    //   output wire        sdram_csn,
    output wire        sdram_wen,
    output wire        sdram_rasn,
    output wire        sdram_casn,
    inout  wire [31:0] sdram_dq,
`elsif SOC_HAS_SDRAM_MT48LC16M16A2
    output wire        sdram_clk,
    output wire        sdram_cke,
    output wire [ 1:0] sdram_dqm,
    output wire [12:0] sdram_addr,  //  A0-A10 row address, A0-A7 column address
    output wire [ 1:0] sdram_ba,    // bank select A11,A12
    output wire        sdram_csn,
    output wire        sdram_wen,
    output wire        sdram_rasn,
    output wire        sdram_casn,
    inout  wire [15:0] sdram_dq,
`endif
    output wire spi_cen0,
    output wire spi_sclk0,
    inout  wire spi_sio1_so_miso0,
    inout  wire spi_sio0_si_mosi0
`ifdef SOC_HAS_NETWORK
    ,output wire spi_cen1,
    output wire spi_sclk1,
    inout  wire spi_sio1_so_miso1,
    inout  wire spi_sio0_si_mosi1
`endif

`ifdef SOC_HAS_EXT_OLED
    ,output wire         oled_cs,
    output wire         oled_sck,
    inout  wire         oled_mosi,
    output wire [23:21] gp
`endif

`ifdef SOC_HAS_AUDIO
  ,output wire audio_r,
  output wire audio_l,
  output wire audio_gain,
  output wire audio_shutdown
`endif

`ifdef SOC_HAS_GPIO
    ,inout wire [9:0] gpio
`endif

`ifdef SOC_IS_ULX3S
    ,output wire wifi_en
`endif
);

  localparam INDEX_UART_NUM_WIDTH = $clog2(NUM_UARTS);
  // Concatenate them into one large parameter
  parameter [NUM_UARTS*32 -1:0] UART_LSR_ADDRS = {
    `UART_LSR_ADDR0, `UART_LSR_ADDR1
  };  //, `UART_LSR_ADDR2, `UART_LSR_ADDR3};//, `UART_LSR_ADDR4};
  parameter [NUM_UARTS*32 -1:0] UART_TX_ADDRS = {
    `UART_TX_ADDR0, `UART_TX_ADDR1
  };  //, `UART_TX_ADDR2, `UART_TX_ADDR3};//, `UART_TX_ADDR4};
  parameter [NUM_UARTS*32 -1:0] UART_RX_ADDRS = {
    `UART_RX_ADDR0, `UART_RX_ADDR1
  };  //, `UART_RX_ADDR2, `UART_RX_ADDR3};//, `UART_RX_ADDR4};

  wire clk;
  // reset
  reg [7:0] rst_cnt = 0;
  wire resetn = rst_cnt[7];

`ifdef SOC_HAS_EXT_OLED
  assign gp = {resetn, 1'b1, 1'b1};
`endif


  wire [31:0] PC  /* verilator public_flat_rw */;


  wire flash_sclk;
`ifdef SOC_HAS_EXT_FLASH
  wire flash_clk;
  USRMCLK u1 (
      .USRMCLKI (flash_clk),
      .USRMCLKTS(1'b0)
  );
  assign flash_clk = flash_sclk;
`endif

`ifdef SOC_IS_ULX3S
  assign wifi_en = 1'b1;
`endif

  reg [7:0] dim;
  always @(posedge clk) dim <= !resetn ? 0 : dim + 1;

`ifdef SOC_HAS_8LEDS
`ifdef SOC_HAS_GPIO
  assign led = {8{dim[7]}} & {gpio[8], PC[17+:7]};
`else
  assign led = {8{dim[7]}} & {PC[17+:8]};
`endif
`endif
`ifdef SOC_HAS_1LED
  assign led = dim[7] & PC[10];
`endif

  wire locked;
`ifdef SOC_IS_ECP5
  pll #(
      .freq(`SYSTEM_CLK / 1_000_000)
  ) pll_I0 (
      clk_osc,
      clk,
      locked
  );
`endif
`ifdef SOC_IS_ARTIX7
  pll pll_I0 (
      clk,
      locked,
      clk_osc
  );
`endif
`ifdef SOC_IS_CYCLONE10
  pll pll_I0 (
      clk_osc,
      clk,
      locked
  );
`endif

  localparam BYTE_ADDRESS_LEN = 32;
  localparam BYTES_PER_BLOCK = 4;
  localparam DATA_LEN = 32;
  localparam BLOCK_ADDRESS_LEN = BYTE_ADDRESS_LEN - $clog2(BYTES_PER_BLOCK);


`ifdef HAS_BRAM
  localparam BRAM_ADDR_WIDTH = $clog2(`BRAM_WORDS);
`endif

  //////////////////////////////////////////////////////////////////////////////
  /* SYSCON */


  // cpu
  wire is_instruction;
  wire icache_flush;
  wire [5:0] ctrl_state;

  wire cpu_mem_ready  /* verilator public_flat_rw */;
  wire cpu_mem_valid  /* verilator public_flat_rw */;

  wire [3:0] cpu_mem_wstrb  /* verilator public_flat_rw */;
  wire [31:0] cpu_mem_addr  /* verilator public_flat_rw */;
  wire [31:0] cpu_mem_wdata  /* verilator public_flat_rw */;
  wire [31:0] cpu_mem_rdata  /* verilator public_flat_rw */;

  // RISC-V is byte-addressable, alignment memory devices word organized
  // memory interface
  wire wr = |cpu_mem_wstrb;
  wire rd = ~wr;

  wire [31:0] cache_addr_o;
  wire [31:0] cache_din_o;
  wire [3:0] cache_wmask_o;
  wire cache_valid_o;
  wire [31:0] cache_dout_i;


  wire [31:0] bram_rdata;
  reg bram_ready;
  wire bram_valid;

  wire is_reboot_addr = (cpu_mem_addr == `REBOOT_ADDR);
  wire is_reboot_data = (cpu_mem_wdata[15:0] == `REBOOT_DATA);
  wire is_reboot = is_reboot_addr || is_reboot_data;

  wire is_reboot_valid = cpu_mem_valid && is_reboot_addr && is_reboot_data && wr;
  reg  is_reboot_valid_r;
  always @(posedge clk) is_reboot_valid_r <= !resetn ? 1'b0 : is_reboot_valid;

  always @(posedge clk) begin
    if (!locked || is_reboot_valid_r) rst_cnt <= 0;
    else rst_cnt <= rst_cnt + {7'b0, !resetn};
  end

  // uart tx
  wire [NUM_UARTS-1:0] uart_tx_valid;
  reg [NUM_UARTS-1:0] uart_tx_ready;

  // uart rx
  wire [NUM_UARTS-1:0] uart_rx_valid;
  reg [NUM_UARTS-1:0] uart_rx_ready;

  wire [31:0] rx_uart_data[NUM_UARTS-1:0];

  wire spi_nor_mem_ready;
  wire [31:0] spi_nor_mem_data;
`ifdef SOC_HAS_EXT_FLASH
  // spi flash memory
  wire spi_nor_mem_valid;
`endif

  // spi interface
  wire [31:0] spi_mem_data0;
  wire spi_sio2_0;
  wire spi_sio3_0;
  wire spi_mem_valid0;
  wire spi_mem_ready0;

  wire spi_mem_valid1;
  wire spi_mem_ready1;
  wire [31:0] spi_mem_data1;

  // spi interface
  wire spi_mem_valid2;
  wire spi_mem_ready2;

  // cpu_freq
  wire system_cpu_freq_valid;
  reg system_cpu_freq_ready;

  // divider
  wire div_valid;
  reg div_ready;

  wire [29:0] word_aligned_addr = {cpu_mem_addr[31:2]};

  // cpu_freq

  // cpu_freq
  assign system_cpu_freq_valid   = !system_cpu_freq_ready && cpu_mem_valid && (cpu_mem_addr == `CPU_FREQ_REG_ADDR) && !wr;
  always @(posedge clk) system_cpu_freq_ready <= !resetn ? 1'b0 : system_cpu_freq_valid;

  // Memory size register
  wire system_mem_size_access_valid;
  reg system_mem_size_access_ready;

  assign system_mem_size_access_valid = !system_mem_size_access_ready && cpu_mem_valid && (cpu_mem_addr == `CPU_MEMSIZE_REG_ADDR) && !wr;
  always @(posedge clk) system_mem_size_access_ready <= !resetn ? 1'b0 : system_mem_size_access_valid;

  // div reg
  reg [31:0] div_reg;
  assign div_valid = !div_ready && cpu_mem_valid && (cpu_mem_addr == `DIV_ADDR);  // && !wr;
  always @(posedge clk) div_ready <= !resetn ? 1'b0 : div_valid;
  always @(posedge clk) begin
    if (!resetn) begin
      div_reg <= 0;
    end else begin
      if (div_valid && wr) div_reg <= cpu_mem_wdata;
    end
  end

  wire is_flash;
`ifdef SOC_HAS_EXT_FLASH
  /////////////////////////////////////////////////////////////////////////////

  // SPI nor flash
  assign is_flash = (cpu_mem_addr >= `SPI_NOR_MEM_ADDR_START && cpu_mem_addr < `SPI_NOR_MEM_ADDR_END);
  assign spi_nor_mem_valid = !spi_nor_mem_ready && cpu_mem_valid && is_flash && !wr;

  generate
    if (`QUAD_SPI_FLASH_MODE == 1'b1) begin
      qqspi #(
          .QUAD_MODE(1'b1),
          .CEN_NPOL(1'b0),
          .PSRAM_SPIFLASH(1'b0)
      ) spi_nor_flash_I (
          .addr ({1'b0, word_aligned_addr[21:0]}),
          .wdata(),
          .rdata(spi_nor_mem_data),
          .wstrb(4'b0000),
          .ready(spi_nor_mem_ready),
          .valid(spi_nor_mem_valid),

          .cen         (flash_csn),
          .sclk        (flash_sclk),
          .sio0_si_mosi(flash_mosi),
          .sio1_so_miso(flash_miso),
          .sio2        (flash_io2),
          .sio3        (flash_io3),
          .cs          (),

          .clk   (clk),
          .resetn(resetn)
      );
    end else begin

      spi_nor_flash spi_nor_flash_I (
          .clk   (clk),
          .resetn(resetn),

          .addr ({word_aligned_addr[21:0]}),
          .data (spi_nor_mem_data),
          .ready(spi_nor_mem_ready),
          .valid(spi_nor_mem_valid),

          // external
          .spi_cs  (flash_csn),
          .spi_miso(flash_miso),
          .spi_mosi(flash_mosi),
          .spi_sclk(flash_sclk)
      );
    end

  endgenerate
`else
  assign is_flash = 1'b0;
  assign spi_nor_mem_ready = 1'b0;
`endif

  wire gpio_valid;
  wire gpio_ready;
  wire [31:0] gpio_rdata;
`ifdef SOC_HAS_GPIO
  /////////////////////////////////////////////////////////////////////////////
  // gpio
  //wire [7:0] gpio;
  assign gpio_valid = !gpio_ready && cpu_mem_valid &&
           (cpu_mem_addr == `KIANV_GPIO_DIR || cpu_mem_addr == `KIANV_GPIO_OUTPUT || cpu_mem_addr == `KIANV_GPIO_INPUT);

  gpio #(
      .GPIO_NR(10)
  ) gpio_I (
      .clk(clk),
      .resetn(resetn),
      .addr(cpu_mem_addr[3:0]),
      .wrstb(cpu_mem_wstrb),
      .wdata(cpu_mem_wdata),
      .rdata(gpio_rdata),
      .valid(gpio_valid),
      .ready(gpio_ready),
      .gpio(gpio)
  );
`else
  assign gpio_valid = 1'b0;
  assign gpio_ready = 1'b0;
`endif

  wire snd_valid;
  wire pwm_fifo_full;
`ifdef SOC_HAS_AUDIO
  /////////////////////////////////////////////////////////////////////////////
  // audio
  reg snd_ready;
  assign snd_valid = !snd_ready && cpu_mem_valid && (cpu_mem_addr == `KIANV_SND_REG);
  always @(posedge clk) snd_ready <= !resetn ? 0 : snd_valid;
  wire pwm_o;

  pwm #(
      .DEPTH(`KIANV_AUDIO_PWM_BUFFER)
  ) pwm_I (
      .clk  (clk),
      .resetn(resetn),
      .we   (snd_valid && |cpu_mem_wstrb),
      .pcm_i(cpu_mem_wdata[7:0]),
      .pwm_o(pwm_o),
      .fifo_full(pwm_fifo_full)
  );
  assign audio_gain = 1'b1;
  assign audio_shutdown = 1'b1;
  assign audio_r = pwm_o;
  assign audio_l = pwm_o;
`else
  wire snd_ready;
  assign snd_ready = 1'b0;
  assign snd_valid = 1'b0;
  assign pwm_fifo_full = 1'b0;
`endif

  /////////////////////////////////////////////////////////////////////////////
  // SPI

  assign spi_mem_valid0 = !spi_mem_ready0 && cpu_mem_valid &&
           (cpu_mem_addr == `KIANV_SPI_CTRL0 || cpu_mem_addr == `KIANV_SPI_DATA0);
  spi #(
      .QUAD_MODE(1'b0),
      .CPOL(1'b1)
  ) spi0_I (
      .clk   (clk),
      .resetn(resetn),
      .ctrl  (cpu_mem_addr[2]),
      .rdata (spi_mem_data0),
      .wdata (cpu_mem_wdata),
      .wstrb (cpu_mem_wstrb),
      .valid (spi_mem_valid0),
      /* verilator lint_off WIDTHTRUNC */
      .div   (div_reg[31:16]),
      /* verilator lint_on WIDTHTRUNC */
      .ready (spi_mem_ready0),

      .cen         (spi_cen0),
      .sclk        (spi_sclk0),
      .sio1_so_miso(spi_sio1_so_miso0),
      .sio0_si_mosi(spi_sio0_si_mosi0),
      .sio2        (spi_sio2_0),
      .sio3        (spi_sio3_0)
  );

`ifdef SOC_HAS_NETWORK
  assign spi_mem_valid1 = !spi_mem_ready1 && cpu_mem_valid &&
           (cpu_mem_addr == `KIANV_SPI_CTRL1 || cpu_mem_addr == `KIANV_SPI_DATA1);
  spi #(
      .QUAD_MODE(1'b0),
      .CPOL(1'b0)
  ) spi1_I (
      .clk   (clk),
      .resetn(resetn),
      .ctrl  (cpu_mem_addr[2]),
      .rdata (spi_mem_data1),
      .wdata (cpu_mem_wdata),
      .wstrb (cpu_mem_wstrb),
      .valid (spi_mem_valid1),
      /* verilator lint_off WIDTHTRUNC */
      .div   (`SYSTEM_CLK / `KIANV_SPI_CTRL1_FREQ),
      /* verilator lint_on WIDTHTRUNC */
      .ready (spi_mem_ready1),

      .cen         (spi_cen1),
      .sclk        (spi_sclk1),
      .sio1_so_miso(spi_sio1_so_miso1),
      .sio0_si_mosi(spi_sio0_si_mosi1),
      .sio2        (),
      .sio3        ()
  );
`else
  assign spi_mem_valid1 = 1'b0;
  assign spi_mem_ready1 = 1'b0;
`endif

`ifdef SOC_HAS_EXT_OLED
  assign spi_mem_valid2 = !spi_mem_ready2 && cpu_mem_valid &&
           (cpu_mem_addr == `KIANV_SPI_CTRL2 || cpu_mem_addr == `KIANV_SPI_DATA2);
  spi #(
      .QUAD_MODE(1'b0),
      .CPOL(1'b1)
  ) spi2_I (
      .clk   (clk),
      .resetn(resetn),
      .ctrl  (cpu_mem_addr[2]),
      .rdata (),
      .wdata (cpu_mem_wdata),
      .wstrb (cpu_mem_wstrb),
      .valid (spi_mem_valid2),
      /* verilator lint_off WIDTHTRUNC */
      .div   (`SYSTEM_CLK / `KIANV_SPI_CTRL2_FREQ),
      /* verilator lint_on WIDTHTRUNC */
      .ready (spi_mem_ready2),

      .cen         (oled_cs),
      .sclk        (oled_sck),
      .sio1_so_miso(),
      .sio0_si_mosi(oled_mosi),
      .sio2        (),
      .sio3        ()
  );
`else
  assign spi_mem_valid2 = 1'b0;
  assign spi_mem_ready2 = 1'b0;
`endif

  /////////////////////////////////////////////////////////////////////////////
 
  // UART TX/RX

  wire uart_lsr_valid_rd[NUM_UARTS-1:0];
  wire uart_tx_valid_wr [NUM_UARTS-1:0];
  wire uart_tx_rdy      [NUM_UARTS-1:0];    // FIFO not full (can accept byte)
  wire uart_tx_busy     [NUM_UARTS-1:0];    // shifter active OR FIFO non-empty
  reg  uart_lsr_rdy     [NUM_UARTS-1:0];

  // ns16550-like THRE bit per UART
  reg  lsr_thre         [NUM_UARTS-1:0];

  // filter to avoid duplicate accepts
  reg  tx_seen          [NUM_UARTS-1:0];

  genvar i;
  generate
    for (i = 0; i < NUM_UARTS; i = i + 1) begin : UART_GEN
      // TX register address hit
      wire tx_hit = cpu_mem_valid && wr &&
                    (cpu_mem_addr == UART_TX_ADDRS[32*(NUM_UARTS-i) -1 -: 32]);

      // Accept once per transaction, only if FIFO has space
      wire tx_accept = tx_hit && !tx_seen[i] && uart_tx_rdy[i];

      // one-cycle strobe into UART
      assign uart_tx_valid_wr[i] = tx_accept;

      // bus ack pulse only when accepted
      always @(posedge clk) begin
        if (!resetn)
          uart_tx_ready[i] <= 1'b0;
        else
          uart_tx_ready[i] <= tx_accept;
      end

      // remember we’ve seen this bus request until it drops
      always @(posedge clk) begin
        if (!resetn)
          tx_seen[i] <= 1'b0;
        else if (!tx_hit)
          tx_seen[i] <= 1'b0;
        else if (tx_accept)
          tx_seen[i] <= 1'b1;
      end

      // THRE bit (LSR[5]): clear on write, set again when FIFO not full
      always @(posedge clk) begin
        if (!resetn)
          lsr_thre[i] <= 1'b1;
        else if (tx_accept)
          lsr_thre[i] <= 1'b0;
        else if (uart_tx_rdy[i])
          lsr_thre[i] <= 1'b1;
      end

      tx_uart tx_uart_i (
          .clk    (clk),
          .resetn (resetn),
          .valid  (uart_tx_valid_wr[i]),
          .tx_data(cpu_mem_wdata[7:0]),
          .div    (div_reg[15:0]),
          .tx_out (uart_tx[i]),
          .ready  (uart_tx_rdy[i]),
          .busy   (uart_tx_busy[i])
      );

      // LSR read strobe
      assign uart_lsr_valid_rd[i] =
        (~uart_lsr_rdy[i]) && rd && cpu_mem_valid &&
        (cpu_mem_addr == UART_LSR_ADDRS[32*(NUM_UARTS-i) -1 -: 32]);

      always @(posedge clk) begin
        if (!resetn)
          uart_lsr_rdy[i] <= 1'b0;
        else
          uart_lsr_rdy[i] <= uart_lsr_valid_rd[i];
      end
    end
  endgenerate

  // UART RX

  wire uart_rx_valid_rd[NUM_UARTS -1:0];
  wire rx_uart_rdy[NUM_UARTS -1:0];

  generate
    for (i = 0; i < NUM_UARTS; i = i + 1) begin : UART_RX_INSTANCE
      assign uart_rx_valid[i] = ~uart_rx_ready[i] &&
                                cpu_mem_valid &&
                                cpu_mem_addr == UART_RX_ADDRS[32*(NUM_UARTS-i) -1 -: 32];
      assign uart_rx_valid_rd[i] = rd && uart_rx_valid[i];

      always @(posedge clk) begin
        if (!resetn)
          uart_rx_ready[i] <= 1'b0;
        else
          uart_rx_ready[i] <= uart_rx_valid_rd[i];
      end

      assign rx_uart_rdy[i] = uart_rx_ready[i];

      rx_uart rx_uart_i (
          .clk    (clk),
          .resetn (resetn),
          .rx_in  (uart_rx[i]),
          .div    (div_reg[15:0]),
          .error  (),
          .data_rd(rx_uart_rdy[i]),
          .data   (rx_uart_data[i])
      );
    end
  endgenerate


  /////////////////////////////////////////////////////////////////////////////

  wire [31:0] mem_sdram_rdata;

  wire mem_sdram_valid;
  wire cache_ready_i;
  wire mem_sdram_ready;

  wire is_sdram = (cache_addr_o >= `SDRAM_MEM_ADDR_START && cache_addr_o < `SDRAM_MEM_ADDR_END);
  assign mem_sdram_valid = !mem_sdram_ready && cpu_mem_valid && is_sdram;
  wire [29:0] cache_word_aligned_addr;
  assign cache_word_aligned_addr = {cache_addr_o[31:2]};

`ifdef SOC_HAS_SDRAM_MT48LC16M16A2
  mt48lc16m16a2_ctrl #(
    .SDRAM_CLK_FREQ(`SYSTEM_CLK / 1_000_000),
    .TREFI_NS       (`TREFI_NS      ),
    .TRP_NS         (`TRP_NS        ),
    .TRCD_NS        (`TRCD_NS       ),
    .TWR_NS         (`TWR_NS        ),
    .CAS            (`CAS           )
  ) sdram_i (
      .clk   (clk),
      .resetn(resetn),
      .addr  (cache_addr_o),
      .din   (cache_din_o),
      .dout  (cache_dout_i),
      .wmask (cache_wmask_o),
      .valid (cache_valid_o),
      .ready (cache_ready_i),

      .sdram_clk (sdram_clk),
      .sdram_cke (sdram_cke),
      .sdram_dqm (sdram_dqm),
      .sdram_addr(sdram_addr),
      .sdram_ba  (sdram_ba),
      .sdram_csn (sdram_csn),
      .sdram_wen (sdram_wen),
      .sdram_rasn(sdram_rasn),
      .sdram_casn(sdram_casn),
      .sdram_dq  (sdram_dq)
  );
`elsif SOC_HAS_SDRAM_M12L64322A
  m12l64322a_ctrl #(
    .SDRAM_CLK_FREQ(`SYSTEM_CLK / 1_000_000),
    .TRP_NS         (`TRP_NS        ),
    .TRC_NS         (`TRC_NS        ),
    .TRCD_NS        (`TRCD_NS       ),
    .TCH_NS         (`TCH_NS        ),
    .CAS            (`CAS           )
  ) sdram_i (
      .clk   (clk),
      .resetn(resetn),
      .addr  (cache_addr_o >> 2),
      .din   (cache_din_o),
      .dout  (cache_dout_i),
      .wmask (cache_wmask_o),
      .valid (cache_valid_o),
      .ready (cache_ready_i),

      .sdram_clk (sdram_clk),
      .sdram_cke (),
      .sdram_dqm (),
      .sdram_addr(sdram_addr),
      .sdram_ba  (sdram_ba),
      .sdram_csn (),
      .sdram_wen (sdram_wen),
      .sdram_rasn(sdram_rasn),
      .sdram_casn(sdram_casn),
      .sdram_dq  (sdram_dq)
  );
`elsif SOC_HAS_SDRAM_W9864G6JT
  w9864g6jt_ctrl #(
    .SDRAM_CLK_FREQ(`SYSTEM_CLK / 1_000_000),
    .TRP_NS         (`TRP_NS        ),
    .TRC_NS         (`TRC_NS        ),
    .TRCD_NS        (`TRCD_NS       ),
    .TCH_NS         (`TCH_NS        ),
    .CAS            (`CAS           )
  ) sdram_i (
      .clk   (clk),
      .resetn(resetn),
      .addr  (cache_addr_o),
      .din   (cache_din_o),
      .dout  (cache_dout_i),
      .wmask (cache_wmask_o),
      .valid (cache_valid_o),
      .ready (cache_ready_i),

      .sdram_clk (sdram_clk),
      .sdram_cke (sdram_cke),
      .sdram_dqm (sdram_dqm),
      .sdram_addr(sdram_addr),
      .sdram_ba  (sdram_ba),
      .sdram_csn (sdram_csn),
      .sdram_wen (sdram_wen),
      .sdram_rasn(sdram_rasn),
      .sdram_casn(sdram_casn),
      .sdram_dq  (sdram_dq)
  );
`endif

  cache #(
      .ICACHE_ENTRIES_PER_WAY(`ICACHE_ENTRIES_PER_WAY),
      .DCACHE_ENTRIES_PER_WAY(`DCACHE_ENTRIES_PER_WAY)
  ) cache_I (
      .clk   (clk),
      .resetn(resetn && ~icache_flush),
      .is_instruction (is_instruction),

      .cpu_addr_i (cpu_mem_addr),
      .cpu_din_i  (cpu_mem_wdata),
      .cpu_wmask_i(cpu_mem_wstrb),
      .cpu_valid_i(mem_sdram_valid),
      .cpu_dout_o (mem_sdram_rdata),
      .cpu_ready_o(mem_sdram_ready),

      .cache_addr_o (cache_addr_o),
      .cache_din_o  (cache_din_o),
      .cache_wmask_o(cache_wmask_o),
      .cache_valid_o(cache_valid_o),
      .cache_dout_i (cache_dout_i),
      .cache_ready_i(cache_ready_i)
  );


  /////////////////////////////////////////////////////////////////////////////

  // BRAM
`ifdef HAS_BRAM
  wire is_bram = (cpu_mem_addr < (`BRAM_WORDS << 2));
  assign bram_valid = !bram_ready && cpu_mem_valid && is_bram;
  bram #(
      .WIDTH        (BRAM_ADDR_WIDTH),
      .INIT_FILE0    (`BOOTLOADER_BRAM0),
      .INIT_FILE1    (`BOOTLOADER_BRAM1),
      .INIT_FILE2    (`BOOTLOADER_BRAM2),
      .INIT_FILE3    (`BOOTLOADER_BRAM3)
  ) bram_I (
      .clk  (clk),
      .addr (word_aligned_addr[BRAM_ADDR_WIDTH-1:0]),
      .wdata(cpu_mem_wdata),
      .rdata(bram_rdata),
      .wmask(cpu_mem_wstrb & {4{bram_valid}})
  );
`else
  wire is_bram = 1'b0;
  assign bram_valid = 1'b0;
`endif
  always @(posedge clk) bram_ready <= !resetn ? 1'b0 : bram_valid;


  /////////////////////////////////////////////////////////////////////////////
  wire IRQ3;
  wire IRQ7;
  wire clint_valid;
  wire clint_ready;
  wire [31:0] clint_rdata;
  wire [63:0] timer_counter;
  wire is_clint = cpu_mem_addr[31:24] == 8'h02;

  clint clint_I (
      .clk          (clk),
      .resetn       (resetn),
      .valid        (is_clint && cpu_mem_valid),
      .addr         (cpu_mem_addr[23:0]),
      .wmask        (cpu_mem_wstrb),
      .wdata        (cpu_mem_wdata),
      .rdata        (clint_rdata),
      .div          (div_reg[31:16]),
      .IRQ3         (IRQ3),
      .IRQ7         (IRQ7),
      .timer_counter(timer_counter),
      .is_valid     (clint_valid),
      .ready        (clint_ready)
  );
  /////////////////////////////////////////////////////////////////////////////
  wire plic_valid;
  wire plic_ready;
  wire [31:0] plic_rdata;
  wire interrupt_request_ctx0;
  wire interrupt_request_ctx1;
  //wire uart_irq = (~(&rx_uart_data[0]) || (~uart_tx_busy[0]));
  wire uart_irq = ~(&rx_uart_data[0]) || uart_tx_busy[0];
  wire [30:0] interrupt_request = {21'b0, uart_irq, 9'b0};

  wire is_plic = (cpu_mem_addr[31:24] == 8'h0C);

  plic plic_I (
      .clk                   (clk),
      .resetn                (resetn),
      .valid                 (is_plic && cpu_mem_valid),
      .addr                  (cpu_mem_addr[23:0]),
      .wmask                 (cpu_mem_wstrb),
      .wdata                 (cpu_mem_wdata),
      .rdata                 (plic_rdata),
      .interrupt_request     ({21'd0, uart_irq, 9'd0}),
      .is_valid              (plic_valid),
      .ready                 (plic_ready),
      .interrupt_request_ctx0(interrupt_request_ctx0),
      .interrupt_request_ctx1(interrupt_request_ctx1)
  );

  /////////////////////////////////////////////////////////////////////////////
  reg access_fault_ready;
  wire is_io = (cpu_mem_addr >= 32'h10_000_000 && cpu_mem_addr <= 32'h12_000_000) || (is_plic || is_clint);
  wire non_instruction_invalid_access = !is_instruction && !(is_io || is_bram || is_sdram || is_flash || is_reboot);
  wire instruction_invalid_access = is_instruction && !(is_sdram || is_bram || is_flash);
  wire access_fault_valid = `ENABLE_ACCESS_FAULT && (!access_fault_ready && cpu_mem_valid && (non_instruction_invalid_access || instruction_invalid_access));

  always @(posedge clk) access_fault_ready <= !resetn ? 1'b0 : access_fault_valid;

  kianv_harris_mc_edition #(
      .RESET_ADDR(`RESET_ADDR),
      .SYSTEM_CLK(`SYSTEM_CLK),
      .NUM_ENTRIES_ITLB(`NUM_ENTRIES_ITLB),
      .NUM_ENTRIES_DTLB(`NUM_ENTRIES_DTLB)
  ) kianv_I (
      .clk           (clk),
      .resetn        (resetn),
      .mem_ready     (cpu_mem_ready),
      .mem_valid     (cpu_mem_valid),
      .mem_wstrb     (cpu_mem_wstrb),
      /* verilator lint_off WIDTHEXPAND */
      // 34 to 32 bits
      .mem_addr      (cpu_mem_addr),
      /* verilator lint_on WIDTHEXPAND */
      .mem_wdata     (cpu_mem_wdata),
      .mem_rdata     (cpu_mem_rdata),
      .access_fault  (access_fault_ready),
      .timer_counter (timer_counter),
      .is_instruction(is_instruction),
      .icache_flush  (icache_flush),
      .IRQ3          (IRQ3),
      .IRQ7          (IRQ7),
      .IRQ9          (interrupt_request_ctx1),
      .IRQ11         (interrupt_request_ctx0),
      .PC            (PC)
  );

  /////////////////////////////////////////////////////////////////////////////
  //wire is_io = (cpu_mem_addr >= 32'h10_000_000 && cpu_mem_addr <= 32'h12_000_000);
  wire [NUM_UARTS-1:0] match_lsr, match_tx, match_rx;

  generate
    for (i = 0; i < NUM_UARTS; i = i + 1) begin : ADDR_MATCH_GEN
      assign match_lsr[i] = (cpu_mem_addr == UART_LSR_ADDRS[32*(NUM_UARTS-i)-1-:32]);
      assign match_tx[i]  = (cpu_mem_addr == UART_TX_ADDRS[32*(NUM_UARTS-i)-1-:32]);
      assign match_rx[i]  = (cpu_mem_addr == UART_RX_ADDRS[32*(NUM_UARTS-i)-1-:32]);
    end
  endgenerate

  // Aggregate the match results and include the `clint_valid` comparison
  wire unmatched_io = !(|match_lsr || |match_tx || |match_rx || clint_valid || plic_valid || spi_mem_valid0
                      || spi_mem_valid1 || spi_mem_valid2 || div_valid || gpio_valid || system_cpu_freq_valid || system_mem_size_access_valid || snd_valid);

  reg [7:0] byteswaiting[NUM_UARTS -1:0];
  reg [32*NUM_UARTS -1:0] io_rdata_uart;
  reg [NUM_UARTS -1:0] io_ready_uart;

  generate
    for (i = 0; i < NUM_UARTS; i = i + 1) begin : GENERIC_UART_CTRL
      always @(*) begin
        byteswaiting[i]         = 8'h00;
        io_rdata_uart[32*i+:32] = 32'h0000_0000;
        io_ready_uart[i]        = 1'b0;

        if (uart_lsr_rdy[i]) begin
          byteswaiting[i] = {
            1'b0,
            (~uart_tx_busy[i]),
            lsr_thre[i],
            1'b0, 3'b000,
            ~(&rx_uart_data[i])
          };
          io_rdata_uart[32*i+:32] = {16'h0000, byteswaiting[i], 8'h00};
          io_ready_uart[i] = 1'b1;
        end else if (uart_rx_ready[i]) begin
          io_rdata_uart[32*i+:32] = rx_uart_data[i];
          io_ready_uart[i] = 1'b1;
        end else if (uart_tx_ready[i]) begin
          io_rdata_uart[32*i+:32] = 32'h0000_0000;
          io_ready_uart[i] = 1'b1;
        end
      end
    end
  endgenerate

  wire [INDEX_UART_NUM_WIDTH:0] rmb_index;
  Priority_Encoder #(
      .WORD_WIDTH(NUM_UARTS)
  ) priority_encoder_i (
      .word_in(io_ready_uart),
      .word_out(rmb_index),
      .word_out_valid()
  );

  reg io_ready;
  reg [31:0] io_rdata;
  always @(*) begin
    io_rdata = 0;
    io_ready = 1'b0;

    if (is_io) begin
      if (|io_ready_uart) begin
        io_rdata = io_rdata_uart[32*(rmb_index)+:32];
        io_ready = 1'b1;
      end else if (system_cpu_freq_ready) begin
        io_rdata = `SYSTEM_CLK;
        io_ready = 1'b1;
      end else if (system_mem_size_access_ready) begin
        io_rdata = `SDRAM_SIZE;
        io_ready = 1'b1;
      end else if (clint_ready) begin
        io_rdata = clint_rdata;
        io_ready = 1'b1;
      end else if (plic_ready) begin
        io_rdata = plic_rdata;
        io_ready = 1'b1;
      end else if (div_ready) begin
        io_rdata = div_reg;
        io_ready = 1'b1;
      end else if (spi_mem_ready0) begin
        io_rdata = spi_mem_data0;
        io_ready = 1'b1;
      end else if (spi_mem_ready1) begin
        io_rdata = spi_mem_data1;
        io_ready = 1'b1;
      end else if (spi_mem_ready2) begin
        io_rdata = 0;
        io_ready = 1'b1;
      end else if (gpio_ready) begin
        io_rdata = gpio_rdata;
        io_ready = 1'b1;
      end else if (snd_ready) begin
        io_rdata = {31'b0, pwm_fifo_full};
        io_ready = 1'b1;
      end else if (unmatched_io) begin
        io_rdata = 0;
        io_ready = 1'b1;
      end
    end
  end

  /////////////////////////////////////////////////////////////////////////////
  assign cpu_mem_ready = bram_ready || spi_nor_mem_ready || mem_sdram_ready || io_ready || access_fault_ready;

  assign cpu_mem_rdata   =
           bram_ready               ? bram_rdata                   :
           spi_nor_mem_ready        ? spi_nor_mem_data             :
           mem_sdram_ready          ? mem_sdram_rdata              :
           io_ready                 ? io_rdata                     :
           32'h 0000_0000;

endmodule
