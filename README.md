<img src="kianv_linux_soc.jpg" alt="Kianv Soc" width="300"/>
KianV RISC-V Harris Edition (SOC)
RISC-V is an open standard instruction set architecture (ISA) based on 
reduced instruction set computer (RISC) principles. 
After successfully earning my **HarveyMuddX-ENGR85B** certification, 
I acquired the skills to design a hierarchical RISC-V CPU.

In the previous year, I completed an exam on **Building a RISC-V CPU Core**. 
This experience led me to refine my prior RISC-V SOC, the kianv simple edition. 
This initial endeavor was a significant learning curve, crafted through trial and error without simulation. 
It provided invaluable insights into **logical design** thinking.
[kianv simple edition](https://github.com/splinedrive/kianRiscV/tree/master/archive/simple).

<img src="./certificates.png" width="80%" height="80%"/>

Linux SOC
=========
```
 __  __ __               ___ ___ _____   __
|  |/  |__|.---.-.-----.|   |   |     |_|__|.-----.--.--.--.--.
|     <|  ||  _  |     ||   |   |       |  ||     |  |  |_   _|
|__|\__|__||___._|__|__| \_____/|_______|__||__|__|_____|__.__|
```
## KianV RISC-V Linux: Booting Linux like never before!

With KianV RISC-V Linux, booting Linux is not just possible, it's exhilarating. That's right! If you've ever wanted to experience Linux booting in a whole new light, this is your chance.
🔗 Dive deep into the [implementation details here](https://github.com/splinedrive/kianRiscV/blob/master/linux_socs/kianv_harris_mcycle_edition/README.md).
🎥 Or, if you're more of a visual learner, [watch the Kian Linux Soc in action!](https://twitter.com/i/status/1649359364010983424)

CPU
===
The processor supports `RV32IMA` instruction set

* `RV`: RISC-V
* `32`: 32-Bit registers, 3-address instructions
* `I` : integer instructions
* `M` : multiply/divide/modulo instructions
* `A` : atomic instructions (linux)

and passes the RISC-V [unit tests for RISC-V processors](https://github.com/riscv-software-src/riscv-tests).
The cpu is implemented with strong hierarchical method design rules I have learned from **Computer
Architecture RISC-V Edition**, Harris, Harris. As you can see here (taken from my exam documents):
<figure>
<img src="./mc_harris_riscv.png" width="80%" height="80%"
alt="Harris MultiCycle RISC-V"
<figcaption>Harris MultiCycle RISC-V Architecture</figcaption>
</figure>

## **Verilog Implementation Overview**
---

For those keen on delving into the nitty-gritty of my architecture, here's a structured look into the Verilog files detailing its construction:

🔹 **Main Architecture:**
- **kianv_harris_mc_edition.v**

  🔸 **Control Unit:**
  - control_unit.v
    - alu_decoder.v
    - csr_decoder.v
    - divider_decoder.v
    - load_decoder.v
    - main_fsm.v
    - multiplier_decoder.v
    - multiplier_extension_decoder.v
    - store_decoder.v
  
  🔸 **Datapath Unit:**
  - datapath_unit.v
    - alu.v
    - csr_unit.v
    - design_elements.v
    - divider.v
    - extend.v
    - load_alignment.v
    - multiplier.v
    - register_file.v
    - store_alignment.v



## **Register Transfer Logic (RTL) Overview**
---

Get a comprehensive insight into some of the primary CPU components showcased in the RTL of key units: top layer of the CPU, control unit, data unit, and the central finite state machine (FSM).

### **1. Top CPU Layer**
The zenith layer of the CPU encompasses merely a control and a data unit.
<figure>
    <img src="./kianv_harris_mc_edition.png" width="80%" height="80%" alt="Top layer kianv riscv cpu">
    <figcaption>🔷 *Top Layer of the Kianv RISC-V CPU*</figcaption>
</figure>

### **2. Control Unit**
Orchestrating the entire data flow within the CPU, the control unit is a mosaic of a main FSM coupled with a plethora of decoders.
<figure>
    <img src="./control_unit.png" width="80%" height="80%">
    <figcaption>🔷 *Control Unit*</figcaption>
</figure>

### **3. Main FSM**
Sitting at the heart of the control unit, the main FSM steers the chronological succession of the `fetch`, `decode`, `execution`, and `write back` phases.
<figure>
    <img src="./main_fsm.png" width="80%" height="80%">
    <figcaption>🔷 *Main FSM*</figcaption>
</figure>

### **4. Data Unit**
This unit is the bedrock for operations on data and their storage elements.
<figure>
    <img src="./data_unit.png" width="80%" height="80%">
    <figcaption>🔷 *Data Unit*</figcaption>
</figure>



# **FPGA-SoC Implementation**
---

Dive into the comprehensive SoC implementation on various FPGA platforms, featuring an array of controllers and easy-to-follow synthesis steps.

## **1. Integrated Controllers**

Our SoC flaunts a rich set of controllers, including:

- NOR SPI controller
- OLED SPI controller
- PSRAM QSPI controller
- Direct map cache controller
- HDMI framebuffer & VGA controllers
- TX UART controller (up to 3MBaud)
- SPRAM controller (specifically for ice40up)

## **2. Supported FPGA Platforms**

The SoC seamlessly operates on:

- ULX3S ECP5
- Icebreaker ICE40
- Colorlight i5 & i9 (ECP5)
- Icefun ICE40
- Digilent platforms:
  - Arty7
  - Nexys A7
  - Nexys Video
  - Cmod A7-35T
  - Genesys2

## **3. Synthesizing the SoC**

Before initiating synthesis:
- Examine the `defines.vh` file to select system frequency, HDMI/OLED options for ULX3S, PSRAM cache configurations, and more.
- Ensure you have the [oss-cad-suite](https://github.com/YosysHQ/oss-cad-suite-build) for all required synthesis tools.

```bash
# Navigate to the gateware directory
cd gateware
# Build commands for various FPGA platforms:
./build_ulx3s.sh
./build_ice.sh
./build_colori9.sh
./build_colori5.sh
./build_fun.sh
```

## Toolchain

Build the [RISC-V GNU toolchain](https://github.com/riscv/riscv-gnu-toolchain).

To create a RISC-V toolchain for rv32im, invoke the build_toolchain.sh script. Once built, it will reside in the /opt/riscv32im directory.

```bash
cd kianv_harris_mcycle_edition/firmware/
./build_toolchain.sh
```
## Trying Firmware
The firmware will flashed on nor memory!
Firmware:\
```bash
cd ./firmware\
flash with\
./flash_firmware.sh \
ulx3s|ice|colori5|arty7|nexysa7|nexysa_video|genesys2|cmoda7_35t| stick <*.ld> <*.c>

Configuration Files for Different Boot Modes:

spi_nor2bram_fun.ld: Boot from spi-nor on icefun and copy code to BRAM.
spi_nor2bram.ld: Boot from spi-nor on icebreaker and copy code to BRAM.
spi_nor2bram_colori5.ld: Boot from spi-nor on colorlighti5 (and ULX3S) and copy code to BRAM.
spi_nor2spram.ld: Boot from spi-nor on icebreaker and copy to SPRAM.
spi_nor2sram.ld: Boot from spi-nor and copy to SRAM on icoboard.
spi_nor_fun.ld: Boot and execute instructions solely from spi-nor on icefun.
spi_nor.ld: Boot and execute instructions exclusively from spi-nor on all boards, excluding icefun.
spi_nor2spram.d: Boot from spi and copy to SPRAM (exclusively for icebreaker, ice40up).
spi_nor2psram.d: Boot from spi and copy to PSRAM.
spi_nor_ice40hx1k.ld: Boot and execute instructions solely from spi-nor, suitable for platforms like icestick.
Icestick Instructions:

For icestick, try demos like: mandel, raytracer, main_seed.c with OLED or UART.
The firmware is currently limited and will freeze if you interact with hardware registers that aren't implemented.
Icestick can be configured to use either OLED or UART, but not both simultaneously.
Icestick operates in rv32i mode and requires the corresponding rv32i toolchain, which will be chosen in the flash_firmware process.
```
Icestick Demonstration and Configuration Guide:
Demonstrations: Experiment with various demos on Icestick such as mandel, raytracer, and main_seed.c. You can opt for either OLED or UART demonstrations.
Firmware Limitations:
The firmware has some constraints. Specifically, if you try to interact with certain hardware registers not yet implemented, the system will freeze.
Configuration Options:
Icestick can be set up as an SoC (System on Chip) and allows configuration with either an OLED or UART - but not both at the same time.
Toolchain Requirement:
Icestick is set up in the rv32i configuration mode.
For smooth operation, ensure the use of the rv32i toolchain.
The correct toolchain will be automatically chosen during the flash_firmware process.
```
 ./flash_firmware.sh stick spi_nor_ice40hx1k.ld main_raytrace.c -Ofast # would flash firmware for icestick and uses the rv32i firmware
```
Preparing the UART Interface
Several programs rely on an external UART hardware interface for communication. However, it's worth noting that platforms like icebreaker, breakout, and ulx3s have integrated UART solutions and therefore do not require any external UART hardware.

1. Identifying UART Devices:
To identify if your system has detected UART devices, you can search for ttyUSB devices.

2. Configuring UART Devices:
If you've identified a ttyUSB device (where 'x' is the device number, e.g., ttyUSB0, ttyUSB1...), you can set it up using the following commands:

```bash
stty -F /dev/ttyUSBx 11520 raw\
cat /dev/ttyUSBx
```
latest fw version needs no raw mode anymore!
```bash
stty -F /dev/ttyUSBx 11520 \
cat /dev/ttyUSBx
```

to get output like pi.c, main_prime.c, main_rv32m.c, main_rv32m_printf.c, ....

## GPIO Interface
We've incorporated a versatile General-Purpose Input/Output (GPIO) interface across every System-on-Chip (SoC) iteration, enabling direct control of the IOs right from the firmware domain.
Key Features:
Library Support: Within the firmware directory, users will find supportive libraries specifically crafted for i2c and spi communications.
Bitbanging Examples: For hands-on experience, a collection of bitbanging examples have been added. Notable among these are:
I2C Operations: Leveraging I2C protocol, users can operate devices like liquid crystal displays or OLED SSD1306 panels.
SPI Bitbanging: A standout example includes SPI bitbanging functionalities, enabling reading and writing operations on FAT16/32 formatted SD cards. The underlying driver, sourced from 'ultraembedded', has been refined to a single-file implementation, ensuring simplicity without compromising functionality.
Configuration and Expansion: Adjusting or expanding the IO map is straightforward. By referring to the provided .pcf or .lcf files, users can remap existing pins or enhance the IO count up to 32, given the current configuration.

## DMA Controller in KianRiscV
Within the KianRiscV architecture, users have the option to leverage an integrated DMA (Direct Memory Access) Controller. This component is specifically designed to enhance memory operations, particularly speeding up memset and memcpy functions when transferring word-aligned data.

Benefits:

Enhanced Efficiency: Facilitates direct communication between memory and peripherals, bypassing the CPU, to ensure faster and more efficient data transfers.

Optimized for Word-aligned Transfers: Tailored to support word-wise operations, the controller provides optimal throughput and reduces potential fragmentation.

CPU Load Reduction: Offloads memory-centric tasks to the DMA, allowing the primary CPU to focus on other operations, thereby maximizing overall system responsiveness.

Implementing the DMA Controller within the KianRiscV framework offers a robust solution for users aiming to optimize their system's memory operations.

## PMODs
* PSRAM 32MByte: https://machdyne.com/product/qqspi-psram32/

## Xilinx
Check the XilinxVivado folder and
```bash
./build.sh
```
## Kian RiscV: A Single Cycle CPU
Discover the advanced single cycle CPU from Kian RiscV. With a remarkable CPI (Cycles Per Instruction) of 1, it's finely tuned for the KINTEX-7 platform. Nevertheless, its flexible design allows compatibility with smaller FPGAs, simply requiring adjustments in firmware.

Key Features:

Optimized Performance: The CPU boasts a speed of 80MHz, translating to a powerful 80 MIPS (Million Instructions Per Second).
Enhanced Communication: Integrated with a UART operating at an impressive 3,000,000 Baud rate.
Flexible Firmware Build: Easily adaptable with standard BRAM linker scripts and a reset address set at 0.
Integrated Raytracer: Incorporates a hex raytracer sourced from Simple Raytracer in C.
Ready-to-Use Bitstream: A pre-compiled 80MHz bitstream file is available specifically tailored for the genesys2 platform.
Dive into the world of efficient computing with the Kian RiscV Single Cycle CPU.
### Simulation
```bash
cd kianv_harris_scycle_edition/processor/
make verilator && ./obj/Vtop
```
or
```bash
cd kianv_harris_scycle_edition/processor/
make isim && ./a.out
```
<img src="./single_cycle.png" width="80%" height="80%"/>

## Kian RiscV: A 5-Staged Pipelined CPU
Dive into the innovative realm of RISC-V with Kian's 5-staged pipelined CPU. This sophisticated design lays the groundwork for extensive developments in the future.

Key Highlights:

RV32I Compliant: Built in accordance with the RISC-V 32-bit integer instruction set.
Extensively Tested: Validated rigorously using the RISC-V testsuite to ensure impeccable performance and accuracy.
Future-Forward: Plans are in motion to evolve this CPU into a more advanced System-on-Chip (SoC), encompassing:
Interrupt handling mechanisms
SDRAM and DDR integration
Advanced caching systems
State-of-the-art branch prediction
Compatibility for Linux booting
Join us in this journey as we continuously refine and expand the capabilities of the Kian RiscV Pipelined CPU.
<img src="./5pipelined.png" width="80%" height="80%"/>

Hirosh
