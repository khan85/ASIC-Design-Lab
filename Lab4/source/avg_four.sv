// $Id: $
// File name:   avg_four.sv
// Created:     2/9/2015
// Author:      Parneet Kaur Ahuja
// Lab Section: 01
// Version:     1.0  Initial Design Entry
// Description: averaging

module avg_four(
  input wire clk,
  input wire n_reset,
  input wire [15:0] sample_data,
  input wire data_ready,
  output wire one_k_samples,
  output wire modwait,
  output wire [15:0] avg_out,
  output wire err
  );
  reg new_dr;
  reg cnt_up;
  reg overflow;
  reg [1:0] op;
  reg [3:0] src1;
  reg [3:0] src2;
  reg [3:0] dest;
  reg [15:0] result;
  
  sync SYNC(
  .clk(clk),
  .n_rst(n_reset),
  .async_in(data_ready),
  .sync_out(new_dr)
  );
  
  controller CONTROLLER(
  .clk(clk),
  .n_reset(n_reset),
  .overflow(overflow),
  .cnt_up(cnt_up),
  .dr(new_dr),
  .modwait(modwait),
  .op(op),
  .src1(src1),
  .src2(src2),
  .dest(dest),
  .err(err)
  );
  
  datapath DATA(
  .clk(clk),
  .n_reset(n_reset),
  
  .op(op),
  .src1(src1),
  .src2(src2),
  .dest(dest),
  .ext_data(sample_data),
  .outreg_data(result),
  .overflow(overflow)
  
  );
  
  counter COUNTER(
  .clk(clk),
  .n_reset(n_reset),
  .cnt_up(cnt_up),
  .one_k_samples(one_k_samples)
  );
  
  assign avg_out = {2'b00,result[15:2]};
  
endmodule
   