/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2025 hirosh dabui <hirosh@dabui.de>
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
/*
 *  (write-through dcache)
 */
/*
 *  kianv harris multicycle RISC-V rv32ima
 *  (write-through dcache; partial write miss = no RFO, no-allocate)
 */
`default_nettype none

module dcache #(
    parameter DCACHE_ENTRIES_PER_WAY = 64,
    parameter WAYS = 2,
    parameter REPLACEMENT_POLICY = "LRU"
) (
    input  wire        clk,
    input  wire        resetn,
    input  wire [31:0] cpu_addr_i,
    input  wire [ 3:0] cpu_wmask_i,
    input  wire [31:0] cpu_din_i,
    input  wire        cpu_valid_i,
    output reg  [31:0] cpu_dout_o,
    output reg         cpu_ready_o,
    output reg  [31:0] ram_addr_o,
    output reg  [ 3:0] ram_wmask_o,
    output reg  [31:0] ram_wdata_o,
    input  wire [31:0] ram_rdata_i,
    output reg         ram_valid_o,
    input  wire        ram_ready_i
);


  localparam TOTAL_ENTRIES = DCACHE_ENTRIES_PER_WAY * WAYS;
  localparam BLOCK_SIZE = 4;
  localparam BLOCK_OFFSET = $clog2(BLOCK_SIZE);
  localparam DCACHE_ENTRIES_PER_WAY_WIDTH = $clog2(DCACHE_ENTRIES_PER_WAY);
  localparam TAG_WIDTH = (32 - DCACHE_ENTRIES_PER_WAY_WIDTH - BLOCK_OFFSET);


  wire [31:0] addr_q;
  wire [31:0] block_address_w;
  wire [DCACHE_ENTRIES_PER_WAY_WIDTH-1:0] idx_w;
  wire [TAG_WIDTH-1:0] tag_w;


  reg cache_we;
  reg cache_valid_i;
  wire cache_hit_o;
  reg [31:0] cache_payload_i;
  wire [31:0] cache_payload_o;


  wire [TAG_WIDTH + DCACHE_ENTRIES_PER_WAY_WIDTH - 1:0] full_tag;
  assign full_tag = {tag_w, idx_w};


  associative_cache #(
      .TAG_WIDTH(TAG_WIDTH + DCACHE_ENTRIES_PER_WAY_WIDTH),
      .PAYLOAD_WIDTH(32),
      .TOTAL_ENTRIES(TOTAL_ENTRIES),
      .WAYS(WAYS),
      .REPLACEMENT_POLICY(REPLACEMENT_POLICY)
  ) cache_inst (
      .clk(clk),
      .resetn(resetn),
      .tag(full_tag),
      .we(cache_we),
      .valid_i(cache_valid_i),
      .hit_o(cache_hit_o),
      .payload_i(cache_payload_i),
      .payload_o(cache_payload_o)
  );


  function [31:0] expand_wmask;
    input [3:0] m;
    begin
      expand_wmask = {{8{m[3]}}, {8{m[2]}}, {8{m[1]}}, {8{m[0]}}};
    end
  endfunction


  reg  [31:0] req_addr;
  reg  [31:0] req_wdata;
  reg  [ 3:0] req_wmask;
  reg         req_is_write;
  reg         req_full_mask;
  reg         req_sel_is_hit;
  reg         req_sel_way;
  reg  [31:0] mem_data_buf;


  wire        in_lookup = (state == S0);
  assign addr_q = in_lookup ? cpu_addr_i : req_addr;
  wire [31:0] wdata_q = in_lookup ? cpu_din_i : req_wdata;
  wire [ 3:0] wmask_q = in_lookup ? cpu_wmask_i : req_wmask;
  wire [31:0] wmask32 = expand_wmask(wmask_q);


  assign block_address_w = addr_q >> BLOCK_OFFSET;
  assign tag_w = block_address_w >> (DCACHE_ENTRIES_PER_WAY_WIDTH);
  assign idx_w = block_address_w[DCACHE_ENTRIES_PER_WAY_WIDTH-1:0];



  localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3, S_LAST = 4;
  reg [$clog2(S_LAST) -1:0] state, next_state;
  reg  hit_occured;
  reg  hit_occured_nxt;


  wire fetch_valid = cpu_valid_i && (state == S0);

  wire cache_hit_any = cache_hit_o;

  always @(posedge clk) begin
    if (!resetn) begin
      state          <= S0;
      hit_occured    <= 1'b0;
      req_is_write   <= 1'b0;
      req_full_mask  <= 1'b0;
      req_addr       <= 32'b0;
      req_wdata      <= 32'b0;
      req_wmask      <= 4'b0;
      req_sel_is_hit <= 1'b0;
      req_sel_way    <= 1'b0;
      mem_data_buf   <= 32'b0;
    end else begin
      state       <= next_state;
      hit_occured <= hit_occured_nxt;

      if (fetch_valid) begin
        req_addr       <= cpu_addr_i;
        req_wdata      <= cpu_din_i;
        req_wmask      <= cpu_wmask_i;
        req_is_write   <= (cpu_wmask_i != 4'b0000);
        req_full_mask  <= (&cpu_wmask_i);
        req_sel_is_hit <= cache_hit_any;
        req_sel_way    <= 1'b0;
      end

      if (state == S1 && ram_ready_i) begin
        mem_data_buf <= ram_rdata_i;
      end
    end
  end


  always @(*) begin
    next_state = state;
    case (state)

      S0: begin
        if (!fetch_valid) begin
          next_state = S0;
        end else if (cache_hit_any) begin

          next_state = (wmask_q != 4'b0000) ? S3 : S2;
        end else begin

          if (wmask_q == 4'b0000) begin
            next_state = S1;
          end else if (&wmask_q) begin
            next_state = S3;
          end else begin
            next_state = S3;
          end
        end
      end

      S1: begin
        if (ram_ready_i) begin
          next_state = S0;
        end else begin
          next_state = S1;
        end
      end

      S2:      next_state = S0;

      S3: begin
        if (ram_ready_i) next_state = S0;
        else next_state = S3;
      end
      default: next_state = S0;
    endcase
  end


  always @(*) begin

    cpu_dout_o      = ram_rdata_i;
    cpu_ready_o     = 1'b0;
    cache_payload_i = ram_rdata_i;
    ram_addr_o      = addr_q;
    ram_valid_o     = 1'b0;
    ram_wmask_o     = 4'b0000;
    ram_wdata_o     = wdata_q;
    cache_we        = 1'b0;
    cache_valid_i   = 1'b0;


    hit_occured_nxt = hit_occured;
    if (state == S0 && fetch_valid) begin
      hit_occured_nxt = cache_hit_o;
    end

    case (state)

      S0: begin
        cache_valid_i = fetch_valid;
      end


      S1: begin
        if (ram_ready_i) begin

          cache_we        = 1'b1;
          cache_valid_i   = 1'b1;
          cache_payload_i = ram_rdata_i;
          cpu_ready_o     = 1'b1;
        end else begin

          ram_valid_o = 1'b1;
          ram_wmask_o = 4'b0000;
        end
      end


      S2: begin
        cpu_ready_o = 1'b1;
        cpu_dout_o  = cache_payload_o;
      end


      S3: begin

        ram_valid_o = 1'b1;
        ram_wmask_o = req_wmask;
        ram_wdata_o = req_wdata;
        if (ram_ready_i) begin
          if (req_sel_is_hit) begin

            cache_we        = 1'b1;
            cache_valid_i   = 1'b1;
            cache_payload_i = (cache_payload_o & ~wmask32) | (wdata_q & wmask32);
          end else if (req_full_mask) begin

            cache_we        = 1'b1;
            cache_valid_i   = 1'b1;
            cache_payload_i = wdata_q;
          end else begin


            cache_we = 1'b0;
          end
          cpu_ready_o = 1'b1;
        end
      end
    endcase
  end

endmodule
