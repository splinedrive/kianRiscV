/*
 *  kianv.v - a simple RISC-V rv32im
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
`timescale 1 ns/100 ps
`default_nettype none
`include "defines.vh"
module top
    (
        input  wire        clk_in,
`ifdef UART_TX
        output wire        uart_tx,
`endif
`ifdef IOMEM_INTERFACING
        output wire        iomem_valid,
        input  wire        iomem_ready,
        output wire [ 3:0] iomem_wstrb,
        output wire [31:0] iomem_addr,
        output wire [31:0] iomem_wdata,
        input  wire [31:0] iomem_rdata,
`endif

`ifdef PSRAM_MEMORY_32MB
        output   wire       psram_ss,
        output   wire       psram_sclk,
        inout    wire       psram_mosi,
        inout    wire       psram_miso,
        inout    wire       psram_sio2,
        inout    wire       psram_sio3,
        output   wire [1:0] psram_cs,
`endif
        output wire         flash_csn,
        input  wire         flash_miso,
        output wire         flash_mosi,
        output wire         flash_sclk,
        output wire         resetn,
        output wire [31:0]  PC,
        input  wire         halt
    );

    localparam BYTE_ADDRESS_LEN  = 32;
    localparam BYTES_PER_BLOCK   =  4;
    localparam DATA_LEN          = 32;
    localparam BLOCK_ADDRESS_LEN = BYTE_ADDRESS_LEN - $clog2(BYTES_PER_BLOCK);
`ifdef PSRAM_CACHE
    localparam CACHE_BLOCK_LEN   = `CACHE_LINES;
`endif

    localparam BRAM_ADDR_WIDTH  = $clog2(`BRAM_WORDS);

    // signals

    // system
    wire clk = clk_in;

    reg [8:0] rst_cnt = 0;
    always @(posedge clk) begin
        if (!rst_cnt[8])
            rst_cnt <= rst_cnt + 1;
    end

    assign resetn = rst_cnt[8];

    // cpu
    wire [31: 0] pc;
    wire [ 5: 0] ctrl_state;

    wire cpu_mem_ready;
    wire cpu_mem_valid;

    wire [ 3: 0] cpu_mem_wstrb;
    wire [31: 0] cpu_mem_addr;
    wire [31: 0] cpu_mem_wdata;
    wire [31: 0] cpu_mem_rdata;

`ifdef DMA_CONTROLLER
    // dma interface
    wire  [31: 0] dma_addr;
    wire  [ 3: 0] dma_wstrb;
    wire  [31: 0] dma_wdata;
    wire  [31: 0] dma_rdata;
    wire  [31: 0] simple_dma_mem_rdata;
    wire          simple_dma_ready;
    wire          dma_valid;
    wire          dma_ready;
    wire          dma_active;
`endif

    // mux memory bus
    wire mux_mem_ready;
    wire mux_mem_valid;
    wire [ 3: 0] mux_mem_wstrb;
    wire [31: 0] mux_mem_addr;
    wire [31: 0] mux_mem_wdata;

`ifdef DMA_CONTROLLER
    reg dma_active_d;
    always @(posedge clk)  dma_active_d <= !resetn ? 0 : dma_active;

    assign mux_mem_valid = dma_active_d ? dma_valid : cpu_mem_valid;
    assign mux_mem_wstrb = dma_active_d ? dma_wstrb : cpu_mem_wstrb;
    assign mux_mem_addr  = dma_active_d ? dma_addr  : cpu_mem_addr;
    assign mux_mem_wdata = dma_active_d ? dma_wdata : cpu_mem_wdata;
    assign cpu_mem_ready = dma_active_d ? 1'b 0 : (mux_mem_ready || simple_dma_ready);
    assign dma_ready     = dma_active_d ? mux_mem_ready : 1'b 0;
`else
    assign mux_mem_valid =  cpu_mem_valid;
    assign mux_mem_wstrb =  cpu_mem_wstrb;
    assign mux_mem_addr  =  cpu_mem_addr;
    assign mux_mem_wdata =  cpu_mem_wdata;
    assign cpu_mem_ready =  mux_mem_ready;
`endif

    // bram wiring
    wire [31:0] bram_rdata;
    reg         bram_ready;
    wire        bram_valid;

`ifdef UART_TX
    // uart
    wire  uart_tx_valid;
    wire  uart_tx_ready;
    wire  uart_ctrl_ready;
    reg   uart_rdy_ready;
`endif

    // spi flash memory
    wire [31:0] spi_nor_mem_data;
    wire        spi_nor_mem_ready;
    wire        spi_nor_mem_valid;

    // psram

`ifdef PSRAM_MEMORY_32MB
    // psram 256MBit
    wire          mem_psram_pmod_valid;
`ifdef PSRAM_CACHE
    wire [31 :0]  mem_psram_pmod_rdata = crdata;
    wire          mem_psram_pmod_ready = cready;
`else
    wire [31 :0]  mem_psram_pmod_rdata = mrdata;
    wire          mem_psram_pmod_ready = mready;
`endif

`endif

`ifdef IOMEM_INTERFACING
    // iomemory interface
    assign iomem_valid = mux_mem_valid;// && (mem_addr[31:24] > 8'h 01);
    assign iomem_wstrb = mux_mem_wstrb;
    assign iomem_addr  = mux_mem_addr;
    assign iomem_wdata = mux_mem_wdata;
`endif

`ifdef CSR
    // cpu_freq
    wire system_cpu_freq_valid;
    reg  system_cpu_freq_ready;
`endif

    // RISC-V is byte-addressable, alignment memory devices word organized
    // memory interface
    wire wr                       = |mux_mem_wstrb;
    wire [29:0] word_aligned_addr = {mux_mem_addr[31:2]};

    assign mux_mem_ready   = bram_ready
`ifdef UART_TX
           || uart_tx_ready || uart_rdy_ready
`endif
`ifndef BRAM_FIRMWARE
           || spi_nor_mem_ready
`endif
`ifdef PSRAM_MEMORY_32MB
           || mem_psram_pmod_ready
`endif
`ifdef CSR
           || system_cpu_freq_ready
`endif
`ifdef IOMEM_INTERFACING
           || iomem_ready
`endif
           ;

    assign cpu_mem_rdata   =
           bram_ready            ? bram_rdata           :
`ifndef BRAM_FIRMWARE
           spi_nor_mem_ready     ? spi_nor_mem_data     :
`endif
`ifdef PSRAM_MEMORY_32MB
           mem_psram_pmod_ready  ? mem_psram_pmod_rdata :
`endif
`ifdef CSR
           system_cpu_freq_ready ? `SYSTEM_CLK          :
`endif
`ifdef IOMEM_INTERFACING
           iomem_ready           ? iomem_rdata          :
`endif
`ifdef UART_TX
           uart_rdy_ready        ? ~0                   :
`endif
`ifdef DMA_CONTROLLER
           simple_dma_ready      ? simple_dma_mem_rdata :
`endif
           32'h 0000_0000;

`ifdef CSR
    // cpu_freq
    assign system_cpu_freq_valid   = !system_cpu_freq_ready && mux_mem_valid && (mux_mem_addr == `CPU_FREQ_REG_ADDR) && !wr;
    always @(posedge clk) system_cpu_freq_ready <= !resetn ? 1'b 0 : system_cpu_freq_valid;
`endif

`ifdef PSRAM_MEMORY_32MB
    // SPI nor flash
    wire mem_psram_pmod_valid = !mem_psram_pmod_ready && mux_mem_valid &&
         (mux_mem_addr >= `PSRAM_MEM_ADDR_START && mux_mem_addr < `PSRAM_MEM_ADDR_END);
`ifdef PSRAM_CACHE
    // cache interface
    wire   [BLOCK_ADDRESS_LEN -1: 0] cblock_addr = word_aligned_addr;
    wire   [DATA_LEN          -1: 0] cwdata      = mux_mem_wdata;
    wire   [DATA_LEN          -1: 0] crdata;
    wire   [BYTES_PER_BLOCK   -1: 0] cwstrb      = mux_mem_wstrb;
    wire                             cvalid      = mem_psram_pmod_valid;
    wire                             cready;

    // mem interface
    wire   [BLOCK_ADDRESS_LEN -1: 0] maddr;
    wire   [BYTES_PER_BLOCK   -1: 0] mwstrb;
    wire   [DATA_LEN          -1: 0] mrdata;
    wire   [DATA_LEN          -1: 0] mwdata;
    wire                             mvalid;
    wire                             mready;
    cache #(
              .BYTE_ADDRESS_LEN ( BYTE_ADDRESS_LEN ),
              .BYTES_PER_BLOCK  ( BYTES_PER_BLOCK  ),
              .DATA_LEN         ( DATA_LEN         ),
              .CACHE_BLOCK_LEN  ( CACHE_BLOCK_LEN  )
          ) cache_I
          (
              .clk                ( clk          ),
              .resetn             ( resetn       ),

              .cblock_addr        ( cblock_addr  ),
              .cwdata             ( cwdata       ),
              .crdata             ( crdata       ),
              .cwstrb             ( cwstrb       ),
              .cvalid             ( cvalid       ),
              .cready             ( cready       ),

              .maddr              ( maddr        ),
              .mwstrb             ( mwstrb       ),
              .mrdata             ( mrdata       ),
              .mwdata             ( mwdata       ),
              .mvalid             ( mvalid       ),
              .mready             ( mready       )
          );
`else
    // mem interface
    wire   [BLOCK_ADDRESS_LEN -1: 0] maddr   = word_aligned_addr;
    wire   [BYTES_PER_BLOCK   -1: 0] mwstrb  = mux_mem_wstrb;
    wire   [DATA_LEN          -1: 0] mrdata;
    wire   [DATA_LEN          -1: 0] mwdata  = mux_mem_wdata;
    wire                             mvalid  = mem_psram_pmod_valid;
    wire                             mready;
`endif

`ifdef SIM
    reg mready_reg;
    always @(posedge clk) mready_reg <= !resetn ? 0 : mvalid;
    assign mready = mready_reg;

    initial begin
        // $monitorh(mvalid, " ", mem_addr, " ", maddr, " ", mwdata, " ", mrdata, " ", mwstrb, " ", mready);
    end

    bram
        #(
            .WIDTH          ( $clog2(1024*1024*32/4)                           ),
            .SHOW_FIRMWARE  ( 0                                                ),
            .INIT_FILE      ( ""                                               )
        )
        bram_I0
        (
            .clk   ( clk                                                       ),
            .wr    ( mvalid & |mwstrb                                          ),
            .addr  ( {2'b 00, maddr[22:0]}                                     ),
            .wdata ( mwdata                                                    ),
            .rdata ( mrdata                                                    ),
            .wmask ( mwstrb                                                    )
        );
`else
    // psram
    qqspi
        #(
            .QUAD_MODE(`PSRAM_QUAD_MODE)
        )
        qqspi_i
        (
            .addr         ( {2'b 00, maddr[22:0]}                               ),
            .wdata        ( mwdata                                              ),
            .rdata        ( mrdata                                              ),
            .wstrb        ( mwstrb                                              ),
            .ready        ( mready                                              ),
            .valid        ( mvalid                                              ),

            .cen          ( psram_ss                                            ),
            .sclk         ( psram_sclk                                          ),
            .sio0_si_mosi ( psram_mosi                                          ),
            .sio1_so_miso ( psram_miso                                          ),
            .sio2         ( psram_sio2                                          ),
            .sio3         ( psram_sio3                                          ),
            .cs           ( psram_cs                                            ),

            .clk          ( clk                                                 ),
            .resetn       ( resetn                                              )

        );
`endif
`endif

`ifndef BRAM_FIRMWARE
    // SPI nor flash
    assign spi_nor_mem_valid = !spi_nor_mem_ready && mux_mem_valid &&
           (mux_mem_addr >= `SPI_NOR_MEM_ADDR_START && mux_mem_addr < `SPI_NOR_MEM_ADDR_END) && !wr;

`ifdef SIM
    wire [21:0] spi_offset = `SPI_MEMORY_OFFSET>>2;
`else
    wire [21:0] spi_offset = 0;
`endif

    spi_nor_flash
        #(
            .INIT_FILE     ( `FIRMWARE_SPI                     ),
            .SHOW_FIRMWARE ( 1'b0                              )
        )
        spi_nor_flash_I
        (
            .clk      ( clk                                    ),
            .resetn   ( resetn                                 ),
            .addr     ( word_aligned_addr[21:0]  -  spi_offset ),
            .data     ( spi_nor_mem_data                       ),
            .ready    ( spi_nor_mem_ready                      ),
            .valid    ( spi_nor_mem_valid                      ),

            .spi_cs   ( flash_csn                              ),
            .spi_miso ( flash_miso                             ),
            .spi_mosi ( flash_mosi                             ),
            .spi_sclk ( flash_sclk                             )
        );
`endif

`ifdef UART_TX
    // UART
    assign uart_tx_valid     = !uart_rdy_ready && mux_mem_valid && (mux_mem_addr == `UART_TX_ADDR) && wr;

    /* uart ready dummy */
    always @(posedge clk) uart_rdy_ready <= !resetn ? 1'b 0 : (mux_mem_valid && (mux_mem_addr == `UART_TX_ADDR) && !wr);

    tx_uart
        #(
            .SYSTEM_CLK ( `SYSTEM_CLK                        ),
            .BAUDRATE   ( `BAUDRATE                          )
        )
        tx_uart_I
        (
            .clk     ( clk                                   ),
            .resetn  ( resetn                                ),
            .valid   ( uart_tx_valid                         ),
            .tx_data ( mux_mem_wdata[7:0]                    ),
            .tx_out  ( uart_tx                               ),
            .ready   ( uart_tx_ready                         )
        );
