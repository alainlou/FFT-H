module butterfly
  #(parameter WIDTH = 8)
  (
  input                     i_clk,
  input                     i_enable,
  input signed [WIDTH-1:0]  i_w,
  input signed [WIDTH-1:0]  i_xa,
  input signed [WIDTH-1:0]  i_xb,
  output signed [WIDTH-1:0] o_ya,
  output signed [WIDTH-1:0] o_yb
  );
  
  parameter s_IDLE  = 2'b00;
  parameter s_PART1 = 2'b01;
  parameter s_PART2 = 2'b10;
  parameter s_PART3 = 2'b11;
  
  reg signed [WIDTH-1:0] r_tmp = 0;
  reg signed [WIDTH-1:0] r_a   = 0;
  reg signed [WIDTH-1:0] r_b   = 0;
  reg [1:0] r_state            = 0;
  
  always @(posedge i_clk)
    begin
      case (r_state)
        s_IDLE:
          begin
            if (i_enable)
              r_state <= s_PART1;
            else
              r_state <= s_IDLE;
          end
          
        s_PART1:
          begin
            r_tmp <= i_w * i_xb;
            r_state <= s_PART2;
          end
          
        s_PART2:
          begin
            r_a <= i_xa + r_tmp;
            r_b <= i_xa - r_tmp;
            r_state <= s_PART3;
          end
        
        s_PART3:
          begin
            r_state <= s_IDLE;
          end
          
        default:
          r_state <= s_IDLE;
      endcase
    end
  
  assign o_ya = r_a;
  assign o_yb = r_b;
endmodule
  