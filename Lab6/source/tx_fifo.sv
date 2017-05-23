// $Id: $
// File name:   tx_fifo.sv
// Created:     2/22/2015
// Author:      Parneet Kaur Ahuja
// Lab Section: 01
// Version:     1.0  Initial Design Entry
// Description: fifo
module tx_fifo(
  input wire clk,
  input wire n_rst,
  input wire read_enable,
  input wire write_enable,
  input wire [7:0] write_data,
  output reg [7:0] read_data,
  output reg fifo_empty,
  output reg fifo_full
  );
  
  fifo FI (.r_clk(clk), .w_clk(clk), .n_rst(n_rst), .r_enable(read_enable), .w_enable(write_enable), .r_data(read_data), .w_data(write_data), .empty(fifo_empty), .full(fifo_full));
  
endmodule