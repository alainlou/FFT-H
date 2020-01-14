module FFT (
  input clk,
  input rst,
  input uart_rxd,
  output l1);
  
  wire [7:0] twiddle;
  wire [7:0] data[0:1];
  wire [7:0] transformx;
  wire [7:0] transformy;
    
  uart_rx #(.TICKS_PER_BIT(128)) receiver (
    clk, uart_rxd, l1, data);
  
  butterfly b0 (
    clk, twiddle, data[0], data[1], transform, transform);
  
endmodule