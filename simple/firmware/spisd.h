// https://www.fatalerrors.org/a/sd-card-initialization-and-command-details.html
// adapted for kianRiscV 2021 by Hirosh Dabui
#ifndef __SPISD_H_
#define __SPISD_H_

#include "kianv_spi_bitbang.h"
//#include "spi.h"
//#include "delay.h"
//#include "common.h"
//#include "ioremap.h"

typedef uint8_t  u8;
typedef uint16_t u16;
typedef uint32_t u32;

// Definition of SD card type  
#define SD_TYPE_ERR     0X00
#define SD_TYPE_MMC     0X01
#define SD_TYPE_V1      0X02
#define SD_TYPE_V2      0X04
#define SD_TYPE_V2HC    0X06	

// SD card instruction list  	   

#define CMD0    0 // card reset
#define CMD1    1
#define CMD8    8 // command 8, SEND_IF_COND
#define CMD9    9 // command 9, read CSD data
#define CMD10   10 // command 10, read CID data
#define CMD12   12 // command 12, stop data transmission
#define CMD16   16 // command 16, setting SectorSize should return 0x00
#define CMD17   17 // command 18, read sector
#define CMD18   18 // command 18, read Multi sector
#define CMD23   23 // command 23. Set N block to be erased before writing multiple sections
#define CMD24   24 // command 24, write section
#define CMD25   25 // command 25, write Multi sector
#define CMD41   41 // command 41, should return 0x00
#define CMD55   55 // command 55, return 0x01
#define CMD58   58 // command 58, read OCR information
#define CMD59   59 // command 59, enable / disable CRC, return 0x00

// There are many kinds of responses in SD card. R1 is the standard response, which is most commonly used. Similar to R1 response are R1b, R2 and R3.
// R1 response in addition to send_ Other commands except status are sent later, and the highest bit is sent first, with a total of 1 byte. The highest bit is 0. The response is described as follows:
// 0x01: idle state
// 0x02: erase error
// 0x04: command error
// 0x08: CRC communication error
// 0x10: erase order error
// 0x20: address error
// 0x40: parameter error

#define MSD_RESPONSE_NO_ERROR      0x00    //no error
#define MSD_IN_IDLE_STATE          0x01    //idle state
#define MSD_ERASE_RESET            0x02    //erase error
#define MSD_ILLEGAL_COMMAND        0x04    //command error
#define MSD_COM_CRC_ERROR          0x08    //CRC communication error
#define MSD_ERASE_SEQUENCE_ERROR   0x10    //erase order error
#define MSD_ADDRESS_ERROR          0x20    //address error
#define MSD_PARAMETER_ERROR        0x40    //parameter error
#define MSD_RESPONSE_FAILURE       0xFF    //the command failed at all and there was no response

void Spi1Init() {
  spi_init();
}

#define SPI_SPEED_4   0
#define SPI_SPEED_256 1
u8 Spi1ReadWriteByte(u8 data) {
  return spi_send(data);
}

void Spi1SetSpeed(u8 speed) {
  if (SPI_SPEED_4) {
  } else {
  }
} 

u8 SdInitialize(void);

u8 SdGetCID(u8 *cid_data);

u8 SdGetCSD(u8 *csd_data);

u32 SdGetSectorCount(void);

u8 SdReadDisk(u8*buf,u32 sector,u8 cnt);

u8 SdWriteDisk(u8*buf,u32 sector,u8 cnt);


#endif
