module FFT (
  input clk,
  input rst,
  input s1,
  output l1);
  
  wire [7:0] data;
    
  uart_rx #(.TICKS_PER_BIT(128)) receiver (
    clk, s1, l1, data);
    
endmodule