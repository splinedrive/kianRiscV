char spi_rw(char c);
int getCRC16(unsigned char message[], int length);
char spi_cmd(char cmd,char arg0, char arg1, char arg2, char arg3, char crc);
unsigned int spi_r();
int spi_init();
void spi_rb(unsigned int block, unsigned char* buf);
void spi_wb(unsigned int block, unsigned char* buf);