`endif

    // BRAM
    assign bram_valid      = !bram_ready && mux_mem_valid && (mux_mem_addr < (`BRAM_WORDS << 2));
    always @(posedge clk) bram_ready <= !resetn ? 0 : bram_valid;

    bram
        #(
            .WIDTH          ( BRAM_ADDR_WIDTH                ),
            .SHOW_FIRMWARE  ( 0                              ),
            .INIT_FILE      ( `FIRMWARE_BRAM                 )
        )
        bram_I
        (
            .clk   ( clk                                     ),
            .wr    ( wr & bram_valid                         ),
            .addr  ( word_aligned_addr[BRAM_ADDR_WIDTH -1:0] ),
            .wdata ( mux_mem_wdata                           ),
            .rdata ( bram_rdata                              ),
            .wmask ( mux_mem_wstrb                           )
        );

`ifdef DMA_CONTROLLER
    simple_dma simple_dma_I
               (
                   .clk          ( clk                  ),
                   .resetn       ( resetn               ),
                   .wstrb        ( cpu_mem_wstrb        ),
                   .addr         ( cpu_mem_addr         ),
                   .wdata        ( cpu_mem_wdata        ),
                   .rdata        ( simple_dma_mem_rdata ),
                   .valid        ( cpu_mem_valid        ),
                   .ready        ( simple_dma_ready     ),

                   .dma_addr     ( dma_addr             ),
                   .dma_wdata    ( dma_wdata            ),
                   .dma_rdata    ( cpu_mem_rdata        ),
                   .dma_wstrb    ( dma_wstrb            ),
                   .dma_valid    ( dma_valid            ),
                   .dma_ready    ( dma_ready            ),
                   .dma_active   ( dma_active           )
               );
`endif

    // kianv riscv rv32im
    kianv_harris_mc_edition
        #(
            .RESET_ADDR        ( `RESET_ADDR                 )
        )
        kianv_I
        (
`ifdef CPU_HALT
            .clk       ( clk & halt                          ),  // hack not for productive use
`else
            .clk       ( clk                                 ),
`endif
            .resetn    ( resetn                              ),
            .mem_ready ( cpu_mem_ready                       ),
            .mem_valid ( cpu_mem_valid                       ),
            .mem_wstrb ( cpu_mem_wstrb                       ),
            .mem_addr  ( cpu_mem_addr                        ),
            .mem_wdata ( cpu_mem_wdata                       ),
            .mem_rdata ( cpu_mem_rdata                       ),

            .PC        ( PC                                  )
        );
endmodule
