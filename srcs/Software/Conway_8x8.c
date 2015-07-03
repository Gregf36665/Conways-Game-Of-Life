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

int main(void){
	// Setup everything
	u32 val = 0xFFFF;
	u32 pos = 0b00;
	u32 write = 1;
	u32 clk = 0;
	CONTROLLER_4X4_mWriteReg(BASE,VAL,val);
	CONTROLLER_4X4_mWriteReg(BASE,POS,pos);
	CONTROLLER_4X4_mWriteReg(BASE,WRITE,write);
	while(1);// enter loop



	return 1;
}
