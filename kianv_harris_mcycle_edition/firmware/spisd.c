// https://www.fatalerrors.org/a/sd-card-initialization-and-command-details.html
// adapted for kianRiscV 2021 by Hirosh Dabui

// use a sd card pmod, I have used pmod from digilent
#include "spisd.h"


//Predefined SD card types
u8  SD_Type=0;//Type of SD card

//This part should be modified according to the specific connection!
#define	SD_CS  PAout(4) // SD card pin selection

//Data: data to write
//Return value: data read
static u8 SdSpiReadWriteByte(u8 data)
{
    return Spi1ReadWriteByte(data);
}

//When the SD card is initialized, it needs low speed
static void SdSpiSpeedLow(void)
{
    Spi1SetSpeed(SPI_SPEED_256);//Set to low speed mode for initialization, the maximum spi speed is 400k
}

//When the SD card works normally, it can run at high speed
static void SdSpiSpeedHigh(void)
{
    Spi1SetSpeed(SPI_SPEED_4);//Set to high speed mode after initialization, up to 25M, but generally not used
}


static void SdIOInit(void)
{
  /*
	GPIO_InitTypeDef GPIO_InitStructure;
    RCC_APB2PeriphClockCmd(	RCC_APB2Periph_GPIOA, ENABLE );

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_4;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP ;   //Push pull output
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(GPIOA, &GPIO_InitStructure);//Initialize A4

	SD_CS = 1;
  */
  CS_HIGH;
	Spi1Init();//Initialize SPI interface
	SdSpiSpeedLow();//Initialization set to low speed
}

//Wait for the card to be ready
//Return value: 0, ready; other, error code
static u8 SdWaitReady(void)
{
    u32 t=0;
    do
    {
        if(SdSpiReadWriteByte(0XFF)==0XFF)return 0;//OK
        t++;
    }while(t<0XFFFFFF);//wait for
    return 1;
}

//Deselect and release SPI bus
void SD_DisSelect(void)
{
    //SD_CS=1;
    CS_HIGH;
    SdSpiReadWriteByte(0xff);//Provide an additional 8 clocks
}

//Select the sd card and wait for the card to be ready
//Return value: 0, success; 1, failure;
u8 SdSelect(void)
{
    //SD_CS=0;
    CS_LOW;
    if(SdWaitReady()==0)return 0;//Waiting for success
    SD_DisSelect();
    return 1;//Waiting failed
}

//Waiting for SD card response
//Response: the response value to be obtained
//Return value: 0, the response value was obtained successfully
//    Others, get the response value that failed to expect
u8 SdGetResponse(u8 Response)
{
    u16 Count=0xFFF;//Waiting times
    while ((SdSpiReadWriteByte(0XFF)!=Response)&&Count)Count--;//Waiting for an accurate response
    if (Count==0)return MSD_RESPONSE_FAILURE;//Failed to get response
    else return MSD_RESPONSE_NO_ERROR;//Correct response
}

//Read the contents of a packet from sd card
//buf: data cache
//len: the length of data to read
//Other, success, return value;
//0XFE data initiation token
u8 SdRecvData(u8*buf,u16 len)
{
    if(SdGetResponse(0xFE))return 1;//Wait for SD card to send back data initiation token 0xFE
    while(len--)//Start receiving data
    {
        *buf=SdSpiReadWriteByte(0xFF);
        buf++;
    }
    //Here are two dummy CRC's
    SdSpiReadWriteByte(0xFF);
    SdSpiReadWriteByte(0xFF);
    return 0;//Read successfully
}

//Write 512 bytes of a packet to sd card
//buf: data cache
//cmd: instruction
//Return value: 0, success; others, failure;
u8 SdSendBlock(u8*buf,u8 cmd)
{
    u16 t;
    if(SdWaitReady())return 1;//Waiting for preparation to fail
    SdSpiReadWriteByte(cmd);
    if(cmd!=0XFD)//It's not an end command
    {
        for(t=0;t<512;t++)SdSpiReadWriteByte(buf[t]);//Speed up, reduce time
        SdSpiReadWriteByte(0xFF);//Ignore crc
        SdSpiReadWriteByte(0xFF);
        t=SdSpiReadWriteByte(0xFF);//Receive response
        if((t&0x1F)!=0x05)return 2;//Response error
    }
    return 0;//Write succeeded
}


