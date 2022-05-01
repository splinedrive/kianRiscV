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
#pragma once
namespace CacheTypes {
  constexpr int BYTE_ADDRESS_LEN   = 32;
  constexpr int BYTES_PER_BLOCK    = 4;
  constexpr int BLOCK_ADDRESS_LEN  = BYTE_ADDRESS_LEN / BYTES_PER_BLOCK;
  constexpr int CACHE_BLOCK_LEN    = 8;
  constexpr int CACHE_INDEX_LEN    = std::log2(CACHE_BLOCK_LEN);
  constexpr int TAG_LEN            = BYTE_ADDRESS_LEN - CACHE_INDEX_LEN - std::log2(BYTES_PER_BLOCK);

  constexpr int WORD_LEN           = BYTES_PER_BLOCK * 8;
  const int RAM_LEN                = 1024;
  std::bitset<WORD_LEN> ram[RAM_LEN];

  typedef std::bitset<BYTE_ADDRESS_LEN> addr_t;
  typedef std::bitset<1> valid_t;
  typedef std::bitset<WORD_LEN> data_t;
  typedef std::bitset<TAG_LEN> tag_t;

  typedef struct {
    valid_t        valid;
    tag_t          tag;
    data_t         data;
  } CACHE_LINE;

  typedef struct {
    CACHE_LINE line [CACHE_BLOCK_LEN];
  } CACHE;

  CACHE cache;
};
