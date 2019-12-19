module uart_rx
    #(parameter CLK_TICKSPER_BIT)
    (
    input        i_clk,
    input        i_rx_serial;
    output       o_rx_flag;
    output [7:0] o_rx_byte;
    );
    
    parameter s_IDLE  = 3'b000;
    parameter s_START = 3'b000;
    parameter s_DATA  = 3'b000;
    parameter s_STOP  = 3'b000;
    parameter s_DONE  = 3'b000;
    
    reg r_data_r = 1'b1;
    reg r_data   = 1'b1;
    
    reg [7:0] r_clk_count   = 0;
    reg [2:0] r_write_idx   = 0;
    reg [7:0] r_byte        = 0;
    reg       r_rx_flag     = 0;
    reg [2:0] r_state       = 0;
    
    // Double-register the data
    always @(posedge i_clk)
      begin
        r_data_r <= i_rx_serial;
        r_data   <= r_rx_data_r;
      end
    
    // Main state machine
    always @(posedge i_clk)
      begin
        case (r_state)
          s_IDLE:
            begin
              r_rx_flag   <= 1'b0;
              r_clk_count <= 0;
              r_write_idx <= 0;
            
              if (r_data == 1'b0)
                r_state <= s_START;
              else
                r_state <= s_IDLE;
            end
            
          s_START:
            begin
            end
          
          default:
            r_state <= s_IDLE
        endcase
      end
    
    assign o_rx_flag = r_rx_flag;
    assign o_rx_byte = r_rx_byte;
endmodule