//Send a command to the SD card
//Input: u8 cmd command
//      u32 arg command parameters
//      U8 CRC CRC CRC check value
//Return value: the response returned by SD card
u8 SdSendCmd(u8 cmd, u32 arg, u8 crc)
{
    u8 r1;
    u8 Retry=0;
    SD_DisSelect();//Cancel last selection
    if(SdSelect())return 0XFF;//Film selection failure
    //send out
    SdSpiReadWriteByte(cmd | 0x40);//Write commands separately
    SdSpiReadWriteByte(arg >> 24);
    SdSpiReadWriteByte(arg >> 16);
    SdSpiReadWriteByte(arg >> 8);
    SdSpiReadWriteByte(arg);
    SdSpiReadWriteByte(crc);
    if(cmd==CMD12)SdSpiReadWriteByte(0xff);//Skip a stuff byte when stop reading
    //Waiting for a response, or timed out
    Retry=0X1F;
    do
    {
        r1=SdSpiReadWriteByte(0xFF);
    }while((r1&0X80) && Retry--);
    //Return status value
    return r1;
}

//Get CID information of SD card, including manufacturer information
//Input: U8 * CID_ Data (memory for CID, at least 16Byte)
//Return value: 0: NO_ERR
//		 1: Error
u8 SdGetCID(u8 *cid_data)
{
    u8 r1;
    //Send the CMD10 command and read CID
    r1=SdSendCmd(CMD10,0,0x01);
    if(r1==0x00)
    {
        r1=SdRecvData(cid_data,16);//Receive 16 bytes of data
    }
    SD_DisSelect();//Cancel selection
    if(r1)return 1;
    else return 0;
}

//Get the CSD information of SD card, including capacity and speed information
//Input: U8 * CID_ Data (memory for CID, at least 16Byte)
//Return value: 0: NO_ERR
//		 1: Error
u8 SdGetCSD(u8 *csd_data)
{
    u8 r1;
    r1=SdSendCmd(CMD9,0,0x01);//Send CMD9 command, read CSD
    if(r1==0)
    {
    	r1=SdRecvData(csd_data, 16);//Receive 16 bytes of data
    }
    SD_DisSelect();//Cancel selection
    if(r1)return 1;
    else return 0;
}

//Get the total number of sectors (sectors) of SD card
//Return value: 0: error in fetching capacity
//Other: capacity of SD card (number of sectors / 512 bytes)
//The number of bytes per sector must be 512, because if it is not 512, initialization cannot pass
u32 SdGetSectorCount(void)
{
    u8 csd[16];
    u32 Capacity;
    u8 n;
    u16 csize;
    //Get the CSD information, if there is an error during the period, return 0
    if(SdGetCSD(csd)!=0) return 0;
    //For SDHC card, calculate as follows
    if((csd[0]&0xC0)==0x40)	 //V2.00 card
    {
        csize = csd[9] + ((u16)csd[8] << 8) + 1;
        Capacity = (u32)csize << 10;//Get the number of sectors
    }else//V1.XX card
    {
        n = (csd[5] & 15) + ((csd[10] & 128) >> 7) + ((csd[9] & 3) << 1) + 2;
        csize = (csd[8] >> 6) + ((u16)csd[7] << 2) + ((u16)(csd[6] & 3) << 10) + 1;
        Capacity= (u32)csize << (n - 9);//Get the number of sectors
    }
    return Capacity;
}


//Initialize SD card
//Return value: 0, normal
//Others, not normal
u8 SdInitialize(void)
{
    u8 r1;      // Store the return value of SD card
    u16 retry;  // Used for timeout counting
    u8 buf[4];
    u16 i;

    SdIOInit();		//Initialize IO
    for(i=0;i<10;i++)SdSpiReadWriteByte(0XFF);//At least 74 pulses are sent, and 80 pulses are sent here
    retry=20;
    do
    {
        r1=SdSendCmd(CMD0,0,0x95);//Enter IDLE state
    }while((r1!=0X01) && retry--);
    SD_Type=0;//Default no card
    if(r1==0X01)
    {
        if(SdSendCmd(CMD8,0x1AA,0x87)==1)//SD V2.0
        {
            for(i=0;i<4;i++)buf[i]=SdSpiReadWriteByte(0XFF);	//Get trailing return value of R7 resp
            if(buf[2]==0X01&&buf[3]==0XAA)//Does the card support 2.7~3.6V
            {
                retry=0XFFFE;
                do
                {
                    SdSendCmd(CMD55,0,0X01);	//Send CMD55
                    r1=SdSendCmd(CMD41,0x40000000,0X01);//Send CMD41
                }while(r1&&retry--);
                if(retry&&SdSendCmd(CMD58,0,0X01)==0)//Identification of SD2.0 card version begins
                {
                    for(i=0;i<4;i++)buf[i]=SdSpiReadWriteByte(0XFF);//Get the OCR value
                    if(buf[0]&0x40)SD_Type=SD_TYPE_V2HC;    //Check CCS
                    else SD_Type=SD_TYPE_V2;
                }
            }
        }else//SD V1.x/ MMC	V3
        {
            SdSendCmd(CMD55,0,0X01);		//Send CMD55
            r1=SdSendCmd(CMD41,0,0X01);	//Send CMD41
            if(r1<=1)
            {
                SD_Type=SD_TYPE_V1;
                retry=0XFFFE;
                do //Wait to exit IDLE mode
                {
                    SdSendCmd(CMD55,0,0X01);	//Send CMD55
                    r1=SdSendCmd(CMD41,0,0X01);//Send CMD41
                }while(r1&&retry--);
            }else
            {
                SD_Type=SD_TYPE_MMC;//MMC V3
                retry=0XFFFE;
                do //Wait to exit IDLE mode
                {
                    r1=SdSendCmd(CMD1,0,0X01);//Send CMD1
                }while(r1&&retry--);
            }
            if(retry==0||SdSendCmd(CMD16,512,0X01)!=0)SD_Type=SD_TYPE_ERR;//Wrong card
        }
    }
    SD_DisSelect();//Cancel selection
    SdSpiSpeedHigh();//high speed
    if(SD_Type)return 0;
    else if(r1)return r1;
    return 0xaa;//Other errors
}



