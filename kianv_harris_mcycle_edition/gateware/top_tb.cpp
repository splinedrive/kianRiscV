#include <stdlib.h>
#include <cstdlib>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vtop.h"


#define MAX_SIM_TIME 20
vluint64_t sim_time = 0;

constexpr bool dump = 0;
int main(int argc, char** argv, char** env) {
  Vtop *dut = new Vtop;

  Verilated::traceEverOn(true);
  VerilatedVcdC *m_trace = new VerilatedVcdC;
  if (dump) dut->trace(m_trace, 5);
  if (dump) m_trace->open("waveform_verilator.vcd");

  while (sim_time < MAX_SIM_TIME) {
    while ( 1 ) {
      dut->clk_in ^= 1;
      dut->eval();
      if (dump) m_trace->dump(sim_time);
      sim_time++;
    }

    if (dump) m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
  }
}
