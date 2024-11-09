# kianv - RISC-V rv32ima
OUTPUT_ARCH("riscv")
ENTRY(_entry)

MEMORY
{
  boot (rwx) : ORIGIN = 0x00000000, LENGTH = 0x00004000
}

PHDRS
{
  text PT_LOAD FLAGS(5);  /* Read and Execute */
  data PT_LOAD FLAGS(6);  /* Read and Write */
}

SECTIONS
{
  .boot :
  {
    _entry = .;                  /* Entry point */
    *(.text);                    /* Code section */
    . = ALIGN(16);
    *(.srodata);                 /* Read-only small data */
    . = ALIGN(16);
    *(.rodata);                  /* Regular read-only data */
    . = ALIGN(16);
    _etext = .;                  /* End of text and rodata sections */

    /* Define .data section in RAM */
    _data_load = LOADADDR(.data); /* Load address of .data */
    _data_start = .;             /* Start of initialized data */
    *(.data);
    . = ALIGN(16);
    _edata = .;                  /* End of initialized data */

    /* Define .bss section in RAM */
    _bss_start = .;              /* Start of uninitialized data */
    *(.sbss);
    . = ALIGN(16);
    *(.bss);
    . = ALIGN(16);
    _ebss = .;                   /* End of uninitialized data */

    /* Define stack top at the end of the boot memory region */
    _stack_top = ORIGIN(boot) + LENGTH(boot); /* Stack top address */
  } > boot : text

  .data : AT(_data_load)        /* Assign data section to data PHDR */
  {
    *(.data);
  } > boot : data

  .bss :                         /* Assign bss section to data PHDR */
  {
    *(.bss);
  } > boot : data
}
