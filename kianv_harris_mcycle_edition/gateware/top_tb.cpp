#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vtop.h"

#define MAX_SIM_TIME 20
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env) {
    Vtop *dut = new Vtop;

    Verilated::traceEverOn(true);
  //  VerilatedVcdC *m_trace = new VerilatedVcdC;
//    dut->trace(m_trace, 5);
 //   m_trace->open("waveform.vcd");

//    while (sim_time < MAX_SIM_TIME) {
    while ( 1 ) {
        dut->clk_in ^= 1;
        dut->eval();
//        m_trace->dump(sim_time);
        sim_time++;
    }

 //   m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
