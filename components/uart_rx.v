module uart_rx
    #(parameter TICKS_PER_BIT = 128)
    (
    input        i_clk,
    input        i_rx_serial,
    output       o_rx_flag,
    output [7:0] o_rx_byte
    );
    
    parameter s_IDLE  = 3'b000;
    parameter s_START = 3'b001;
    parameter s_DATA  = 3'b010;
    parameter s_STOP  = 3'b011;
    parameter s_DONE  = 3'b100;
    
    reg r_data_r = 1'b1;
    reg r_data   = 1'b1;
    
    reg [7:0] r_clk_count = 0;
    reg [2:0] r_write_idx = 0;
    reg [7:0] r_byte      = 0;
    reg       r_flag      = 1;
    reg [2:0] r_state     = 0;
    
    // Double-register the data
    always @(posedge i_clk)
      begin
        r_data_r <= i_rx_serial;
        r_data   <= r_data_r;
      end
    
    // Main state machine
    always @(posedge i_clk)
      begin
        case (r_state)
          s_IDLE:
            begin
              r_flag   <= 1'b1;
              r_clk_count <= 0;
              r_write_idx <= 0;
            
              if (r_data == 1'b0)
                r_state <= s_START;
              else
                r_state <= s_IDLE;
            end
            
          s_START:
            begin
              if (r_clk_count == (TICKS_PER_BIT-1)/2)
                begin
                  if (r_data == 1'b0)
                    begin
                      r_clk_count <= 0;
                      r_state <= s_DATA;
                    end
                  else
                    r_state <= s_IDLE;
                end
              else
                begin
                  r_clk_count <= r_clk_count;
                  r_state <= s_START;
                end
            end
          
          s_DATA:
            begin
              if (r_clk_count < TICKS_PER_BIT-1)
                begin
                  r_clk_count <= r_clk_count + 1;
                  r_state = s_DATA;
                end
              else
                begin
                  r_clk_count <= 0;
                  r_byte[r_write_idx] <= r_data;
                  
                  if (r_write_idx < 7)
                    begin
                      r_write_idx <= r_write_idx + 1;
                      r_state <= s_DATA;
                    end
                  else
                    begin
                      r_write_idx = 0;
                      r_state <= s_STOP;
                    end
                end
            end
          
          s_STOP:
            begin
              if (r_clk_count < TICKS_PER_BIT-1)
                begin
                  r_clk_count <= r_clk_count + 1;
                  r_state <= s_STOP;
                end
              else
                begin
                  r_flag <= 1'b0;
                  r_clk_count <= 0;
                  r_state <= s_DONE;
                end
            end
            
            s_DONE:
              begin
                r_flag <= 1'b1;
                r_state <= s_IDLE;
              end
          
          default:
            r_state <= s_IDLE;
        endcase
      end
    
    assign o_rx_flag = r_flag;
    assign o_rx_byte = r_byte;
endmodule
