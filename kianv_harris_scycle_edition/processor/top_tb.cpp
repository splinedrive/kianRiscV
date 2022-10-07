#include "Vtop.h"
#include <cstdlib>
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

#define MAX_SIM_TIME 2000
vluint64_t sim_time = 0;

constexpr bool dump = 0;
VerilatedVcdC *m_trace = new VerilatedVcdC;
Vtop *dut;

void tick() {
  dut->clk = 0;
  dut->eval();
  if (dump)
    m_trace->dump(sim_time++);
  dut->clk = 1;
  dut->eval();
  if (dump)
    m_trace->dump(sim_time++);
  dut->clk = 0;
  dut->eval();
  if (dump)
    m_trace->dump(sim_time++);
}

void reset() {
  dut->resetn = 0;
  dut->eval();
  if (dump)
    m_trace->dump(sim_time++);
  tick();
  dut->resetn = 1;
}

int main(int argc, char **argv, char **env) {
  Verilated::traceEverOn(true);
  dut = new Vtop;

  if (dump)
    dut->trace(m_trace, 5);
  if (dump)
    m_trace->open("waveform_verilator.vcd");

  reset();

  while (sim_time < MAX_SIM_TIME) {
    for (;;) {
    dut->clk ^= 1;
    dut->eval();
    if (dump)
      m_trace->dump(sim_time);
    sim_time++;
    }
  }

  if (dump)
    m_trace->close();
  delete dut;
  exit(EXIT_SUCCESS);
}
