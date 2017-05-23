// $Id: $
// File name:   adder_4bit.sv
// Created:     1/21/2015
// Author:      Parneet Kaur Ahuja
// Lab Section: 01
// Version:     1.0  Initial Design Entry
// Description: 4 bit adder.
module adder_4bit
(
	input wire [3:0] a,
	input wire [3:0] b,
	input wire carry_in,
	output wire [3:0] sum,
	output wire overflow
);
wire [4:0] carrys;
genvar i;
assign carrys[0] = carry_in;
generate
  for(i = 0; i <= 3; i = i + 1)
  begin
    adder_1bit Ii (.a(a[i]), .b(b[i]), .carry_in(carrys[i]), .sum(sum[i]), .carry_out(carrys[i+1]));
  end
endgenerate
assign overflow = carrys[4];
endmodule