/*
 *  kianv.v - a simple RISC-V rv32ima
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
/*
PLIC Memory Map
base + 0x000000: Reserved (interrupt source 0 does not exist)
base + 0x000004: Interrupt source 1 priority
base + 0x000008: Interrupt source 2 priority
...
base + 0x000FFC: Interrupt source 1023 priority
base + 0x001000: Interrupt Pending bit 0-31
base + 0x00107C: Interrupt Pending bit 992-1023
...
base + 0x002000: Enable bits for sources 0-31 on context 0
base + 0x002004: Enable bits for sources 32-63 on context 0
...
base + 0x00207C: Enable bits for sources 992-1023 on context 0
base + 0x002080: Enable bits for sources 0-31 on context 1
base + 0x002084: Enable bits for sources 32-63 on context 1
...
base + 0x0020FC: Enable bits for sources 992-1023 on context 1
base + 0x002100: Enable bits for sources 0-31 on context 2
base + 0x002104: Enable bits for sources 32-63 on context 2
...
base + 0x00217C: Enable bits for sources 992-1023 on context 2
...
base + 0x1F1F80: Enable bits for sources 0-31 on context 15871
base + 0x1F1F84: Enable bits for sources 32-63 on context 15871
base + 0x1F1FFC: Enable bits for sources 992-1023 on context 15871
...
base + 0x1FFFFC: Reserved
base + 0x200000: Priority threshold for context 0
base + 0x200004: Claim/complete for context 0
base + 0x200008: Reserved
...
base + 0x200FFC: Reserved
base + 0x201000: Priority threshold for context 1
base + 0x201004: Claim/complete for context 1
...
base + 0x3FFF000: Priority threshold for context 15871
base + 0x3FFF004: Claim/complete for context 15871
base + 0x3FFF008: Reserved
...
base + 0x3 FFF FFC: Reserved
*/
`default_nettype none
module plic (
    input wire clk,
    input wire resetn,
    input wire valid,
    input wire [23:0] addr,
    input wire [3:0] wmask,
    input wire [31:0] wdata,
    output reg [31:0] rdata,
    input wire [31:1] interrupt_request,  // 0 is reserved
    output wire is_valid,
    output reg ready,
    output wire interrupt_request_ctx0,  // machine mode
    output wire interrupt_request_ctx1  // supervisor mode
);

  wire we = |wmask;
  wire is_pending_0_31 = (addr == 24'h00_1000);
  wire is_enable_ctx0_0_31 = (addr == 24'h00_2000);
  wire is_enable_ctx1_0_31 = (addr == 24'h00_2080);
  wire is_claim_complete_ctx0 = (addr == 24'h20_0004);
  wire is_claim_complete_ctx1 = (addr == 24'h20_1004);

  assign is_valid = !ready && valid;
  always @(posedge clk) begin
    if (!resetn) begin
      ready <= 1'b0;
    end else begin
      ready <= is_valid;
    end
  end

  integer i;
  reg [31:0] enable_ctx0_0_31;
  always @(posedge clk) begin
    if (!resetn) begin
      enable_ctx0_0_31 <= 0;
    end else if (valid && is_enable_ctx0_0_31) begin
      for (i = 0; i < 4; i = i + 1) begin
        if (wmask[i]) enable_ctx0_0_31[i*8+:8] <= wdata[i*8+:8];
      end
    end
  end

  reg [31:0] enable_ctx1_0_31;
  always @(posedge clk) begin
    if (!resetn) begin
      enable_ctx1_0_31 <= 0;
    end else if (valid && is_enable_ctx1_0_31) begin
      for (i = 0; i < 4; i = i + 1) begin
        if (wmask[i]) enable_ctx1_0_31[i*8+:8] <= wdata[i*8+:8];
      end
    end
  end

  reg [31:0] pending_ctx0;
  always @(posedge clk) begin
    if (!resetn) begin
      pending_ctx0 <= 0;
    end else begin
      if (is_claim_complete_ctx0 && we && valid) begin
        pending_ctx0 <= pending_ctx0 & ~(1 << wdata[7:0]);
      end else begin
        pending_ctx0 <= pending_ctx0 | ({interrupt_request, 1'b0} & enable_ctx0_0_31);
      end
    end
  end

  reg [31:0] pending_ctx1;
  always @(posedge clk) begin
    if (!resetn) begin
      pending_ctx1 <= 0;
    end else begin
      if (is_claim_complete_ctx1 && we && valid) begin
        pending_ctx1 <= pending_ctx1 & ~(1 << wdata[7:0]);
      end else begin
        pending_ctx1 <= pending_ctx1 | ({interrupt_request, 1'b0} & enable_ctx1_0_31);
      end
    end
  end

  wire [31:0] claim_ctx0;
  Priority_Encoder #(
      .WORD_WIDTH(32)
  ) priority_encoder_i0 (
      .word_in(pending_ctx0 & -pending_ctx0),
      .word_out(claim_ctx0),
      .word_out_valid()
  );

  wire [31:0] claim_ctx1;
  Priority_Encoder #(
      .WORD_WIDTH(32)
  ) priority_encoder_i1 (
      .word_in(pending_ctx1 & -pending_ctx1),
      .word_out(claim_ctx1),
      .word_out_valid()
  );

  always @(*) begin
    case (1'b1)
      is_pending_0_31: rdata = pending_ctx0 | pending_ctx1;
      is_enable_ctx0_0_31: rdata = enable_ctx0_0_31;
      is_enable_ctx1_0_31: rdata = enable_ctx1_0_31;
      is_claim_complete_ctx0: rdata = claim_ctx0;
      is_claim_complete_ctx1: rdata = claim_ctx1;
      default: rdata = 0;
    endcase
  end

  assign interrupt_request_ctx0 = |pending_ctx0;
  assign interrupt_request_ctx1 = |pending_ctx1;

endmodule
