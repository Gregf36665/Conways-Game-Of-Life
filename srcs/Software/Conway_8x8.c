#include "Controller_4x4.h"
#include "xparameters.h"

/* Define the base memory addresses of the controller
 * Note:
 * Reg 0 : value to write (16 bits)
 * Reg 1 : position to write (2 bits)
 * Reg 2 : write enable (1 bit)
 * Reg 3 : clk input (1 bit, read only)
 */
// Base address of registers
#define BASE XPAR_CONTROLLER_4X4_0_S00_AXI_BASEADDR

#define VAL CONTROLLER_4X4_S00_AXI_SLV_REG0_OFFSET
#define POS CONTROLLER_4X4_S00_AXI_SLV_REG1_OFFSET
#define WRITE CONTROLLER_4X4_S00_AXI_SLV_REG2_OFFSET
#define CLK CONTROLLER_4X4_S00_AXI_SLV_REG3_OFFSET

u16 val = 0x0070;
u32 pos = 0b00;
u32 write = 1;
u32 clk = 0;

void writeout(u16 val, u32 pos);
void delay();

int main(void){

	while(1){
		// enter loop
		loop:
			switch(pos){
				case 0b00: val = 0X6E88; break;
				case 0b01: val = 0x0000; break;
				case 0b10: val = 0x0886; break;
				case 0b11: val = 0x033E; break;
				default: val = 0x0000; break;
			}
			writeout(val,pos);
			pos += 1;
			if (pos == 4) goto done;
			else goto loop;
		done:
			pos = 0;
	}




	return 1;
}



/**
 * Waits for the negative edge of the clock
 */
void delay(){
	clk = CONTROLLER_4X4_mReadReg(BASE,CLK);
	if(clk == 0) while (clk == 0) clk = CONTROLLER_4X4_mReadReg(BASE,CLK);
	while (clk==1){
		clk = CONTROLLER_4X4_mReadReg(BASE,CLK);
	}
	// negative edge
}

/**
 * Update the value of the position and value registers
 * Note this pulses the write out pin
 */
void writeout(u16 val, u32 pos){
	CONTROLLER_4X4_mWriteReg(BASE,VAL,val);
	CONTROLLER_4X4_mWriteReg(BASE,POS,pos);
	CONTROLLER_4X4_mWriteReg(BASE,WRITE,1);
	delay();
	CONTROLLER_4X4_mWriteReg(BASE,WRITE,0);
	return;
}
