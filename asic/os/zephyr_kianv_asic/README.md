# KianV Zephyr Port

Out-of-tree Zephyr port for the KianV RV32IMA ASIC SoC.

## Hardware Model

- ISA: RV32IMA plus Zicsr/Zifencei
- CPU clock: 30 MHz
- Timer (`mtime`) clock: 10 kHz, set by the boot loader (`UART_DIV[31:16] = CPU_FREQ / 10000`)
- UART baudrate: 115,200 baud
- RAM/PSRAM: 8 MiB at `0x80000000`
- SPI NOR flash window: `0x20000000`, reset/XIP bootloader at `0x20100000`
- Zephyr flash payload: `0x20110000`, copied to RAM at `0x80000000`
- MicroPython XIP payload: `0x20300000`
- UART: KianV polling UART at `0x10000000`
- PLIC: disabled for this Zephyr board
- UART shell: Zephyr serial shell in polling mode, no UART IRQ/PLIC dependency
- CLINT/mtime: `mtime` at `0x1100bff8`, `mtimecmp` at `0x11004000`
- poweroff/reboot syscon: `0x11100000`, values `0x5555` and `0x7777`

## Build

Default paths use a local Python virtual environment under `.venv/`, a local
Zephyr workspace under `zephyrproject/`, and a local RV32IMA bare-metal
toolchain under `toolchain/riscv32ima`.

```sh
cd asic/os/zephyr_kianv_asic
make
```

`make` builds a local Docker image, then runs the firmware build inside that
container. The container uses Ubuntu's `riscv64-unknown-elf` toolchain, which
can emit RV32IMA code, and avoids building `riscv-gnu-toolchain` from source.
The build creates the local Python environment if it is missing, fetches Zephyr
with `west`, installs Zephyr's base Python requirements, fetches the KianV
MicroPython port, then builds the dual-boot firmware image.

Build only Zephyr or the toolchain:

```sh
make zephyr-fetch
make docker-image
```

The Docker build writes all generated files into the project directory:
`.venv/`, `zephyrproject/`, `micropython/`, and `build-docker/`.

Build without Docker, using the old source-built RV32IMA toolchain path:

```sh
make native-build
make toolchain-version
```

Build with an already installed toolchain:

```sh
make build-no-toolchain
```

The multiboot image contains:

- bootloader menu at flash offset `0x100000`
- Zephyr at flash offset `0x110000`
- MicroPython at flash offset `0x300000`

The bootloader menu accepts `z` for Zephyr and `m` for MicroPython.

The raw 8 MiB NOR image is written to
`build-docker/firmware_dualboot_nor_8m.bin` when building with Docker.
If your programmer writes at NOR offset `0x100000`, use
`build-docker/firmware_dualboot_nor_payload.bin`.

## Clock And UART Rate

The ASIC firmware is configured for a 30 MHz SoC clock and 115,200 baud UART.
The bootloader programs the UART divisor before starting Zephyr or
MicroPython.

Bootloader defaults are in `Makefile`:

```make
CPU_FREQ ?= 30000000
BAUDRATE ?= 115200
```

They can be overridden at build time:

```sh
make build-no-toolchain CPU_FREQ=30000000 BAUDRATE=115200
```

Zephyr's SoC and device-tree clock values are in
`dts/riscv/kianv/kianv_rv32ima.dtsi`:

```dts
timebase-frequency = <10000>;     /* cpus: mtime rate */
clock-frequency = <30000000>;     /* cpu0 and uart0 */
current-speed = <115200>;
```

The matching Zephyr kernel cycle rate (the `mtime` rate, not the CPU clock) is in
`soc/kianv/kianv_rv32ima/Kconfig.defconfig`:

```kconfig
config SYS_CLOCK_HW_CYCLES_PER_SEC
	default 10000
```

## Zephyr Shell

The Zephyr image starts the stock UART shell backend in polling mode and
enables the built-in kernel, device, devmem, date, and filesystem shell
commands. Local code provides the KianV board/SOC description, polling UART
driver, and RAM disk mount at `/RAM`.

Useful commands:

```text
help
kernel version
kernel uptime -p
device list
fs ls /
fs ls /RAM
fs write /RAM/test.txt 68 65 6c 6c 6f 0a
fs read /RAM/test.txt
```

If you use a different Zephyr checkout:

```sh
make ZEPHYR_BASE=/path/to/zephyr
```
