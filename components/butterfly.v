module butterfly
  #(parameter WIDTH = 8)
  (
  input                     i_clk,
  input signed [WIDTH-1:0]  i_w,
  input signed [WIDTH-1:0]  i_xa,
  input signed [WIDTH-1:0]  i_xb,
  output signed [WIDTH-1:0] o_y,
  output signed             done
  );
  
  parameter s_IDLE    = 1'b0;
  parameter s_PROCESS = 1'b1;
  
  always @(posedge i_clk)
    begin
    end
endmodule
  