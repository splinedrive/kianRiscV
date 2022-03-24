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
#include <stdint.h>
#include <bitset>
#include <cassert>
#include <iostream>
#include <cmath>
#include "direct_cache.hxx"

using namespace CacheTypes;
class Cache {
  void initRam() {
    for (auto i = 0; i < RAM_LEN; i++) {
      ram[i] = i;
    }
  }

  void initCache() {
    for (auto i = 0; i < CACHE_BLOCK_LEN; i++) {
      cache.line[i].valid       = 0b0;
      cache.line[i].tag         = 0b0;
      cache.line[i].data        = 0b0;
    }
  }

  inline auto getBlockAddress(addr_t byte_addr) {
    return (byte_addr.to_ullong() / BYTES_PER_BLOCK);
  }

  inline auto getCacheIndex(addr_t byte_addr) {
    return (getBlockAddress(byte_addr) % CACHE_BLOCK_LEN);
  }

  inline auto getTag(addr_t byte_addr) {
    return (getBlockAddress(byte_addr) / CACHE_BLOCK_LEN);
  }

  public:
  void showRam() {
    for (auto i = 0; i < RAM_LEN; i++) {
      std::cout << i << ":" << ram[i] << std::endl;
    }
  }
  void showCache() {
    for (auto i = 0; i < CACHE_BLOCK_LEN; i++) {
      std::cout << i << ":";
      std::cout << cache.line[i].valid << ':';
      std::cout << cache.line[i].tag   << ':';
      std::cout << cache.line[i].data  << std::endl;
    }
  }

  auto operate(addr_t byte_addr, data_t data, bool wr, bool &hit) {
    hit = false;

    auto blockAddr = getBlockAddress(byte_addr);
    std::cout << "BlockAddress:" << blockAddr << std::endl;

    auto cacheIdx = getCacheIndex(byte_addr);
    std::cout << "CacheIdx:" << cacheIdx << std::endl;

    auto tag = getTag(byte_addr);
    std::cout << "Tag:" << tag << std::endl;

    auto valid = cache.line[cacheIdx].valid;

    auto &cl = cache.line[cacheIdx];
    if (wr) {
      ram[blockAddr]     = data;

      cl.data            = data;
      cl.tag             = tag;
      cl.valid           = 0b1;
    } else /* read */ {
      if (valid == 0b1 && tag == cl.tag.to_ullong()) {
        hit = true;
      } else {
        cl.tag   = tag;
        cl.valid = 0b1;
        cl.data  = ram[blockAddr];
    }
  }

  return cl.data;
  }

  Cache() {
    std::cout << "BYTE_ADDRESS_LEN:"<< BYTE_ADDRESS_LEN
      << " CACHE_BLOCK_LEN:" << CACHE_BLOCK_LEN << std::endl
      << "BYTES_PER_BLOCK:" << BYTES_PER_BLOCK
      << " BLOCK_ADDRESS_LEN:" << BLOCK_ADDRESS_LEN << std::endl
      << " TAG_LEN:" << TAG_LEN << std::endl;
    initRam();
    initCache();
    showCache();
  }
};
int main() {
  bool hit;
  Cache cache;
  data_t data = 0xdeadbeaf;

  //cache.operate(8, data, true, hit);
  for (auto i = 0; i < 8; i++) {
    std::cout << i << ":";
    cache.operate(i*4, data, false, hit);
    std::cout << "hit:" << hit << std::endl << std::endl;
  }

  for (auto i = 0; i < 8; i++) {
    std::cout << i << ":";
    cache.operate(i*4, data, false, hit);
    std::cout << "hit:" << hit << std::endl << std::endl;
  }

  cache.showCache();
  //cache.showRam();
  return 0;
}
