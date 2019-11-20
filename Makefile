VERILOG_SOURCES = $(PWD)/dff.v
# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file:
TOPLEVEL=dff
# MODULE is the name of the Python test file:
MODULE=testbench
# Use the icarus simulator
SIM=icarus

include $(shell cocotb-config --makefiles)/Makefile.inc
include $(shell cocotb-config --makefiles)/Makefile.sim