module master_example ( 
	CLOCK_50 , 
	SW , 
	KEY, 
	LEDG, 
	LEDR , 
	// DRAM signals
	DRAM_CLK, 
	DRAM_CKE, 
	DRAM_ADDR ,
	
	DRAM_BA ,
	DRAM_CS_N ,
	DRAM_CAS_N , 
	DRAM_RAS_N , 
	DRAM_WE_N, 
	DRAM_DQ ,
	DRAM_DQM ,
	
	FAN_CTRL,
	// HEX 7 SEG DISPLAY
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6, 
	HEX7,
	// PCIE signals
	PCIE_PERST_N,
	PCIE_REFCLK_P,
	PCIE_RX_P,
	PCIE_TX_P,
	PCIE_WAKE_N
);		

inout logic FAN_CTRL;
input logic  CLOCK_50  ;
input logic [17:0] SW ; 
input logic [3:0] KEY ;
output logic [8:0] LEDG; 
output logic [17:0]LEDR;
output logic [6:0] HEX0;
output logic [6:0] HEX1;
output logic [6:0] HEX2;
output logic [6:0] HEX3;
output logic [6:0] HEX4;
output logic [6:0] HEX5;
output logic [6:0] HEX6;
output logic [6:0] HEX7;

output logic [11:0]DRAM_ADDR;
output logic [1:0]DRAM_BA;
output logic DRAM_CAS_N;
output logic DRAM_CKE;
output logic DRAM_CLK;
output logic DRAM_CS_N;
inout	logic  [31:0] DRAM_DQ;
output logic [3:0] DRAM_DQM;
output logic DRAM_RAS_N;
output logic DRAM_WE_N;

input logic PCIE_PERST_N;
input logic PCIE_REFCLK_P;
input logic PCIE_RX_P;
output logic PCIE_TX_P;
output logic PCIE_WAKE_N;

//parameter ADDRESSWIDTH = 32 ;
parameter ADDRESSWIDTH = 28;
parameter DATAWIDTH = 32;

logic soc_clk;
logic ctl_wr_fixed_location;
logic [ADDRESSWIDTH-1:0] ctl_wr_addr_base;
logic [ADDRESSWIDTH-1:0] ctl_wr_length;

logic ctl_rd_fixed_location;
logic [ADDRESSWIDTH-1:0] ctl_rd_addr_base;
logic [ADDRESSWIDTH-1:0] ctl_rd_length;

logic ctl_wr_go;
logic ctl_wr_done;

logic usr_wr_buffer;
logic [DATAWIDTH-1:0]usr_wr_buffer_data;
logic usr_wr_buffer_full;

logic ctl_rd_go;
logic ctl_rd_done;

logic usr_rd_buffer;
logic [DATAWIDTH-1:0]usr_rd_buffer_data;
logic usr_rd_buffer_nonempty;
logic indicator;
logic [31:0] display_data;

logic [15:0] debug_flag;

logic rdwr_cntl;
logic n_action;
logic add_data_sel;
logic [31:0] rdwr_address;



assign rdwr_cntl = SW[17];
assign n_action = KEY[1];
assign add_data_sel = SW[16];

assign FAN_CTRL = 1'b0;
assign PCIE_WAKE_N = 1'b1;

assign soc_clk = CLOCK_50;
assign DRAM_CLK = CLOCK_50;

	
always_ff @(posedge CLOCK_50) begin
	if(!KEY[0]) begin
		LEDR <= 0; 
	end else begin
		if ( debug_flag > 0) begin
			LEDR[debug_flag] <= 1;
		end else begin
			LEDR[0] <= 1;
		end
	end
end	

//amm_master_qsys amm_master_inst  ( 
amm_master_qsys_with_pcie amm_master_inst  ( 
         .clk_clk			(soc_clk),  				  // clk.clk
         .reset_reset_n			(KEY[0]),                  	          // reset.reset_n
         //       .altpll_sdram_clk                       (DRAM_CLK),
	 .sdram_addr			(DRAM_ADDR),         			  // new_sdram_controller_0_wire.addr
         .sdram_ba			(DRAM_BA),           			  // ba
         .sdram_cas_n			(DRAM_CAS_N),        			  // cas_n
         .sdram_cke			(DRAM_CKE),          			  // cke
         .sdram_cs_n			(DRAM_CS_N),         			  // cs_n
         .sdram_dq			(DRAM_DQ),           			  // dq
         .sdram_dqm			(DRAM_DQM),          			  // dqm
         .sdram_ras_n			(DRAM_RAS_N),        			  // ras_n
         .sdram_we_n			(DRAM_WE_N),         			  // we_n
	 			 
	 .pcie_ip_refclk_export         (PCIE_REFCLK_P),                      // pcie_ip_refclk.export
	 .pcie_ip_pcie_rstn_export      (PCIE_PERST_N),             	  // pcie_ip_pcie_rstn.export
	 .pcie_ip_rx_in_rx_datain_0     (PCIE_RX_P),                          // pcie_ip_rx_in.rx_datain_0
	 .pcie_ip_tx_out_tx_dataout_0   (PCIE_TX_P),                           // pcie_ip_tx_out.tx_dataout_0

	 .user_module_0_conduit_end_rdwr_cntl     (rdwr_cntl),              //        user_module_conduit.rdwr_cntl
         .user_module_0_conduit_end_n_action      (n_action),               //                           .n_action
         .user_module_0_conduit_end_add_data_sel  (add_data_sel),           //                           .add_data_sel
         .user_module_0_conduit_end_rdwr_address  (rdwr_address),            //                           .rdwr_address
         .user_module_0_conduit_end_debug_flag  (debug_flag),            //                           .rdwr_address
         .user_module_0_conduit_end_display_data  (display_data)            //                           .rdwr_address
        );


//user_module user_module_inst (
//	.clk(soc_clk),
//	.reset(KEY[0]),
//	.rdwr_cntl(SW[17]),
//	.n_action(KEY[1]),
//	.add_data_sel(SW[16]),
//	//.read_address(SW[7:0]),
//	.LEDR(LEDR),
//	.w_image_done(image_done_flag)
//);


SEG_HEX hex0(
	   .iDIG(display_data[31:28]),         
	   .oHEX_D(HEX7)
           );  
SEG_HEX hex1(                              
           .iDIG(display_data[27:24]),
           .oHEX_D(HEX6)
           );
SEG_HEX hex2(                           
           .iDIG(display_data[23:20]),
           .oHEX_D(HEX5)
           );
SEG_HEX hex3(                              
           .iDIG(display_data[19:16]),
           .oHEX_D(HEX4)
           );
SEG_HEX hex4(                               
           .iDIG(display_data[15:12]),
           .oHEX_D(HEX3)
           );
SEG_HEX hex5(                          
           .iDIG(display_data[11:8]), 
           .oHEX_D(HEX2)
           );
SEG_HEX hex6(                      
           .iDIG(display_data[7:4]),
           .oHEX_D(HEX1)
           );
SEG_HEX hex7(              
           .iDIG(display_data[3:0]) ,
           .oHEX_D(HEX0)
           );

endmodule 
