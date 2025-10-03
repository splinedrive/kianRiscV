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
module associative_cache #(
    parameter TAG_WIDTH = 20,
    parameter PAYLOAD_WIDTH = 32,
    parameter TOTAL_ENTRIES = 64,
    parameter WAYS = 4,
    parameter REPLACEMENT_POLICY = "LRU"  // "LRU", "LPRU", "RANDOM", "ROUND_ROBIN"
) (
    input  wire                     clk,
    input  wire                     resetn,
    input  wire [    TAG_WIDTH-1:0] tag,
    input  wire                     we,
    input  wire                     valid_i,
    output wire                     hit_o,
    input  wire [PAYLOAD_WIDTH-1:0] payload_i,
    output reg  [PAYLOAD_WIDTH-1:0] payload_o
);

  localparam SETS = TOTAL_ENTRIES / WAYS;
  localparam SET_WIDTH = $clog2(SETS);
  localparam WAY_WIDTH = $clog2(WAYS);
  localparam TAG_RAM_WIDTH = $clog2(SETS);

  wire [SET_WIDTH-1:0] set_idx = tag[SET_WIDTH-1:0];
  wire [TAG_WIDTH-SET_WIDTH-1:0] tag_portion = tag[TAG_WIDTH-1:SET_WIDTH];
  // Signals for each way
  wire [WAYS-1:0] way_hit;
  wire [WAYS-1:0] way_we;
  wire [PAYLOAD_WIDTH-1:0] way_payload_o[WAYS-1:0];

  assign hit_o = |way_hit;

  reg [WAY_WIDTH-1:0] hit_way;
  integer i;
  always @(*) begin
    hit_way = 0;
    for (i = 0; i < WAYS; i = i + 1) begin
      if (way_hit[i]) begin
        hit_way = i[WAY_WIDTH-1:0];
      end
    end
  end

  always @(*) begin
    payload_o = way_payload_o[hit_way];
  end

  wire [WAY_WIDTH-1:0] replace_way;

  generate
    if (REPLACEMENT_POLICY == "LRU") begin : lru_policy
      lru_replacement #(
          .SETS(SETS),
          .SET_WIDTH(SET_WIDTH),
          .WAYS(WAYS)
      ) lru_inst (
          .clk(clk),
          .resetn(resetn),
          .set_idx(set_idx),
          .access(hit_o || (we && valid_i)),
          .access_way(hit_o ? hit_way : replace_way),
          .lru_way(replace_way)
      );
    end else if (REPLACEMENT_POLICY == "LPRU") begin : lpru_policy
      lpru_replacement #(
          .SETS(SETS),
          .SET_WIDTH(SET_WIDTH),
          .WAYS(WAYS)
      ) lpru_inst (
          .clk(clk),
          .resetn(resetn),
          .set_idx(set_idx),
          .access(hit_o || (we && valid_i)),
          .access_way(hit_o ? hit_way : replace_way),
          .lpru_way(replace_way)
      );
    end else if (REPLACEMENT_POLICY == "RANDOM") begin : random_policy
      random_replacement #(
          .WAYS(WAYS)
      ) rand_inst (
          .clk(clk),
          .resetn(resetn),
          .random_way(replace_way)
      );
    end else begin : round_robin_policy
      round_robin_replacement #(
          .SETS(SETS),
          .SET_WIDTH(SET_WIDTH),
          .WAYS(WAYS)
      ) rr_inst (
          .clk(clk),
          .resetn(resetn),
          .set_idx(set_idx),
          .access(we && valid_i && !hit_o),
          .next_way(replace_way)
      );
    end
  endgenerate

  genvar j;
  generate
    for (j = 0; j < WAYS; j = j + 1) begin : way_we_gen
      assign way_we[j] = we && valid_i && (hit_o ? (hit_way == j) : (replace_way == j));
    end
  endgenerate

  generate
    for (j = 0; j < WAYS; j = j + 1) begin : way_inst
      tag_ram #(
          .TAG_RAM_ADDR_WIDTH(TAG_RAM_WIDTH),
          .TAG_WIDTH(TAG_WIDTH - SET_WIDTH),
          .PAYLOAD_WIDTH(PAYLOAD_WIDTH)
      ) way_ram (
          .clk(clk),
          .resetn(resetn),
          .idx(set_idx),
          .tag(tag_portion),
          .we(way_we[j]),
          .valid_i(1'b1),
          .hit_o(way_hit[j]),
          .payload_i(payload_i),
          .payload_o(way_payload_o[j])
      );
    end
  endgenerate
endmodule

module lru_replacement #(
    parameter SETS = 16,
    parameter SET_WIDTH = 4,
    parameter WAYS = 4
) (
    input  wire                    clk,
    input  wire                    resetn,
    input  wire [   SET_WIDTH-1:0] set_idx,
    input  wire                    access,
    input  wire [$clog2(WAYS)-1:0] access_way,
    output reg  [$clog2(WAYS)-1:0] lru_way
);
  localparam WAY_WIDTH = $clog2(WAYS);
  generate
    if (WAYS == 2) begin : two_way
      reg lru_bit[SETS-1:0];
      integer i;
      always @(posedge clk) begin
        if (!resetn) begin
          for (i = 0; i < SETS; i = i + 1) begin
            lru_bit[i] <= 1'b0;
          end
        end else if (access) begin
          lru_bit[set_idx] <= access_way[0];
        end
      end
      always @(*) begin
        lru_way = ~lru_bit[set_idx];
      end
    end else if (WAYS == 4) begin : four_way
      reg [2:0] lru_state[SETS-1:0];
      integer i;
      always @(posedge clk) begin
        if (!resetn) begin
          for (i = 0; i < SETS; i = i + 1) begin
            lru_state[i] <= 3'b000;
          end
        end else if (access) begin
          case (access_way)
            2'b00: lru_state[set_idx] <= {1'b1, lru_state[set_idx][1], 1'b1};
            2'b01: lru_state[set_idx] <= {1'b1, lru_state[set_idx][1], 1'b0};
            2'b10: lru_state[set_idx] <= {1'b0, 1'b1, lru_state[set_idx][0]};
            2'b11: lru_state[set_idx] <= {1'b0, 1'b0, lru_state[set_idx][0]};
          endcase
        end
      end
      always @(*) begin
        case (lru_state[set_idx])
          3'b000: lru_way = 2'b00;
          3'b001: lru_way = 2'b01;
          3'b010: lru_way = 2'b00;
          3'b011: lru_way = 2'b01;
          3'b100: lru_way = 2'b10;
          3'b101: lru_way = 2'b11;
          3'b110: lru_way = 2'b10;
          3'b111: lru_way = 2'b11;
        endcase
      end
    end else begin : general_way
      reg [WAY_WIDTH:0] age_counter[WAYS-1:0][SETS-1:0];
      integer i, j;
      always @(posedge clk) begin
        if (!resetn) begin
          for (i = 0; i < WAYS; i = i + 1) begin
            for (j = 0; j < SETS; j = j + 1) begin
              age_counter[i][j] <= i;
            end
          end
        end else if (access) begin
          for (i = 0; i < WAYS; i = i + 1) begin
            if (i == access_way) begin
              age_counter[i][set_idx] <= 0;
            end else begin
              age_counter[i][set_idx] <= age_counter[i][set_idx] + 1;
            end
          end
        end
      end
      always @(*) begin
        lru_way = 0;
        begin : lru_search
          integer k;
          for (k = 1; k < WAYS; k = k + 1) begin
            if (age_counter[k][set_idx] > age_counter[lru_way][set_idx]) begin
              lru_way = k[WAY_WIDTH-1:0];
            end
          end
        end
      end
    end
  endgenerate
