/*
 *  kianv harris multicycle RISC-V rv32ima
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
`ifndef SV32_VH
`define SV32_VH

`define SV32_LEVELS 2
`define SV32_PTE_SIZE 4  // size in bytes
`define SV32_PTE_SHIFT 2
`define SV32_PTE_V_SHIFT 0  // Valid bit position
`define SV32_PTE_R_SHIFT 1  // Read bit position
`define SV32_PTE_W_SHIFT 2  // Write bit position
`define SV32_PTE_X_SHIFT 3  // Execute bit position
`define SV32_PTE_U_SHIFT 4  // User bit position
`define SV32_PTE_G_SHIFT 5  // Global bit position
`define SV32_PTE_A_SHIFT 6  // Accessed bit position
`define SV32_PTE_D_SHIFT 7  // Dirty bit position
`define SV32_PTE_RSW_SHIFT 8  // Reserved for Software use
`define SV32_PTE_PPN_SHIFT 10  // Physical Page Number bit position

`define SV32_PTE_PPN_BITS 22  // Number of bits for Physical Page Number
`define SV32_PAGE_SIZE 4096  // Page size in bytes (4 KiB for Sv32)
`define SV32_PAGE_OFFSET_BITS 12  // Number of bits for page offset (log2 of page size)

`define SV32_OFFSET_BITS 12
`define SV32_VPN0_BITS 10
`define SV32_VPN1_BITS 10

`define SV32_SATP_MODE_MASK 31

`define SV32_OFFSET_MASK ((32'h1 << `SV32_OFFSET_BITS) - 1)
`define SV32_VPN0_MASK (((32'h1 << `SV32_VPN0_BITS) - 1) << `SV32_OFFSET_BITS)
`define SV32_VPN1_MASK (((32'h1 << `SV32_VPN1_BITS) - 1) << (`SV32_OFFSET_BITS + `SV32_VPN0_BITS))

`define SV32_VPN0_SHIFT 10
`define SV32_VPN1_SHIFT (`SV32_OFFSET_BITS + `SV32_VPN0_BITS)

`define PTE_V_MASK (32'h1 << 0)
`define PTE_R_MASK (32'h1 << 1)
`define PTE_W_MASK (32'h1 << 2)
`define PTE_X_MASK (32'h1 << 3)
`define PTE_U_MASK (32'h1 << 4)
`define PTE_G_MASK (32'h1 << 5)
`define PTE_A_MASK (32'h1 << 6)
`define PTE_D_MASK (32'h1 << 7)
`define PTE_RSW_MASK (32'h3 << 8)  // 2 bits for RSW
`define PTE_PPN_MASK 32'hFFFFF000  // 22 bits for PPN
`define PTE_FLAGS 32'h3FF

`define SET_PTE_V(pte, val) ((val) << 0)
`define SET_PTE_R(pte, val) ((val) << 1)
`define SET_PTE_W(pte, val) ((val) << 2)
`define SET_PTE_X(pte, val) ((val) << 3)
`define SET_PTE_U(pte, val) ((val) << 4)
`define SET_PTE_G(pte, val) ((val) << 5)
`define SET_PTE_A(pte, val) ((val) << 6)
`define SET_PTE_D(pte, val) ((val) << 7)
`define SET_PTE_RSW(pte, val) ((val) << 8)
`define SET_PTE_PPN(pte, val) ((val) << 10)

`define GET_PTE_V(pte) (((pte) & `PTE_V_MASK) >> 0)
`define GET_PTE_R(pte) (((pte) & `PTE_R_MASK) >> 1)
`define GET_PTE_W(pte) (((pte) & `PTE_W_MASK) >> 2)
`define GET_PTE_X(pte) (((pte) & `PTE_X_MASK) >> 3)
`define GET_PTE_U(pte) (((pte) & `PTE_U_MASK) >> 4)
`define GET_PTE_G(pte) (((pte) & `PTE_G_MASK) >> 5)
`define GET_PTE_A(pte) (((pte) & `PTE_A_MASK) >> 6)
`define GET_PTE_D(pte) (((pte) & `PTE_D_MASK) >> 7)
`define GET_PTE_RSW(pte) (((pte) & `PTE_RSW_MASK) >> 8)
`define GET_PTE_PPN(pte) (((pte) & `PTE_PPN_MASK) >> 10)

`define SATP_MODE_MASK 32'h80000000
`define SATP_ASID_MASK 32'h7FC00000
`define SATP_PPN_MASK 32'h003FFFFF

`define SATP_MODE_SHIFT 31
`define SATP_ASID_SHIFT 22
`define SATP_PPN_SHIFT 0

`define SET_SATP_MODE(satp, mode) ((mode) << `SATP_MODE_SHIFT))
`define SET_SATP_ASID(satp, asid) ((asid) << `SATP_ASID_SHIFT))
`define SET_SATP_PPN(satp, ppn) (((ppn) << `SATP_PPN_SHIFT))

`define GET_SATP_MODE(satp) ((satp & `SATP_MODE_MASK) >> `SATP_MODE_SHIFT)
`define GET_SATP_ASID(satp) ((satp & `SATP_ASID_MASK) >> `SATP_ASID_SHIFT)
`define GET_SATP_PPN(satp) ((satp & `SATP_PPN_MASK) >> `SATP_PPN_SHIFT)

`endif
