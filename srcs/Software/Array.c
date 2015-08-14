#include "xparameters.h"
#include "Controller.h"

/* Define base memory locations */
#define SW_BASE XPAR_CONTROLLER_0_S00_AXI_BASEADDR
#define CLK CONTROLLER_S00_AXI_SLV_REG0_OFFSET
#define OP_CODE CONTROLLER_S00_AXI_SLV_REG1_OFFSET
#define ADR_X CONTROLLER_S00_AXI_SLV_REG2_OFFSET
#define ADR_Y CONTROLLER_S00_AXI_SLV_REG3_OFFSET
#define VALI CONTROLLER_S00_AXI_SLV_REG4_OFFSET
#define VALO CONTROLLER_S00_AXI_SLV_REG5_OFFSET
#define WRITTEN CONTROLLER_S00_AXI_SLV_REG6_OFFSET

void write(u32 x, u32 y, u32 vali);
void delay();
void glider(u32 xpos, u32 ypos);
void gun();

void setup()
{


	glider(0,0);
	glider(10,0);
	glider(0,10);
	glider(10,10);



	/*int i,j;
	for (i=0;i<16;i++)
		for (j=0;j<16;j++)
				write(i,j,1);

	*/
}

int main(void)
{
	CONTROLLER_mWriteReg(SW_BASE,OP_CODE,4); // reset
	delay();

	setup();


	delay();

	CONTROLLER_mWriteReg(SW_BASE,OP_CODE,1);

	while(1)
	{
	}
}

void write(u32 x, u32 y, u32 vali)
{
	CONTROLLER_mWriteReg(SW_BASE,VALI,vali);
	CONTROLLER_mWriteReg(SW_BASE,ADR_X,x);
	CONTROLLER_mWriteReg(SW_BASE,ADR_Y,y);
	CONTROLLER_mWriteReg(SW_BASE,OP_CODE,3);
	delay();
	u32 written = CONTROLLER_mReadReg(SW_BASE,WRITTEN);
	while(written == 0) written = CONTROLLER_mReadReg(SW_BASE,WRITTEN);

	CONTROLLER_mWriteReg(SW_BASE,OP_CODE,2);
}

void delay()
{
	u32 clk = CONTROLLER_mReadReg(SW_BASE,CLK);
	if(clk == 0) while (clk == 0) clk = CONTROLLER_mReadReg(SW_BASE,CLK);
	while(clk == 1) clk = CONTROLLER_mReadReg(SW_BASE,CLK);
}

void glider(u32 xpos, u32 ypos)
{
	write(xpos+2,ypos,1);
	write(xpos+2,ypos+1,1);
	write(xpos+2,ypos+2,1);
	write(xpos,ypos+1,1);
	write(xpos+1,ypos+2,1);

}

void gun()
{
	// a
	write(1,5,1);
	write(1,6,1);
	write(2,5,1);
	write(2,6,1);

	// b
	write(11,5,1);
	write(11,6,1);
	write(11,7,1);

	// c
	write(13,3,1);
	write(14,3,1);

	// d
	write(12,4,1);
	write(15,6,1);

	// e
	write(12,8,1);
	write(13,9,1);
	write(14,9,1);

	// f
	write(16,4,1);
	write(17,5,1);
	write(17,6,1);
	write(18,6,1);
	write(17,7,1);

	// g
	write(16,8,1);

	// h
	write(21,3,1);
	write(22,3,1);
	write(23,2,1);

	// i
	write(21,4,1);
	write(21,5,1);
	write(22,4,1);
	write(22,5,1);
	write(23,6,1);

	// j
	write(25,1,1);
	write(25,1,1);

	// k
	write(26,6,1);
	write(25,7,1);

	// l
	write(35,3,1);
	write(35,4,1);
	write(36,3,1);
	write(36,4,1);

}
