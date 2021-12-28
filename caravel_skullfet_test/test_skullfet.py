import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Edge, First, RisingEdge, ClockCycles, with_timeout

TEST_RESULT_PASS = 0x1 # Should be in sync with skullfet_test.c 

@cocotb.test()
async def test_logic(dut):
    clock = Clock(dut.clk, 25, units="ns") # 40M
    cocotb.fork(clock.start())
    
    dut.RSTB <= 0
    dut.power1 <= 0
    dut.power2 <= 0
    dut.power3 <= 0
    dut.power4 <= 0

    await ClockCycles(dut.clk, 8)
    dut.power1 <= 1
    await ClockCycles(dut.clk, 8)
    dut.power2 <= 1
    await ClockCycles(dut.clk, 8)
    dut.power3 <= 1
    await ClockCycles(dut.clk, 8)
    dut.power4 <= 1

    await ClockCycles(dut.clk, 80)
    dut.RSTB <= 1

    # wait with a timeout for the project to become active
    await with_timeout(RisingEdge(dut.uut.mprj.wrapped_skullfet_5.active), 180, 'us')

    # Test the inverter through the GPIO
    dut.inverter_in.value = 1
    await ClockCycles(dut.clk, 1)
    assert dut.inverter_out.value == 0

    dut.inverter_in.value = 0
    await ClockCycles(dut.clk, 1)
    assert dut.inverter_out.value == 1

    # Wait for C test code to finish running
    await First(Edge(dut.c_test_result), ClockCycles(dut.clk, 12000))

    # let the C code check the logic analyzer
    #assert int(dut.c_test_result) == TEST_RESULT_PASS

