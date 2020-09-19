module multiply
  (
  input signed [8:0]      i_factor,
  input [1:0]             i_mag,
  input wire              i_neg,
  output reg signed [8:0] o_res
  );
  
  wire signed [8:0] w_abs = i_factor[8] ? -i_factor : i_factor;
  
  // We only expect i_mag to be 0, 1, 2 (0, 0.707, 1)
  always @(*) begin
    case (i_mag)
      2'b00:
        o_res = 9'b000000000;
      2'b01:
        o_res = i_neg^i_factor[8] ? -({2'b00, w_abs[7:1]} + {4'b0000, w_abs[7: 3]} + {5'b00000, w_abs[7: 4]} + {7'b0000000, w_abs[7:6]} + {8'b00000000, w_abs[7]})
                       : {2'b00, w_abs[7:1]} + {4'b0000, w_abs[7: 3]} + {5'b00000, w_abs[7: 4]} + {7'b0000000, w_abs[7:6]} + {8'b00000000, w_abs[7]};
      default:
        o_res = i_neg ? -i_factor : i_factor;
    endcase
  end
endmodule