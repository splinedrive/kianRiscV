/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2024 hirosh dabui <hirosh@dabui.de>
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
`default_nettype none

module icache #(
    parameter ICACHE_ENTRIES_PER_WAY = 64,
    parameter WAYS = 2,
    parameter REPLACEMENT_POLICY = "LRU"
) (
    input wire clk,
    input wire resetn,
    input wire [31:0] cpu_addr_i,
    input wire cpu_valid_i,
    output reg [31:0] cpu_dout_o,
    output reg cpu_ready_o,
    output reg [31:0] ram_addr_o,
    input wire [31:0] ram_rdata_i,
    output reg ram_valid_o,
    input wire ram_ready_i
);


  localparam TOTAL_ENTRIES = ICACHE_ENTRIES_PER_WAY * WAYS;
  localparam BLOCK_SIZE = 4;
  localparam BLOCK_OFFSET = $clog2(BLOCK_SIZE);
  localparam ICACHE_ENTRIES_PER_WAY_WIDTH = $clog2(ICACHE_ENTRIES_PER_WAY);
  localparam TAG_WIDTH = (32 - ICACHE_ENTRIES_PER_WAY_WIDTH - BLOCK_OFFSET);


  reg [31:0] block_address;
  reg [ICACHE_ENTRIES_PER_WAY_WIDTH-1:0] idx;
  reg [TAG_WIDTH-1:0] tag;


  reg cache_we;
  reg cache_valid_i;
  wire cache_hit_o;
  reg [31:0] cache_payload_i;
  wire [31:0] cache_payload_o;


  localparam S0 = 0, S1 = 1, S2 = 2, S_LAST = 3;
  reg [$clog2(S_LAST)-1:0] state, next_state;
  reg hit_occurred;
  reg hit_occurred_nxt;


  wire [TAG_WIDTH + ICACHE_ENTRIES_PER_WAY_WIDTH - 1:0] full_tag;
  assign full_tag = {tag, idx};


  associative_cache #(
      .TAG_WIDTH(TAG_WIDTH + ICACHE_ENTRIES_PER_WAY_WIDTH),
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


  always @(posedge clk) begin
    if (!resetn) begin
      state <= S0;
      hit_occurred <= 1'b0;
    end else begin
      state <= next_state;
      hit_occurred <= hit_occurred_nxt;
    end
  end

  wire fetch_valid;
  assign fetch_valid = cpu_valid_i && !cpu_ready_o;


  always @(*) begin
    next_state = state;
    case (state)
      S0: next_state = !fetch_valid ? S0 : (cache_hit_o ? S2 : S1);
      S1: next_state = ram_ready_i ? S0 : S1;
      S2: next_state = S0;
      default: next_state = S0;
    endcase
  end


  always @(*) begin

    block_address = cpu_addr_i >> BLOCK_OFFSET;
    tag = block_address >> (ICACHE_ENTRIES_PER_WAY_WIDTH);
    idx = (block_address) & ((1 << ICACHE_ENTRIES_PER_WAY_WIDTH) - 1);



    cpu_dout_o = ram_rdata_i;
    cpu_ready_o = 1'b0;
    ram_addr_o = cpu_addr_i;
    ram_valid_o = 1'b0;


    cache_we = 1'b0;
    cache_valid_i = 1'b0;
    cache_payload_i = ram_rdata_i;
    hit_occurred_nxt = hit_occurred;

    case (state)
      S0: begin

        cache_valid_i = fetch_valid;
        hit_occurred_nxt = cache_hit_o && fetch_valid;
      end

      S1: begin

        if (ram_ready_i) begin
          cache_we = 1'b1;
          cache_valid_i = 1'b1;
          cpu_ready_o = 1'b1;
        end else begin
          ram_valid_o = 1'b1;
        end
      end

      S2: begin

        cpu_ready_o = 1'b1;
        cpu_dout_o  = cache_payload_o;
      end
    endcase
  end

  initial begin

  end

endmodule
