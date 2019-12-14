module uart_rx
	#(parameter CLKS_PER_BIT)
	(
	input				i_clk,
	input 			i_rx_serial;
	output			o_rx_dv;
	output [7:0]	o_rx_byte;
	);
endmodule