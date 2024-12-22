# TinyTapeout RISC-V Kianv uLinux SoC

This is the operating system for my TinyTapeout RISC-V Kianv uLinux SoC. The ASIC can boot it and run Linux... Have fun and destroy logic!

## Prerequisites

Before building, ensure the following tools are installed on your system. These tools are essential for working with Buildroot.

Refer to the [Buildroot Manual](https://buildroot.org/downloads/manual/manual.html) for detailed guidance.

### Required Tools
- **GNU Make**: Version 4.0 or later
- **gcc and g++**: A C/C++ compiler
- **binutils**
- **patch**: For applying patches
- **tar, gzip, bzip2, xz, lzip**: For extracting archives
- **wget or curl**: To download files
- **git**: To clone repositories
- **sed**: For text processing
- **perl, python3**: Required for scripts and build system tasks
- **unzip**: For unzipping `.zip` files
- **rsync**: For file synchronization

### Installing Tools on Common Linux Distributions

#### **Ubuntu/Debian**
```bash
sudo apt update
sudo apt install build-essential gcc g++ binutils patch tar gzip bzip2 xz-utils lzip wget curl git sed perl python3 unzip rsync


## Usage Instructions

1. Simply run `make help`. After the build process, three files will be generated in the base directory:
   - `kianv.dtb`
   - `bootloader.bin`
   - `Image`

2. Flash the generated files to their respective memory offsets:
   - Flash `kianv.dtb` to the **1.5 MiB offset**.
   - Flash `bootloader.bin` to the **1 MiB offset**.
   - Flash `Image` to the **2 MiB offset**.

That's it! Your system is now ready to use.

