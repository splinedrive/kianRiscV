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
    WAYS = 2
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
  reg [31:0] block_address;
  localparam BLOCK_SIZE = 4;
  localparam BLOCK_OFFSET = $clog2(BLOCK_SIZE);
  localparam ICACHE_ENTRIES_PER_WAY_WIDTH = $clog2(ICACHE_ENTRIES_PER_WAY);
  localparam TAG_WIDTH = (32 - ICACHE_ENTRIES_PER_WAY_WIDTH - BLOCK_OFFSET);

  reg  [ICACHE_ENTRIES_PER_WAY_WIDTH -1:0] idx;
  reg                                      we;
  reg                                      valid     [1:0];
  wire                                     hit       [1:0];
  reg  [                             31:0] payload_i;
  wire [                             31:0] payload_o [1:0];

  reg  [                   TAG_WIDTH -1:0] tag;
  reg  [      ICACHE_ENTRIES_PER_WAY -1:0] lru;
  reg  [      ICACHE_ENTRIES_PER_WAY -1:0] lru_nxt;

  genvar i;
  generate
    for (i = 0; i < WAYS; i = i + 1) begin
      tag_ram #(
          .TAG_RAM_ADDR_WIDTH(ICACHE_ENTRIES_PER_WAY_WIDTH),
          .TAG_WIDTH(TAG_WIDTH),
          .PAYLOAD_WIDTH(32)
      ) cache_I0 (
          .clk      (clk),
          .resetn   (resetn),
          .idx      (idx),
          .tag      (tag),
          .we       (we),
          .valid_i  (valid[i]),
          .hit_o    (hit[i]),
          .payload_i(payload_i),
          .payload_o(payload_o[i])
      );
    end
  endgenerate

  localparam S0 = 0, S1 = 1, S2 = 2, S_LAST = 3;
  reg [$clog2(S_LAST) -1:0] state, next_state;
  reg hit_occured;
  reg hit_occured_nxt;
  always @(posedge clk) begin
    if (!resetn) begin
      state <= S0;
      hit_occured <= 0;
      lru <= 0;
    end else begin
      state <= next_state;
      hit_occured <= hit_occured_nxt;
      lru <= lru_nxt;
    end
  end

  wire fetch_valid;
  assign fetch_valid = cpu_valid_i && !cpu_ready_o;
  always @(*) begin
    next_state = state;

    case (state)
      S0: next_state = !fetch_valid ? S0 : (hit[0] || hit[1] ? S2 : S1);
      S1: next_state = ram_ready_i ? S0 : S1;
      S2: next_state = S0;
      default: next_state = S0;
    endcase
  end

  always @(*) begin
    /* verilator lint_off WIDTHTRUNC */
    block_address = cpu_addr_i >> BLOCK_OFFSET;
    tag = block_address >> (ICACHE_ENTRIES_PER_WAY_WIDTH);
    idx = (block_address) & ((1 << ICACHE_ENTRIES_PER_WAY_WIDTH) - 1);
    /* verilator lint_on WIDTHTRUNC */

    cpu_dout_o = ram_rdata_i;
    cpu_ready_o = 1'b0;

    payload_i = ram_rdata_i;

    ram_addr_o = cpu_addr_i;
    ram_valid_o = 1'b0;

    valid[0] = 1'b0;
    valid[1] = 1'b0;
    we = 1'b0;
    lru_nxt = lru;
    hit_occured_nxt = hit_occured;

    case (state)
      S0: begin
        valid[0] = fetch_valid;
        valid[1] = fetch_valid;
        hit_occured_nxt = hit[1];
      end
      S1: begin
        if (ram_ready_i) begin : miss_case
          we = 1'b1;
          valid[lru[idx]] = 1'b1;
          lru_nxt[idx] = !lru[idx];
          cpu_ready_o = 1'b1;
        end else begin
          ram_valid_o = 1'b1;
        end
      end
      S2: begin : hit_case
        valid[hit_occured] = 1'b1;
        lru_nxt[idx] = !hit_occured;
        cpu_ready_o = 1'b1;
        cpu_dout_o = payload_o[hit_occured];
      end
    endcase
  end

endmodule
