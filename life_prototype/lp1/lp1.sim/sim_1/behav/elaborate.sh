#!/bin/sh -f
xv_path="/opt/Xilinx/Vivado/2015.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto 986cee26412f48769b0cc25f3e5548e7 -m64 --debug typical --relax --mt 8 --include "../../../../" -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot pe_array_bench_behav xil_defaultlib.pe_array_bench xil_defaultlib.glbl -log elaborate.log
