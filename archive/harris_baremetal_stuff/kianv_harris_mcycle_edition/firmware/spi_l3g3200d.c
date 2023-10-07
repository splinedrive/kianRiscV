#include <stdint.h>
#include "kianv_spi_bitbang.h"

typedef uint8_t u8;
typedef uint32_t u32;

// adapted from waveshare https://www.waveshare.com/wiki/File:L3G4200D-Board-code.7z */
#define	L3G4200_Addr   0xD2	 //定义器件在IIC总线中的从地址,根据ALT  ADDRESS地址引脚不同修改
//**********L3G4200D内部寄存器地址*********
#define WHO_AM_I 0x0F
#define CTRL_REG1 0x20
#define CTRL_REG2 0x21
#define CTRL_REG3 0x22
#define CTRL_REG4 0x23
#define CTRL_REG5 0x24
#define REFERENCE 0x25
#define OUT_TEMP 0x26
#define STATUS_REG 0x27
#define OUT_X_L 0x28|0x80
#define OUT_X_H 0x29
#define OUT_Y_L 0x2A
#define OUT_Y_H 0x2B
#define OUT_Z_L 0x2C
#define OUT_Z_H 0x2D
#define FIFO_CTRL_REG 0x2E
#define FIFO_SRC_REG 0x2F
#define INT1_CFG 0x30
#define INT1_SRC 0x31
#define INT1_TSH_XH 0x32
#define INT1_TSH_XL 0x33
#define INT1_TSH_YH 0x34
#define INT1_TSH_YL 0x35
#define INT1_TSH_ZH 0x36
#define INT1_TSH_ZL 0x37
#define INT1_DURATION 0x38


/*******************************************************************************
 * Function Name  : I2C_Configuration
 * Description    : 
 * Input          : None
 * Output         : None
 * Return         : None
 * Attention		 : None
 *******************************************************************************/
void Delay_1ms( u32 nCnt_1ms )
{	
  msleep(nCnt_1ms); 
}

void Delay_1us( u32 nCnt_1ms )
{	
  usleep(nCnt_1ms);
}

/*******************************************************************************
 * Function Name  : I2C_delay
 * Description    : 
 * Input          : None
 * Output         : None
 * Return         : None
 * Attention		 : None
 *******************************************************************************/
static void delay_us(uint16_t cnt)
{
  usleep(cnt);
}

#define CS_Enable  set_spi_cs(false)
#define CS_Disable set_spi_cs(true)

#define SPI2_Send_byte spi_send
static void write_buffer(u8 adr,u8 data)
{


  CS_Enable;	

  SPI2_Send_byte(adr);//地址

  SPI2_Send_byte(data);

  CS_Disable;

}
void write_buffer8(u8 adr, u8 *data,uint8_t f)
{
  uint8_t i;
  CS_Enable;	

  SPI2_Send_byte(adr|0x40);//地址 地址自动加1
  for(i=0;i<f;i++)
    SPI2_Send_byte(data[i]);

  CS_Disable;

}
u8 read_buffer(u8 adr)
{
  u8 temp;
  CS_Enable;	

  temp = SPI2_Send_byte(adr|0x80);//1000 0000读取地址

  temp=SPI2_Send_byte(0);

  CS_Disable;
  return temp;
}
void read_buffer8(u8 adr, u8 *data,uint8_t f)
{
  uint8_t i;
  CS_Enable;	

  SPI2_Send_byte(adr|0xc0);//1100 0000读取地址自动加1
  for(i=0;i<f;i++)
    data[i]=SPI2_Send_byte(0);

  CS_Disable;

}

