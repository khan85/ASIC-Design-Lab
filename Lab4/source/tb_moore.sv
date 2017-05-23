// $Id: $
// File name:   tb_moore.sv
// Created:     2/7/2015
// Author:      Parneet Kaur Ahuja
// Lab Section: 01
// Version:     1.0  Initial Design Entry
// Description: moore test bench

`timescale 1ns / 10ps

module tb_moore ();

	// Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
	
	// Shared Test Variables
	reg tb_clk;
	
	// Default Config Test Variables & constants
	//localparam DEFAULT_SIZE = 4;
	//localparam DEFAULT_MAX_BIT = (DEFAULT_SIZE - 1);
	//localparam DEFAULT_MSB = 1;
	
	integer tb_default_test_num;
	reg tb_default_n_reset;
	
	reg tb_i;
	reg tb_o;
	
	
	// DUT portmaps
	moore DEFAULT
	(
		.clk(tb_clk),
		.n_rst(tb_default_n_reset),
		.i(tb_i),
		.o(tb_o)
		
	);
	

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	initial
	begin
	  
	  //tb_i = 1;
	  tb_default_n_reset =1;
	  tb_default_test_num = 0;
	  #(CLK_PERIOD);
	  tb_default_n_reset =0;
	   #(CLK_PERIOD);
	  tb_default_n_reset =1;
	  
	  #(CLK_PERIOD);
	 //TESTCASE 1
	 
	 tb_default_test_num = 1;
	  tb_default_n_reset = 0;
	  tb_i = 0;
	  #(CLK_PERIOD);
	  if (1'b0 == tb_o)
			$info("Default Test Case %0d:: PASSED", tb_default_test_num);
		else // Test case failed
			$error("Default Test Case %0d:: FAILED",tb_default_test_num);
	  #(CLK_PERIOD);
	  //TESTCASE 2
	  //@(posedge tb_clk);
	  tb_default_test_num = 2;
	  tb_default_n_reset =1;
	  #(CLK_PERIOD);
	  @(negedge tb_clk);
	  tb_i = 1;
	  #(CLK_PERIOD);
	  @(negedge tb_clk);
	  tb_i = 1;
	 //@(posedge tb_clk);
	  #(CLK_PERIOD);
	  @(negedge tb_clk);
	  tb_i = 0;
	  #(CLK_PERIOD);
	  @(negedge tb_clk);
	  tb_i = 1;
	  #(CLK_PERIOD);
	  //@(posedge tb_clk);
	   if (1'b1 == tb_o)
			$info("Default Test Case %0d:: PASSED", tb_default_test_num);
		else // Test case failed
			$error("Default Test Case %0d:: FAILED",tb_default_test_num);
	  #(CLK_PERIOD)
	  //@(posedge tb_clk);
	  tb_default_n_reset = 0;
	  #(CLK_PERIOD);
	  //@(posedge tb_clk);
	  tb_default_n_reset = 1;
	 // #(CLK_PERIOD);
	 
	  
	 //TESTCASE 3
	 tb_default_test_num = 3;
	  tb_i = 1;
	  #(CLK_PERIOD);
	  tb_i = 1;
	  #(CLK_PERIOD);
	  tb_i = 0;
	  #(CLK_PERIOD);
	  tb_i = 0;
	  #(CHECK_DELAY);
	  
	  if (1'b0 == tb_o)
			$info("Default Test Case %0d:: PASSED", tb_default_test_num);
		else // Test case failed
			$error("Default Test Case %0d:: FAILED",tb_default_test_num);
		#(CLK_PERIOD);	
	  tb_default_n_reset = 0;
	  #(CLK_PERIOD);
	  
	  
	  
	  end
	  
	
	  endmodule