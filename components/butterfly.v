module butterfly
  (
  input unsigned [1:0]  i_w_re_mag,
  input wire            i_w_re_neg,
  input unsigned [1:0]  i_w_im_mag,
  input wire            i_w_im_neg,
  input signed [8:0]    i_xa_re,
  input signed [8:0]    i_xa_im,
  input signed [8:0]    i_xb_re,
  input signed [8:0]    i_xb_im,
  output signed [8:0]   o_ya_re,
  output signed [8:0]   o_ya_im,
  output signed [8:0]   o_yb_re,
  output signed [8:0]   o_yb_im
  );
  
  // http://www.alwayslearn.com/DFT%20and%20FFT%20Tutorial/DFTandFFT_FFT_Butterfly_8_Input.html
  // straight is the horizontal connection of the bottom of the pair
  // cross is the diagonal connection
  wire signed [8:0] re1;
  wire signed [8:0] re2;
  wire signed [8:0] im1;  
  wire signed [8:0] im2;
  
  multiply m0(i_xb_re, i_w_re_mag, i_w_re_neg, re1);
  multiply m1(i_xb_re, i_w_im_mag, i_w_im_neg, im1);
  multiply m2(i_xb_im, i_w_re_mag, i_w_re_neg, im2);
  multiply m3(i_xb_im, i_w_im_mag, i_w_im_neg, re2);
  
  assign o_ya_re = i_xa_re + re1 + re2;
  assign o_ya_im = i_xa_im + im1 + im2;
  assign o_yb_re = i_xa_re - re1 - re2;
  assign o_yb_im = i_xa_im - im1 - im2;
endmodule
  