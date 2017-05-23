// $Id: $
// File name:   tx_sr.sv
// Created:     2/28/2015
// Author:      Parneet Kaur Ahuja
// Lab Section: 01
// Version:     1.0  Initial Design Entry
// Description: Transmitting Shift register



module tx_sr(
  input wire clk,
  input wire n_rst,
  input wire falling_edge_found,
  input wire tx_enable,
  input wire [7:0] tx_data,
  input wire load_data,
  output reg tx_out
  );
  
  
  defparam FLEX.NUM_BITS = 8;
  defparam FLEX.SHIFT_MSB = 1;
  
  flex_pts_sr FLEX (.clk(clk), .n_rst(n_rst), .shift_enable((falling_edge_found && tx_enable)), .load_enable(load_data), .parallel_in(tx_data), .serial_out(tx_out));
   
 endmodule 
  