//************初始化L3G4200D*********************************
void Init_L3G4200D(void)
{ 
  uint8_t data[5]={0xcf,0x01,0x08,0x00,0x02 };
  write_buffer8(CTRL_REG1,data,5);


  // 	write_buffer(CTRL_REG1,0xcf);delay_us(50);
  // 	write_buffer(CTRL_REG2,0x01);delay_us(50);
  // 	write_buffer(CTRL_REG3,0x08);delay_us(50);
  // 	write_buffer(CTRL_REG4,0x00);delay_us(50);
  // 	write_buffer(CTRL_REG5,0x02);delay_us(50);



}
void READ_L3G4200D(float *T_X,float *T_Y,float *T_Z)//
{	 
  uint8_t BUF[6]={0};
  uint8_t fs,c1;
  uint8_t i;
  float s;

  //short T_X,T_Y,T_Z;
  int16_t  buffer[3]={0};

  read_buffer8(OUT_X_L,BUF,6);//读取 x y z 的数据

  fs=read_buffer(CTRL_REG4);//读取 reg4的数据
  c1=read_buffer(CTRL_REG1);  //测试SPI通信有没有成功
  //printf("c1=%d \r\n", c1 );


  /*
     I2C_Read(I2C2,L3G4200_Addr,OUT_X_L,BUF,6);
     I2C_Read(I2C2,L3G4200_Addr,CTRL_REG4,&fs,1);
     */
  switch (fs&0x30)
  {
    case 0x00:s=8.75;break;
    case 0x10:s=17.5;break;
    case 0x20:s=70;break;
    case 0x30:s=70;break;

  }

  //  	printf("\r\n---------\r\n");
  //    printf("x=%d\n",BUF[0] );
  // 		 printf("x=%d\n",BUF[1] );
  // 		 
  // 		 printf("y=%d\n",BUF[2] );
  // 		 printf("y=%d\n",BUF[3] );
  // 		 
  // 		 printf("z=%d\n",BUF[4] );
  // 		 printf("z=%d\n",BUF[5] );
  // 		 	printf("\r\n---------\r\n");


  buffer[0]=((int16_t)BUF[1]<<8)+BUF[0];
  *T_X=(float)(buffer[0])*s/1000;
  //*T_X=*T_X*8.75/1000;
  //printf("x=%d\n", T_X );
  buffer[1]=((int16_t)BUF[3]<<8)+BUF[2];
  *T_Y=(float)(buffer[1])*s/1000;//-100;
  //*T_Y=*T_Y*8.75/1000;
  //printf("y=%d", T_Y );
  buffer[2]=((int16_t)BUF[5]<<8)+BUF[4];
  *T_Z=(float)(buffer[2])*s/1000;//-100;
  //*T_Z=*T_Z*8.75/1000;
  //printf("z=%d\n", T_Z );

  //printf("reg1=%d\n", BUF[0] );
  //printf("\r\n");
}

void data_int(float *between)
{
  uint16_t i;
  float data[100][3]={0};
  for(i=0;i<100;i++)
  { 
    //while(f)
    //{
    READ_L3G4200D(data[i],data[i]+1,data[i]+2);
    //f=0;
    //}
    Delay_1ms(10);
    between[0]+=data[i][0];
    between[1]+=data[i][1];
    between[2]+=data[i][2];
  }
  for(i=0;i<3;i++)
    between[i]=between[i]/100;
}
/* loopback test */
/* for pin adjustments look into kianv_spi_bitbang.h */
void main() {
  float bet[3]={0};
  float xyz[3]={0};
  float angle_x=0,angle_y=0,angle_z=0;
  spi_init();
  set_spi_cs(false);
  Init_L3G4200D();
  printf("spi bitbanging kianRiscV\n");

  uint8_t tx;

  data_int(bet);

  printf("bet0=%f rad/s\r\n",bet[0]); // xyz[x]hi角速度。
  printf("bet1=%f rad/s\r\n",bet[1]);
  printf("bet2=%f rad/s\r\n",bet[2]);	


  printf("\r\n*************************************************\r\n");
#define FLOAT_TO_INT(x) ((int)(x)>=0.0f?(int)((x)+0.5f):(int)((x)-0.5f))
  for (;;) {


    READ_L3G4200D(xyz,xyz+1,xyz+2);

    xyz[0]=(int)(xyz[0]-bet[0]); 
    xyz[1]=(int)(xyz[1]-bet[1]); //
    xyz[2]=(int)(xyz[2]-bet[2]);

    xyz[0]=(int)(xyz[0]); 
    xyz[1]=(int)(xyz[1]); 
    xyz[2]=(int)(xyz[2]); 

    xyz[0]/=100;
    xyz[1]/=100;
    xyz[2]/=100;
    angle_x=(xyz[0])+angle_x;  if(angle_x>=360)angle_x-=360;
    angle_y=(xyz[1])+angle_y;  if(angle_y>=360)angle_y-=360;
    angle_z=(xyz[2])+angle_z;  if(angle_z>=360)angle_z-=360;
    printf("\n******  L3G4200D  ******\n");

    printf("x=%d rad/s\n", FLOAT_TO_INT(xyz[0])); // xyz[x]hi角速度。
    printf("y=%d rad/s\n", FLOAT_TO_INT(xyz[1]));
    printf("z=%d rad/s\n", FLOAT_TO_INT(xyz[2]));	

    printf("angle_x=%d Degree\n", FLOAT_TO_INT(angle_x)); //angle_x 是角度。
    printf("angle_y=%d Degree\n", FLOAT_TO_INT(angle_y));
    printf("angle_z=%d Degree\n", FLOAT_TO_INT(angle_z));
    msleep(100);
  }
}
