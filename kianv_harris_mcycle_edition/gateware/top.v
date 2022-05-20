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
        output wire        uart_tx,

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

    reg [7:0] rst_cnt = 0;
    always @(posedge clk) begin
        if (!rst_cnt[7])
            rst_cnt <= rst_cnt + 1;
    end

    assign resetn = rst_cnt[7];

    // cpu
    wire [31: 0] pc;
    wire [ 5: 0] ctrl_state;

    wire mem_ready;
    wire mem_valid;

    wire [ 3: 0] mem_wstrb;
    wire [31: 0] mem_addr;
    wire [31: 0] mem_wdata;
    wire [31: 0] mem_rdata;

    // bram wiring
    wire [31:0] bram_rdata;
    reg         bram_ready;
    wire        bram_valid;

    // uart
    wire  uart_tx_valid;
    wire  uart_tx_ready;
    wire  uart_ctrl_ready;
    reg   uart_rdy_ready;

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
    assign iomem_valid = mem_valid;// && (mem_addr[31:24] > 8'h 01);
    assign iomem_wstrb = mem_wstrb;
    assign iomem_addr  = mem_addr;
    assign iomem_wdata = mem_wdata;
`endif

    // cpu_freq
    wire system_cpu_freq_valid;
    reg  system_cpu_freq_ready;

    // RISC-V is byte-addressable, alignment memory devices word organized
    // memory interface
    wire wr                       = |mem_wstrb;
    wire [29:0] word_aligned_addr = {mem_addr[31:2]};

    assign mem_ready   = uart_tx_ready || uart_rdy_ready || spi_nor_mem_ready    ||
           bram_ready
`ifdef PSRAM_MEMORY_32MB
           || mem_psram_pmod_ready
`endif
           || system_cpu_freq_ready
`ifdef IOMEM_INTERFACING
           || iomem_ready;
`else
           ;
`endif

    assign mem_rdata   =
           bram_ready            ? bram_rdata           :
           spi_nor_mem_ready     ? spi_nor_mem_data     :
`ifdef PSRAM_MEMORY_32MB
           mem_psram_pmod_ready  ? mem_psram_pmod_rdata :
`endif
           system_cpu_freq_ready ? `SYSTEM_CLK          :
`ifdef IOMEM_INTERFACING
           iomem_ready           ? iomem_rdata          :
`endif
           uart_rdy_ready        ? ~0                   :
           32'h 0000_0000;

    // cpu_freq
    assign system_cpu_freq_valid   = !system_cpu_freq_ready && mem_valid && (mem_addr == `CPU_FREQ_REG_ADDR) && !wr;
    always @(posedge clk) system_cpu_freq_ready <= !resetn ? 1'b 0 : system_cpu_freq_valid;

`ifdef PSRAM_MEMORY_32MB
    // SPI nor flash
    wire mem_psram_pmod_valid = !mem_psram_pmod_ready && mem_valid &&
         (mem_addr >= `PSRAM_MEM_ADDR_START && mem_addr < `PSRAM_MEM_ADDR_END);
`ifdef PSRAM_CACHE
    // cache interface
    wire   [BLOCK_ADDRESS_LEN -1: 0] cblock_addr = word_aligned_addr;
    wire   [DATA_LEN          -1: 0] cwdata      = mem_wdata;
    wire   [DATA_LEN          -1: 0] crdata;
    wire   [BYTES_PER_BLOCK   -1: 0] cwstrb      = mem_wstrb;
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
    wire   [BYTES_PER_BLOCK   -1: 0] mwstrb  = mem_wstrb;
    wire   [DATA_LEN          -1: 0] mrdata;
    wire   [DATA_LEN          -1: 0] mwdata  = mem_wdata;
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
            .addr        ( {2'b 00, maddr[22:0]}                               ),
            .wdata       ( mwdata                                              ),
            .rdata       ( mrdata                                              ),
            .wstrb       ( mwstrb                                              ),
            .ready       ( mready                                              ),
            .valid       ( mvalid                                              ),

            .ss          ( psram_ss                                            ),
            .sclk        ( psram_sclk                                          ),
            .mosi        ( psram_mosi                                          ),
            .miso        ( psram_miso                                          ),
            .sio2        ( psram_sio2                                          ),
            .sio3        ( psram_sio3                                          ),
            .cs          ( psram_cs                                            ),

            .state       (                                                     ),
            .clk         ( clk                                                 ),
            .resetn      ( resetn                                              )

        );
`endif
`endif

    // SPI nor flash
    assign spi_nor_mem_valid = !spi_nor_mem_ready && mem_valid &&
           (mem_addr >= `SPI_NOR_MEM_ADDR_START && mem_addr < `SPI_NOR_MEM_ADDR_END) && !wr;

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

    // UART
    assign uart_tx_valid     = !uart_rdy_ready && mem_valid && (mem_addr == `UART_TX_ADDR) && wr;

    /* uart ready dummy */
    always @(posedge clk) uart_rdy_ready <= !resetn ? 1'b 0 : (mem_valid && (mem_addr == `UART_TX_ADDR) && !wr);

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
            .tx_data ( mem_wdata[7:0]                        ),
            .tx_out  ( uart_tx                               ),
            .ready   ( uart_tx_ready                         )
        );

    // BRAM
    assign bram_valid      = !bram_ready && mem_valid && (mem_addr < (`BRAM_WORDS << 2));
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
            .wdata ( mem_wdata                               ),
            .rdata ( bram_rdata                              ),
            .wmask ( mem_wstrb                               )
        );

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
            .mem_ready ( mem_ready                           ),
            .mem_valid ( mem_valid                           ),
            .mem_wstrb ( mem_wstrb                           ),
            .mem_addr  ( mem_addr                            ),
            .mem_wdata ( mem_wdata                           ),
            .mem_rdata ( mem_rdata                           ),

            .PC        ( PC                                  )
        );
endmodule
