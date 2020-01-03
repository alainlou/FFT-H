module FFT (
  input clk,
  input rst,
  input uart_rxd,
  output l1);
  
  wire [7:0] data;
    
  uart_rx #(.TICKS_PER_BIT(128)) receiver (
    clk, uart_rxd, l1, data);
  
endmodule