endmodule

module lpru_replacement #(
    parameter SETS = 16,
    parameter SET_WIDTH = 4,
    parameter WAYS = 4
) (
    input  wire                    clk,
    input  wire                    resetn,
    input  wire [   SET_WIDTH-1:0] set_idx,
    input  wire                    access,
    input  wire [$clog2(WAYS)-1:0] access_way,
    output reg  [$clog2(WAYS)-1:0] lpru_way
);
  localparam WAY_WIDTH = $clog2(WAYS);

  reg [WAYS-1:0] usage_bits[SETS-1:0];

  integer i, j;

  always @(posedge clk) begin
    if (!resetn) begin
      for (i = 0; i < SETS; i = i + 1) begin
        usage_bits[i] <= {WAYS{1'b0}};
      end
    end else if (access) begin
      usage_bits[set_idx][access_way] <= 1'b1;

      if (&usage_bits[set_idx]) begin
        usage_bits[set_idx] <= (1 << access_way);
      end
    end
  end

  reg found;
  always @(*) begin
    lpru_way = 0;
    found = 0;
    for (j = 0; j < WAYS; j = j + 1) begin
      if (!usage_bits[set_idx][j] && !found) begin
        lpru_way = j[WAY_WIDTH-1:0];
        found = 1;
      end
    end
  end

endmodule

module random_replacement #(
    parameter WAYS = 4
) (
    input  wire                    clk,
    input  wire                    resetn,
    output reg  [$clog2(WAYS)-1:0] random_way
);
  localparam WAY_WIDTH = $clog2(WAYS);

  reg [7:0] lfsr;

  always @(posedge clk) begin
    if (!resetn) begin
      lfsr <= 8'h1;
    end else begin
      lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3]};
    end
  end

  always @(*) begin
    random_way = lfsr[WAY_WIDTH-1:0];
  end

endmodule

module round_robin_replacement #(
    parameter SETS = 16,
    parameter SET_WIDTH = 4,
    parameter WAYS = 4
) (
    input  wire                    clk,
    input  wire                    resetn,
    input  wire [   SET_WIDTH-1:0] set_idx,
    input  wire                    access,
    output reg  [$clog2(WAYS)-1:0] next_way
);
  localparam WAY_WIDTH = $clog2(WAYS);
  localparam MAX_WAY = WAYS - 1;
  reg [WAY_WIDTH-1:0] rr_counter[SETS-1:0];
  integer i;
  always @(posedge clk) begin
    if (!resetn) begin
      for (i = 0; i < SETS; i = i + 1) begin
        rr_counter[i] <= 0;
      end
    end else if (access) begin
      if (rr_counter[set_idx] == MAX_WAY[WAY_WIDTH-1:0]) begin
        rr_counter[set_idx] <= 0;
      end else begin
        rr_counter[set_idx] <= rr_counter[set_idx] + 1'b1;
      end
    end
  end
  always @(*) begin
    next_way = rr_counter[set_idx];
  end
endmodule
