module FFT (
  input clk,
  input rst,
  input uart_rxd,
  output uart_txd,
  output l1
  );
  
  wire [2:0] twiddle_idx;
  wire [7:0] twiddle_re;
  wire [7:0] twiddle_im;
  wire [15:0] data[0:7];
  wire [15:0] transform[0:7];
  
    
  uart_rx #(.TICKS_PER_BIT(128)) receiver (
    clk, uart_rxd, l1, data[0]);
    
  twiddle_lut factors(
    twiddle_idx, twiddle_re, twiddle_im);
  
  butterfly #(.WIDTH(8)) b0 (
    clk, twiddle_re, twiddle_im, data[0], data[1], transform[0], transform[1]);
  
endmodule