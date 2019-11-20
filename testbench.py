import cocotb
from cocotb.triggers import Timer

@cocotb.test()
def dff_test(dut):
    dut._log.info("Running dff_test")
    for cycle in range(10):
        dut.clk = 0
        yield Timer(1000, units='ms')
        dut.clk = 1
        yield Timer(1000, units='ms')
    dut._log.info("Finished dff_test")
