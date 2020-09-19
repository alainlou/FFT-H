import cocotb
from cocotb.result import TestFailure
from cocotb.triggers import Timer

import random

@cocotb.test()
def butterfly_test(dut):
    dut._log.info("Running butterfly_test")
    dut.b0.clk = 0
    dut._log.info("Finished butterfly_test")