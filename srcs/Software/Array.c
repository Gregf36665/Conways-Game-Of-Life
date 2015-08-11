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


int main(void)
{
	while(1)
	{
		CONTROLLER_mWriteReg(SW_BASE,OP_CODE,3);
		CONTROLLER_mWriteReg(SW_BASE,VALI,1);
	}
}