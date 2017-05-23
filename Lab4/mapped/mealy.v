
module mealy ( clk, n_rst, i, o );
  input clk, n_rst, i;
  output o;
  wire   n9, n10, n11;
  wire   [1:0] state;
  wire   [1:0] nxtstate;

  DFFSR \state_reg[0]  ( .D(nxtstate[0]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[0]) );
  DFFSR \state_reg[1]  ( .D(nxtstate[1]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        state[1]) );
  INVX1 U14 ( .A(n9), .Y(o) );
  MUX2X1 U15 ( .B(n10), .A(state[0]), .S(state[1]), .Y(nxtstate[1]) );
  NAND2X1 U16 ( .A(state[0]), .B(i), .Y(n10) );
  OAI21X1 U17 ( .A(state[0]), .B(n11), .C(n9), .Y(nxtstate[0]) );
  NAND3X1 U18 ( .A(state[0]), .B(i), .C(state[1]), .Y(n9) );
  XNOR2X1 U19 ( .A(i), .B(state[1]), .Y(n11) );
endmodule
