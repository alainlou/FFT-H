module butterfly
  #(parameter WIDTH = 8)
  (
  input                     i_clk,
  input                     i_enable,
  input signed [WIDTH-1:0]  i_w_re,
  input signed [WIDTH-1:0]  i_w_im,
  input signed [WIDTH-1:0]  i_xa_re,
  input signed [WIDTH-1:0]  i_xa_im,
  input signed [WIDTH-1:0]  i_xb_re,
  input signed [WIDTH-1:0]  i_xb_im,
  output signed [WIDTH-1:0] o_ya_re,
  output signed [WIDTH-1:0] o_ya_im,
  output signed [WIDTH-1:0] o_yb_re,
  output signed [WIDTH-1:0] o_yb_im
  );
  
  parameter s_IDLE   = 2'b00;
  parameter s_STAGE1 = 2'b01;
  parameter s_STAGE2 = 2'b10;
  parameter s_STAGE3 = 2'b11;
  
  reg signed [WIDTH-1:0] r_tmp_re = 0;
  reg signed [WIDTH-1:0] r_tmp_im = 0;
  reg signed [WIDTH-1:0] r_a_re   = 0;
  reg signed [WIDTH-1:0] r_a_im   = 0;
  reg signed [WIDTH-1:0] r_b_re   = 0;
  reg signed [WIDTH-1:0] r_b_im   = 0;
  reg [1:0] r_state               = 0;
  
  always @(posedge i_clk)
    begin
      case (r_state)
        s_IDLE:
          begin
            if (i_enable)
              r_state <= s_STAGE1;
            else
              r_state <= s_IDLE;
          end
          
        s_STAGE1:
          begin
            r_tmp_re <= (i_w_re * i_xb_re + i_w_im * i_xb_im)/10;
            r_tmp_im <= (i_w_re * i_xb_im + i_w_im * i_xb_re)/10;
            r_state  <= s_STAGE2;
          end
          
        s_STAGE2:
          begin
            r_a_re <= i_xa_re + r_tmp_re;
            r_a_im <= i_xa_im + r_tmp_im;
            r_b_re <= i_xa_re - r_tmp_re;
            r_b_re <= i_xa_re - r_tmp_im;
            r_state <= s_STAGE3;
          end
        
        s_STAGE3:
          begin
            r_state <= s_IDLE;
          end
          
        default:
          r_state <= s_IDLE;
      endcase
    end
  
  assign o_ya_re = r_a_re;
  assign o_ya_im = r_a_im;
  assign o_b_re = r_b_re;
  assign o_b_im = r_b_im;
endmodule
  