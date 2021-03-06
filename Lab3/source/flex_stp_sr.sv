// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/29/2015
// Author:      Parneet Kaur Ahuja
// Lab Section: 01
// Version:     1.0  Initial Design Entry
// Description: serial to parallel shift
module flex_stp_sr
  #(
  parameter NUM_BITS = 4,
  parameter SHIFT_MSB = 1
  )
  (
  input wire clk,
  input wire n_rst,
  input wire shift_enable,
  input wire serial_in,
  output reg [NUM_BITS - 1:0] parallel_out
  );
  reg [NUM_BITS - 1: 0] nxt;
  
  always_ff @ (negedge n_rst, posedge clk)
  begin
    if (n_rst == 1'b0)
      parallel_out[NUM_BITS -1 :0] <= '1;
    else
      parallel_out <= nxt;
    end
  
  
  always_comb
  begin
    nxt = parallel_out;
    if(shift_enable == 1 && SHIFT_MSB == 1)
      begin
        nxt[NUM_BITS - 1:1] = parallel_out[NUM_BITS - 2:0];
        nxt[0] = serial_in;
      end
    else if(shift_enable == 1 && SHIFT_MSB == 0)
      begin
        nxt[NUM_BITS - 2:0] = parallel_out[NUM_BITS - 1:1];
        nxt[NUM_BITS - 1] = serial_in;
      end
    end
  endmodule