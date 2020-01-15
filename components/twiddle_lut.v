module twiddle_lut 
  (
  input             [2:0] i_idx,
  output reg signed [7:0] o_factor_re,
  output reg signed [7:0] o_factor_im
  );
  
  // (Approximate by multiplying by 10)
  // 1.0 -0.0
  // 0.7071067811865476 -0.7071067811865475
  // 6.123233995736766e-17 -1.0
  // -0.7071067811865475 -0.7071067811865476
  
  always @(*)
  begin
    case (i_idx)
        3'b000: 
          begin
            o_factor_re <= 10;
            o_factor_im <= 0;
          end
        3'b001: 
          begin
            o_factor_re <= 7;
            o_factor_im <= -7;
          end
        3'b010:
          begin
            o_factor_re <= 0;
            o_factor_im <= -10;
          end
        3'b011:
          begin
            o_factor_re <= -7;
            o_factor_im <= -7;
          end
        3'b100: 
          begin
            o_factor_re <= -10;
            o_factor_im <= 0;
          end
        3'b101: 
          begin
            o_factor_re <= -7;
            o_factor_im <= 7;
          end
        3'b110:
          begin
            o_factor_re <= 0;
            o_factor_im <= 10;
          end
        3'b111:
          begin
            o_factor_re <= 7;
            o_factor_im <= 7;
          end
        default:
          begin
            o_factor_re <= 0;
            o_factor_im <= 0;
          end
    endcase
  end
endmodule