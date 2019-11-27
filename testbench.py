import cocotb
from cocotb.result import TestFailure
from cocotb.triggers import Timer

import random

@cocotb.test()
def dff_test(dut):
    dut._log.info("Running dff_test")
    for cycle in range(10):
        dut.clk = 0
        signal = random.randint(0, 1)
        dut.d = signal
        yield Timer(1000, units='ms')
        dut.clk = 1
        yield Timer(1000, units='ms')
        if dut.q != signal:
            raise TestFailure("Didn't work")
    dut._log.info("Finished dff_test")
