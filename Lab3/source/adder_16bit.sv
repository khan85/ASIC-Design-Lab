// 337 TA Provided Lab 2 8-bit adder wrapper file template
// This code serves as a template for the 8-bit adder design wrapper file 
// STUDENT: Replace this message and the above header section with an
// appropriate header based on your other code files
`timescale 1ns / 100ps
module adder_16bit
(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire carry_in,
	output wire [15:0] sum,
	output wire overflow
);

adder_nbit #(16) A0 (.a(a), .b(b), .carry_in(carry_in), .sum(sum), .overflow(overflow));
genvar i;
generate
for(i = 0; i <= 15; i = i + 1)
begin
always @ (a)
  begin
    assert((a[i] == 1'b1) || (a[i] == 1'b0))
  else $error("Input 'a' of component is not a digital logic value");
  end
  always @ (b)
  begin
    assert((b[i] == 1'b1) || (b[i] == 1'b0))
  else $error("Input 'b' of component is not a digital logic value");
  end
  always @ (carry_in)
  begin
    assert((carry_in == 1'b1) || (carry_in == 1'b0))
  else $error("Input 'carry_in' of component is not a digital logic value");
  end
   
   
  end
endgenerate
  
   always @ (a,b,carry_in)
    begin
    #(2) assert(((a + b + carry_in)) == sum)
    else $error("Output 's' of first n bit adder is not correct");
    end
  
	// STUDENT: Fill in the correct port map with parameter override syntax for using your n-bit ripple carry adder design to be an 8-bit ripple carry adder design
endmodule
