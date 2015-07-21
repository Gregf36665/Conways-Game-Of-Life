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
ExecStep $xv_path/bin/xsim pe_array_bench_behav -key {Behavioral:sim_1:Functional:pe_array_bench} -tclbatch pe_array_bench.tcl -log simulate.log
