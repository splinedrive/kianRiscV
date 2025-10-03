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
        output wire        flash_sclk,
        output wire        flash_csn,
        inout  wire        flash_miso,
        inout  wire        flash_mosi,
        output wire        sdram_clk,
        output wire        sdram_cke,
        output wire [ 1:0] sdram_dqm,
        output wire [12:0] sdram_addr,
        output wire [ 1:0] sdram_ba,
        output wire        sdram_csn,
        output wire        sdram_wen,
        output wire        sdram_rasn,
        output wire        sdram_casn,
        output wire        led_board,
        inout  wire [15:0] sdram_dq
    );

    wire clk;
    wire [31:0] PC;

    assign led_board = uart_rx;   
    assign led       = PC[16+:8];

    wire locked;
    pll pll_I0 (
            clk_osc,
            clk,
            locked
        );

    localparam BYTE_ADDRESS_LEN = 32;
    localparam BYTES_PER_BLOCK = 4;
    localparam DATA_LEN = 32;
    localparam BLOCK_ADDRESS_LEN = BYTE_ADDRESS_LEN - $clog2(BYTES_PER_BLOCK);
    localparam BRAM_ADDR_WIDTH = $clog2(`BRAM_WORDS);

    reg [3:0] rst_cnt = 0;
    wire resetn = rst_cnt[3];

    always @(posedge clk) begin
        if (!locked) rst_cnt <= 0;
        else if (!resetn) rst_cnt <= rst_cnt + !resetn;
    end

    wire [31:0] pc;
    wire [ 5:0] ctrl_state;
    wire        cpu_mem_ready;
    wire        cpu_mem_valid;
    wire [ 3:0] cpu_mem_wstrb;
    wire [31:0] cpu_mem_addr;
    wire [31:0] cpu_mem_wdata;
    wire [31:0] cpu_mem_rdata;
    wire [31:0] bram_rdata;
    reg         bram_ready;
    wire        bram_valid;
    reg         uart_tx_ready;
    reg         uart_rx_ready;
    wire [31:0] spi_nor_mem_data;
    wire        spi_nor_mem_ready;
    wire        spi_nor_mem_valid;
    wire        system_cpu_freq_valid;
    reg         system_cpu_freq_ready;

    wire wr = |cpu_mem_wstrb;
    wire rd = ~wr;
    wire [29:0] word_aligned_addr = {cpu_mem_addr[31:2]};

    assign system_cpu_freq_valid   = !system_cpu_freq_ready && cpu_mem_valid && (cpu_mem_addr == `CPU_FREQ_REG_ADDR) && !wr;
    always @(posedge clk) system_cpu_freq_ready <= !resetn ? 1'b0 : system_cpu_freq_valid;

    assign spi_nor_mem_valid = !spi_nor_mem_ready && cpu_mem_valid &&
           (cpu_mem_addr >= `SPI_NOR_MEM_ADDR_START && cpu_mem_addr < `SPI_NOR_MEM_ADDR_END) && !wr;

    spi_nor_flash  spi_nor_flash_I (
        .clk    (clk),
        .resetn (resetn),
        .addr   ({1'b0, word_aligned_addr[21:0]}),
        .data   (spi_nor_mem_data),
        .ready  (spi_nor_mem_ready),
        .valid  (spi_nor_mem_valid),
        .spi_cs (flash_csn),
        .spi_miso(flash_miso),
        .spi_mosi(flash_mosi),
        .spi_sclk(flash_sclk)
    );

    reg tx_seen;
    reg lsr_thre;
    wire uart_tx_rdy;
    wire tx_hit    = cpu_mem_valid && wr && (cpu_mem_addr == `UART_TX_ADDR);
    wire tx_accept = tx_hit && !tx_seen && uart_tx_rdy;
    wire uart_tx_valid_wr = tx_accept;

    always @(posedge clk) begin
        if (!resetn) uart_tx_ready <= 1'b0;
        else uart_tx_ready <= tx_accept;
    end

    always @(posedge clk) begin
        if (!resetn) tx_seen <= 1'b0;
        else if (!tx_hit) tx_seen <= 1'b0;
        else if (tx_accept) tx_seen <= 1'b1;
    end

    always @(posedge clk) begin
        if (!resetn) lsr_thre <= 1'b1;
        else if (tx_accept) lsr_thre <= 1'b0;
        else if (uart_tx_rdy) lsr_thre <= 1'b1;
    end

    tx_uart
     tx_uart_i (
        .clk    (clk),
        .resetn (resetn),
        .valid  (uart_tx_valid_wr),
        .tx_data(cpu_mem_wdata[7:0]),
        .div    (`SYSTEM_CLK / `BAUDRATE),
        .tx_out (uart_tx),
        .ready  (uart_tx_rdy)
    );

    wire uart_lsr_valid_rd = ~uart_lsr_rdy && rd && cpu_mem_valid && cpu_mem_addr == `UART_LSR_ADDR;
    reg uart_lsr_rdy;
    always @(posedge clk) uart_lsr_rdy <= !resetn ? 1'b0 : uart_lsr_valid_rd;

    wire uart_rx_valid_rd;
    wire [31:0] rx_uart_data;
    wire uart_rx_valid = ~uart_rx_ready && cpu_mem_valid && cpu_mem_addr == `UART_RX_ADDR;
    assign uart_rx_valid_rd = rd && uart_rx_valid;

    always @(posedge clk) begin
        uart_rx_ready <= !resetn ? 1'b0 : uart_rx_valid_rd;
    end

    wire rx_uart_rdy = uart_rx_ready;
    rx_uart
    rx_uart_i (
        .clk    (clk),
        .resetn (resetn),
        .rx_in  (uart_rx),
        .error  (),
        .div    (`SYSTEM_CLK / `BAUDRATE),
        .data_rd(rx_uart_rdy),
        .data   (rx_uart_data)
    );

    wire [31:0] mem_sdram_rdata;
    wire mem_sdram_valid;
    wire mem_sdram_ready;
    wire is_sdram = (cpu_mem_addr >= `SDRAM_MEM_ADDR_START && cpu_mem_addr < `SDRAM_MEM_ADDR_END);
    assign mem_sdram_valid = !mem_sdram_ready && cpu_mem_valid && is_sdram;

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

    wire is_bram = (cpu_mem_addr < (`BRAM_WORDS << 2));
    assign bram_valid = !bram_ready && cpu_mem_valid && is_bram;
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

    wire IRQ3;
    wire IRQ7;
    wire clint_valid;
    wire clint_ready;
    wire [31:0] clint_rdata;

    clint #(
        .SYSTEM_CLK(`SYSTEM_CLK),
        .CLOCK_TICK(10000)
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

    kianv_harris_mc_edition #(
        .RESET_ADDR(`RESET_ADDR)
    ) kianv_I (
        .clk         (clk),
        .resetn      (resetn),
        .mem_ready   (cpu_mem_ready),
        .mem_valid   (cpu_mem_valid),
        .mem_wstrb   (cpu_mem_wstrb),
        .mem_addr    (cpu_mem_addr),
        .mem_wdata   (cpu_mem_wdata),
        .mem_rdata   (cpu_mem_rdata),
        .access_fault(access_fault),
        .IRQ3        (IRQ3),
        .IRQ7        (IRQ7),
        .PC          (PC)
    );

    wire is_io = (cpu_mem_addr >= 32'h10_000_000 && cpu_mem_addr <= 32'h12_000_000);
    wire unmatched_io = !(cpu_mem_addr == `UART_LSR_ADDR || cpu_mem_addr == `UART_TX_ADDR || cpu_mem_addr == `UART_RX_ADDR || clint_valid);
    wire access_fault = cpu_mem_valid & (!is_io || !is_bram || !is_sdram);

    reg io_ready;
    reg [31:0] io_rdata;
    reg [7:0] byteswaiting;

    always @(*) begin
        io_rdata = 0;
        io_ready = 1'b0;
        byteswaiting = 0;
        if (is_io) begin
            if (uart_lsr_rdy) begin
                byteswaiting = {1'b0, uart_tx_rdy, lsr_thre, 1'b0, 3'b0, ~(&rx_uart_data)};
                io_rdata = {16'b0, byteswaiting, 8'b0};
                io_ready = 1'b1;
            end else if (uart_rx_ready) begin
                io_rdata = rx_uart_data;
                io_ready = 1'b1;
            end else if (uart_tx_ready) begin
                io_rdata = 0;
                io_ready = 1'b1;
            end else if (clint_ready) begin
                io_rdata = clint_rdata;
                io_ready = 1'b1;
            end else if (unmatched_io) begin
                io_rdata = 0;
                io_ready = 1'b1;
            end
        end
    end

    assign cpu_mem_ready = bram_ready
           || spi_nor_mem_ready
           || system_cpu_freq_ready
           || mem_sdram_ready
           || io_ready;

    assign cpu_mem_rdata =
           bram_ready            ? bram_rdata    :
           spi_nor_mem_ready     ? spi_nor_mem_data :
           system_cpu_freq_ready ? `SYSTEM_CLK   :
           mem_sdram_ready       ? mem_sdram_rdata :
           io_ready              ? io_rdata      :
           32'h0000_0000;

endmodule

