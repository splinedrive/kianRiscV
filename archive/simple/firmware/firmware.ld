MEMORY
{
/*  ram      (rwx) : ORIGIN = 0x00000000, LENGTH = 0x00018000 */
   ram      (rwx) : ORIGIN = 0x00000000, LENGTH = 8192 
 
}
__stacktop = ORIGIN(ram) + LENGTH(ram);

SECTIONS {
	.memory : {
		. = 0x000000;
		*(.init);
		*(.text);
		*(*);
		. = ALIGN(4);
		end = .;
	} >ram
}

