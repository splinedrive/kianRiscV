/*
 *  kianv.v - RISC-V rv32ima
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
`default_nettype none `timescale 1 ns / 100 ps
`include "defines_soc.vh"
module soc (
        input  wire        clk_osc,
        output wire        uart_tx,
        input  wire        uart_rx,
        output wire [ 7:0] led,
        output wire        flash_csn,
        inout  wire        flash_miso,
        inout  wire        flash_mosi,
        inout  wire        flash_io2,
        inout  wire        flash_io3,
        output wire        sdram_clk,
        output wire        sdram_cke,
        output wire [ 1:0] sdram_dqm,
        output wire [12:0] sdram_addr,  //  A0-A10 row address, A0-A7 column address
        output wire [ 1:0] sdram_ba,    // bank select A11,A12
        output wire        sdram_csn,
        output wire        sdram_wen,
        output wire        sdram_rasn,
        output wire        sdram_casn,
        inout  wire [15:0] sdram_dq
    );

    wire clk;

    wire [31:0] PC;

    wire flash_sclk;
    wire flash_clk;
    USRMCLK u1 (
                .USRMCLKI (flash_clk),
                .USRMCLKTS(1'b0)
            );
    assign flash_clk = flash_sclk;

    assign led       = PC[0+:8];

    wire locked;
    pll #(
            .freq(`SYSTEM_CLK_MHZ)
        ) pll_I0 (
            clk_osc,
            clk,
            locked
        );

    localparam BYTE_ADDRESS_LEN = 32;
    localparam BYTES_PER_BLOCK = 4;
    localparam DATA_LEN = 32;
    localparam BLOCK_ADDRESS_LEN = BYTE_ADDRESS_LEN - $clog2(BYTES_PER_BLOCK);

    localparam BRAM_ADDR_WIDTH = $clog2(`BRAM_WORDS);

    // reset
    reg [11:0] rst_cnt = 0;
    wire resetn = &rst_cnt;

    always @(posedge clk) begin
        if (!locked) rst_cnt <= 0;
        else if (!resetn) rst_cnt <= rst_cnt + 1;
    end


    // cpu
    wire                      [31:0]                                           pc;
    wire                      [ 5:0]                                           ctrl_state;

    wire                                                                       cpu_mem_ready;
    wire                                                                       cpu_mem_valid;

    wire                      [ 3:0]                                           cpu_mem_wstrb;
    wire                      [31:0]                                           cpu_mem_addr;
    wire                      [31:0]                                           cpu_mem_wdata;
    wire                      [31:0]                                           cpu_mem_rdata;

    wire                      [31:0]                                           bram_rdata;
    reg                                                                        bram_ready;
    wire                                                                       bram_valid;

    // uart
    wire                                                                       uart_tx_valid;
    reg                                                                        uart_tx_ready;
    // uart
    wire                                                                       uart_rx_valid;
    reg                                                                        uart_rx_ready;

    // spi flash memory
    wire                      [31:0]                                           spi_nor_mem_data;
    wire                                                                       spi_nor_mem_ready;
    wire                                                                       spi_nor_mem_valid;


    // cpu_freq
    wire                                                                       system_cpu_freq_valid;
    reg                                                                        system_cpu_freq_ready;

    // RISC-V is byte-addressable, alignment memory devices word organized
    // memory interface
    wire wr = |cpu_mem_wstrb;
    wire rd = ~wr;

    wire                      [29:0] word_aligned_addr = {cpu_mem_addr[31:2]};

    // cpu_freq
    assign system_cpu_freq_valid   = !system_cpu_freq_ready && cpu_mem_valid && (cpu_mem_addr == `CPU_FREQ_REG_ADDR) && !wr;
    always @(posedge clk) system_cpu_freq_ready <= !resetn ? 1'b0 : system_cpu_freq_valid;

    // SPI nor flash
    assign spi_nor_mem_valid = !spi_nor_mem_ready && cpu_mem_valid &&
           (cpu_mem_addr >= `SPI_NOR_MEM_ADDR_START && cpu_mem_addr < `SPI_NOR_MEM_ADDR_END) && !wr;

    wire spi_state;

    qqspi #(
              .QUAD_MODE(`QUAD_SPI_FLASH_MODE),
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

    /////////////////////////////////////////////////////////////////////////////

    wire uart_tx_valid_wr;

    // I have changed to blocked tx
    assign uart_tx_valid = ~uart_tx_ready && cpu_mem_valid && cpu_mem_addr == `UART_TX_ADDR;
    //assign uart_tx_valid = ~uart_tx_rdy && cpu_mem_valid && cpu_mem_addr == `UART_TX_ADDR; // blocking
    assign uart_tx_valid_wr = wr && uart_tx_valid;
    always @(posedge clk) uart_tx_ready <= !resetn ? 1'b0 : uart_tx_valid_wr;

    reg  uart_tx_busy;
    wire uart_tx_rdy;

    tx_uart #(
                .SYSTEM_CLK(`SYSTEM_CLK),
                .BAUDRATE  (`BAUDRATE)
            ) tx_uart_i (
                .clk    (clk),
                .resetn (resetn),
                .valid  (uart_tx_valid_wr),
                .tx_data(cpu_mem_wdata[7:0]),
                .div    (`SYSTEM_CLK / `BAUDRATE),
                .tx_out (uart_tx),
                .ready  (uart_tx_rdy)
            );

    always @(posedge clk) begin
        if (!resetn) begin
            uart_tx_busy <= 0;
        end else begin
            case (1'b1)
                (!uart_tx_busy && uart_tx_valid_wr): uart_tx_busy <= 1'b1;
                (uart_tx_busy && uart_tx_rdy): uart_tx_busy <= 1'b0;
            endcase
        end
    end

    /////////////////////////////////////////////////////////////////////////////
    wire uart_lsr_valid_rd = ~uart_lsr_rdy && rd && cpu_mem_valid && cpu_mem_addr == `UART_LSR_ADDR;
    reg uart_lsr_rdy;
    always @(posedge clk) uart_lsr_rdy <= !resetn ? 1'b0 : uart_lsr_valid_rd;

    /////////////////////////////////////////////////////////////////////////////

    wire uart_rx_valid_rd;
    wire [31:0] rx_uart_data;

    assign uart_rx_valid = ~uart_rx_ready && cpu_mem_valid && cpu_mem_addr == `UART_RX_ADDR;
    assign uart_rx_valid_rd = rd && uart_rx_valid;

    always @(posedge clk) begin
        uart_rx_ready <= !resetn ? 1'b0 : uart_rx_valid_rd;
    end

    wire rx_uart_rdy = uart_rx_ready;
    rx_uart #(
                .SYSTEM_CLK(`SYSTEM_CLK),
                .BAUDRATE  (`BAUDRATE)
            ) rx_uart_i (
                .clk    (clk),
                .resetn (resetn),
                .rx_in  (uart_rx),
                .error  (),
                .data_rd(rx_uart_rdy), // pop
                .data   (rx_uart_data)
            );

    /////////////////////////////////////////////////////////////////////////////

    wire [31:0] mem_sdram_rdata;

    wire mem_sdram_valid;
    wire mem_sdram_ready;

    assign mem_sdram_valid = !mem_sdram_ready && cpu_mem_valid &&
           (cpu_mem_addr >= `SDRAM_MEM_ADDR_START && cpu_mem_addr < `SDRAM_MEM_ADDR_END);

    mt48lc16m16a2_ctrl #(
                           .SDRAM_CLK_FREQ(`SYSTEM_CLK_MHZ / 1_000_000)
                       ) sdram_i (
                           .clk   (clk),
                           .resetn(resetn),
                           .addr  (cpu_mem_addr),
                           .din   (cpu_mem_wdata),
                           .dout  (mem_sdram_rdata),
                           .wmask (cpu_mem_wstrb),
                           .valid (mem_sdram_valid),
                           .ready (mem_sdram_ready),

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

    /////////////////////////////////////////////////////////////////////////////

    // BRAM
    assign bram_valid = !bram_ready && cpu_mem_valid && (cpu_mem_addr < (`BRAM_WORDS << 2));
    always @(posedge clk) bram_ready <= !resetn ? 0 : bram_valid;

    bram #(
             .WIDTH        (BRAM_ADDR_WIDTH),
             .SHOW_FIRMWARE(0),
             .INIT_FILE    (`FIRMWARE_BRAM)
         ) bram_I (
             .clk  (clk),
             .addr (word_aligned_addr[BRAM_ADDR_WIDTH-1:0]),
             .wdata(cpu_mem_wdata),
             .rdata(bram_rdata),
             .wmask(cpu_mem_wstrb & {4{bram_valid}})
         );

    /////////////////////////////////////////////////////////////////////////////
    wire IRQ3;
    wire IRQ7;
    wire clint_valid;
    wire clint_ready;
    wire [31:0] clint_rdata;

    clint #(
              .SYSTEM_CLK(`SYSTEM_CLK),
              .CLOCK_TICK(1000000)
          ) clint_I (
              .clk     (clk),
              .resetn  (resetn),
              .valid   (cpu_mem_valid),
              .addr    (cpu_mem_addr),
              .wmask   (cpu_mem_wstrb),
              .wdata   (cpu_mem_wdata),
              .rdata   (clint_rdata),
              .IRQ3    (IRQ3),
              .IRQ7    (IRQ7),
              .is_valid(clint_valid),
              .ready   (clint_ready)
          );

    /////////////////////////////////////////////////////////////////////////////
    kianv_harris_mc_edition #(
                                .RESET_ADDR(`RESET_ADDR)
                            ) kianv_I (
                                .clk      (clk),
                                .resetn   (resetn),
                                .mem_ready(cpu_mem_ready),
                                .mem_valid(cpu_mem_valid),
                                .mem_wstrb(cpu_mem_wstrb),
                                .mem_addr (cpu_mem_addr),
                                .mem_wdata(cpu_mem_wdata),
                                .mem_rdata(cpu_mem_rdata),
                                .access_fault(access_fault),
                                .IRQ3     (IRQ3),
                                .IRQ7     (IRQ7),
                                .PC       (PC)
                            );

    /////////////////////////////////////////////////////////////////////////////
    wire is_io = (cpu_mem_addr >= 32'h10_000_000 && cpu_mem_addr <= 32'h12_000_000);
    wire unmatched_io = !(cpu_mem_addr == `UART_LSR_ADDR || cpu_mem_addr == `UART_TX_ADDR || cpu_mem_addr == `UART_RX_ADDR || clint_valid);
    wire is_bram = (cpu_mem_addr[31]);

    wire access_fault = cpu_mem_valid & (unmatched_io || !is_bram);

    reg io_ready;
    reg [31:0] io_rdata;
    reg [7:0] byteswaiting;

    always @(*) begin
        io_rdata = 0;
        io_ready = 1'b0;
        if (is_io) begin
            if (uart_lsr_rdy) begin
                byteswaiting = {1'b0, !uart_tx_busy, !uart_tx_busy, 1'b0, 3'b0, !(&rx_uart_data)};
                io_rdata = {16'b0, byteswaiting, 8'b0};
                io_ready = 1'b1;
            end else if (uart_rx_ready) begin
                io_rdata = rx_uart_data;
                io_ready = 1'b1;
            end else if (uart_tx_ready) begin
                io_rdata = 0;
                io_ready = 1'b1;
                //io_ready = uart_tx_rdy; // blocking
            end else if (clint_ready) begin
                io_rdata = clint_rdata;
                io_ready = 1'b1;
            end else if (unmatched_io) begin
                io_rdata = 0;
                io_ready = 1'b1;
            end
        end
    end

    /////////////////////////////////////////////////////////////////////////////
    assign cpu_mem_ready = bram_ready
           || spi_nor_mem_ready
           || system_cpu_freq_ready
           || mem_sdram_ready
           || io_ready
           ;

    assign cpu_mem_rdata   =
           bram_ready               ? bram_rdata                   :
           spi_nor_mem_ready        ? spi_nor_mem_data             :
           system_cpu_freq_ready    ? `SYSTEM_CLK                  :
           mem_sdram_ready          ? mem_sdram_rdata              :
           io_ready                 ? io_rdata                     :
           32'h 0000_0000;

endmodule
