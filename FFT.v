module FFT (
  input clk,
  input rst,
  input uart_rxd,
  output reg [35:0] uart_txd
  );
  
  reg [2:0] state = 3'b000;
  reg [41:0] bf1_input = 42'b000000000000000000000000000000000000000000;
  reg [41:0] bf2_input = 42'b000000000000000000000000000000000000000000;
  reg [41:0] bf3_input = 42'b000000000000000000000000000000000000000000;
  reg [41:0] bf4_input = 42'b000000000000000000000000000000000000000000;
  reg [35:0] bf1_buffer = 36'b000001010000000000000000000000000000;
  reg [35:0] bf2_buffer = 36'b000001010000000000000000000000000000;
  reg [35:0] bf3_buffer = 36'b000001010000000000000000000000000000;
  reg [35:0] bf4_buffer = 36'b000001010000000000000000000000000000;
  wire [35:0] bf1_output;
  wire [35:0] bf2_output;
  wire [35:0] bf3_output;
  wire [35:0] bf4_output;
  
  butterfly bf1(bf1_input[41:40], bf1_input[39], bf1_input[38:37], bf1_input[36], bf1_input[35:27], bf1_input[26:18], bf1_input[17:9], bf1_input[8:0], bf1_output[35:27], bf1_output[26:18], bf1_output[17:9], bf1_output[8:0]);
  butterfly bf2(bf2_input[41:40], bf2_input[39], bf2_input[38:37], bf2_input[36], bf2_input[35:27], bf2_input[26:18], bf2_input[17:9], bf2_input[8:0], bf2_output[35:27], bf2_output[26:18], bf2_output[17:9], bf2_output[8:0]);
  butterfly bf3(bf3_input[41:40], bf3_input[39], bf3_input[38:37], bf3_input[36], bf3_input[35:27], bf3_input[26:18], bf3_input[17:9], bf3_input[8:0], bf3_output[35:27], bf3_output[26:18], bf3_output[17:9], bf3_output[8:0]);
  butterfly bf4(bf4_input[41:40], bf4_input[39], bf4_input[38:37], bf4_input[36], bf4_input[35:27], bf4_input[26:18], bf4_input[17:9], bf4_input[8:0], bf4_output[35:27], bf4_output[26:18], bf4_output[17:9], bf4_output[8:0]);
  
  always @(posedge clk) begin
    case (state)
      3'b000: begin
        bf1_input <= 42'b000000000000000000000000000000000000000000;
        bf2_input <= 42'b000000000000000000000000000000000000000000;
        bf3_input <= 42'b000000000000000000000000000000000000000000;
        bf4_input <= 42'b000000000000000000000000000000000000000000;
        bf1_buffer <= 36'b000001010000000000000000000000000000;
        bf2_buffer <= 36'b000001010000000000000000000000000000;
        bf3_buffer <= 36'b000001010000000000000000000000000000;
        bf4_buffer <= 36'b000001010000000000000000000000000000;
        state <= 3'b001;
        end
      3'b001: begin
        bf1_input <= {6'b100000, bf1_buffer};
        bf2_input <= {6'b100000, bf2_buffer};
        bf3_input <= {6'b100000, bf3_buffer};
        bf4_input <= {6'b100000, bf4_buffer};
        state <= 3'b010;
        end
      3'b010: begin
        bf1_input <= {6'b100000, bf1_output[35:18], bf2_output[35:18]};
        bf2_input <= {6'b000101, bf1_output[17:0], bf2_output[17:0]};
        bf3_input <= {6'b100000, bf3_output[35:18], bf4_output[35:18]};
        bf4_input <= {6'b000101, bf3_output[17:0], bf4_output[17:0]};
        state <= 3'b011;
        end
      3'b011: begin
        bf1_input <= {6'b100000, bf1_output[35:18], bf3_output[35:18]}; // 0 and 4
        bf2_input <= {6'b010011, bf2_output[35:18], bf4_output[35:18]}; // 1 and 5
        bf3_input <= {6'b000101, bf1_output[17:0], bf3_output[17:0]};   // 2 and 6
        bf4_input <= {6'b011011, bf2_output[17:0], bf4_output[17:0]};   // 3 and 7
        state <= 3'b111;
        end
      default: begin
        bf1_input <= 42'b000000000000000000000000000000000000000000;
        bf2_input <= 42'b000000000000000000000000000000000000000000;
        bf3_input <= 42'b000000000000000000000000000000000000000000;
        bf4_input <= 42'b000000000000000000000000000000000000000000;
        state <= 3'b001;
      end
    endcase
    bf1_buffer <= bf1_output;
    bf2_buffer <= bf2_output;
    bf3_buffer <= bf3_output;
    bf4_buffer <= bf4_output;
    uart_txd <= bf1_buffer ^ bf2_buffer ^ bf3_buffer ^ bf4_buffer;
  end
  
endmodule