//Read SD card
//buf: data cache
//sector: sector
//cnt: number of sectors
//Return value: 0,ok; other, failed
u8 SdReadDisk(u8*buf,u32 sector,u8 cnt)
{
    u8 r1;
    if(SD_Type!=SD_TYPE_V2HC)sector <<= 9;//Convert to byte address
    if(cnt==1)
    {
        r1=SdSendCmd(CMD17,sector,0X01);//Read the command
        if(r1==0)//The command was sent successfully
        {
            r1=SdRecvData(buf,512);//Receive 512 bytes
        }
    }else
    {
        r1=SdSendCmd(CMD18,sector,0X01);//Continuous read command
        do
        {
            r1=SdRecvData(buf,512);//Receive 512 bytes
            buf+=512;
        }while(--cnt && r1==0);
        SdSendCmd(CMD12,0,0X01);	//Send stop command
    }
    SD_DisSelect();//Cancel selection
    return r1;//
}

//Write SD card
//buf: data cache
//Section: start sector
//cnt: number of sectors
//Return value: 0,ok; other, failed
u8 SdWriteDisk(u8*buf,u32 sector,u8 cnt)
{
    u8 r1;
    if(SD_Type!=SD_TYPE_V2HC)sector *= 512;//Convert to byte address
    if(cnt==1)
    {
        r1=SdSendCmd(CMD24,sector,0X01);//Read the command
        if(r1==0)//The command was sent successfully
        {
            r1=SdSendBlock(buf,0xFE);//Write 512 bytes
        }
    }else
    {
        if(SD_Type!=SD_TYPE_MMC)
        {
            SdSendCmd(CMD55,0,0X01);
            SdSendCmd(CMD23,cnt,0X01);//Send instructions
        }
        r1=SdSendCmd(CMD25,sector,0X01);//Continuous read command
        if(r1==0)
        {
            do
            {
                r1=SdSendBlock(buf,0xFC);//Receive 512 bytes
                buf+=512;
            }while(--cnt && r1==0);
            r1=SdSendBlock(0,0xFD);//Receive 512 bytes
        }
    }
    SD_DisSelect();//Cancel selection
    return r1;//
}


// howmany sectors you want to write
#define SECTORS 100 
void main() {
  SdInitialize();
  uint32_t bytes = SdGetSectorCount();

  u8 buf[512] ="KianRiscV soc stored sector number in sector: ";

  int len = strlen(buf);

  for (;;) {
  for (u32 i = 0; i < SECTORS; i++) {
    buf[len + 0] = (i >> 24);
    buf[len + 1] = (i >> 16);
    buf[len + 2] = (i >> 8);
    buf[len + 3] = (i);

    SdWriteDisk(buf, i, 1);
    printf("written sector done:%d\n", i);
  }
  for (int i = 0; i < SECTORS; i++) {
    SdReadDisk(buf, i, 1);
    printf("Reading data from sector:%d => ", i);
    printf("%s", buf);
    printf("%d\n", (buf[len + 0]<<24) | (buf[len + 1] << 16) | (buf[len + 2] << 8) | buf[len + 3]);
    printf("\n");
  }

    
//    printf("%d\n", gpio_get_input_value(CD_PIN));
  }
}
