// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`include "config.sv"
`include "tb_jtag_pkg.sv"

`define REF_CLK_PERIOD   (2*15.25us)  // 32.786 kHz --> FLL reset value --> 50 MHz
//`define CLK_PERIOD       40.00ns      // 25 MHz
`define CLK_PERIOD       31.25ns      // 32 MHz

`define EXIT_SUCCESS  0
`define EXIT_FAIL     1
`define EXIT_ERROR   -1

module tb;
  timeunit      1ns;
  timeprecision 1ps;

  // +MEMLOAD= valid values are "SPI", "STANDALONE" "PRELOAD", "" (no load of L2)
  parameter  SPI            = "QUAD";    // valid values are "SINGLE", "QUAD"
  parameter  BAUDRATE       = 781250;    // 1562500
  parameter  CLK_USE_FLL    = 0;  // 0 or 1
  parameter  TEST           = ""; //valid values are "" (NONE), "DEBUG"
  parameter  USE_ZERO_RISCY = 1;
  parameter  RISCY_RV32F    = 0;
  parameter  ZERO_RV32M     = 1;
  parameter  ZERO_RV32E     = 0;
  
    reg [31:0]  eflash_read_data_page [10000:0];
    reg [31:0]  eflash_read_instr_page [10000:0];
    reg [31:0]  eflash_read_info_page [10000:0];
    reg [31:0] data_mem_size = 0;
    reg [31:0] instr_mem_size = 0;
    reg [31:0] data_mem_cmp = 10;
    reg [31:0] instr_mem_cmp = 10;
    reg [31:0] info_eflash_cmp = 10;

    reg rst_async_por_n = 0;
    reg rst_async_key_n = 0;
    reg pvd_in = 0;


  int           exit_status = `EXIT_ERROR; // modelsim exit code, will be overwritten when successful

  string        memload;
  string        eflashJTAG;
  logic         s_clk   = 1'b0;
  logic         clk_32K   = 1'b0;
  logic         clk_32M   = 1'b0;
  logic         s_rst_n = 1'b0;

  logic [1:0]   padmode_spi_master;
  logic         spi_sck   = 1'b0;
  logic         spi_csn   = 1'b1;
  logic [1:0]   spi_mode;
  logic         spi_sdo0;
  logic         spi_sdo1;
  logic         spi_sdo2;
  logic         spi_sdo3;
  logic         spi_sdi0;
  logic         spi_sdi1;
  logic         spi_sdi2;
  logic         spi_sdi3;

  logic         uart_tx;
  logic         uart_rx;
  logic         s_uart_dtr;
  logic         s_uart_rts;

  logic         scl_pad_i;
  logic         scl_pad_o;
  logic         scl_padoen_o;

  logic         sda_pad_i;
  logic         sda_pad_o;
  logic         sda_padoen_o;

  tri1          scl_io;
  tri1          sda_io;

  logic [31:0]  gpio_in = '0;
  logic [31:0]  gpio_dir;
  logic [31:0]  gpio_out;

  logic [31:0]  recv_data;

  jtag_i jtag_if();

  adv_dbg_if_t adv_dbg_if = new(jtag_if);

  // use 8N1
  uart_bus
  #(
    .BAUD_RATE(BAUDRATE),
    .PARITY_EN(0)
  )
  uart
  (
    .rx         ( uart_rx ),
    .tx         ( uart_tx ),
    .rx_en      ( 1'b1    )
  );

  spi_slave
  spi_master();


  i2c_buf i2c_buf_i
  (
    .scl_io       ( scl_io       ),
    .sda_io       ( sda_io       ),
    .scl_pad_i    ( scl_pad_i    ),
    .scl_pad_o    ( scl_pad_o    ),
    .scl_padoen_o ( scl_padoen_o ),
    .sda_pad_i    ( sda_pad_i    ),
    .sda_pad_o    ( sda_pad_o    ),
    .sda_padoen_o ( sda_padoen_o )
  );

  i2c_eeprom_model
  #(
    .ADDRESS ( 7'b1010_000 )
  )
  i2c_eeprom_model_i
  (
    .scl_io ( scl_io  ),
    .sda_io ( sda_io  ),
    .rst_ni ( s_rst_n )
  );

   supply1 VDD;
   supply0 VSS;
   //eflash model signal
   wire [13:0]     o_addr_eflsh;
   wire            o_addr_1_eflsh;
   wire            o_word_eflsh;
   wire [31:0]     o_din_eflsh;
   wire [31:0]     i_dout_eflsh;
   wire            o_resetb_eflsh;
   wire            o_cs_eflsh;
   wire            o_ae_eflsh;
   wire            o_oe_eflsh;
   wire            o_ifren_eflsh;
   wire            o_nvstr_eflsh;
   wire            o_prog_eflsh;
   wire            o_sera_eflsh;
   wire            o_mase_eflsh;
   wire            i_tbit_eflsh;
PF64AK32EI40_MODEL u_PF64AK32EI40(
        .ADDR          (o_addr_eflsh)    , 
        .DIN           (o_din_eflsh)    , 
        .DOUT          (i_dout_eflsh)    ,                
        .CS            (o_cs_eflsh)    , 
        .AE            (o_ae_eflsh)    , 
        .OE            (o_oe_eflsh)    , 
        .IFREN         (o_ifren_eflsh)    , 
        .NVSTR         (o_nvstr_eflsh)    , 
        .PROG          (o_prog_eflsh)    , 
        .SERA          (o_sera_eflsh)    , 
        .MASE          (o_mase_eflsh)    , 
        .TBIT          (i_tbit_eflsh)    ,                 
        .ADDR_1        (o_addr_1_eflsh)    , 
        .WORD          (o_word_eflsh)    ,               
        .RESETB        (o_resetb_eflsh)    ,                  
        .VDD           (VDD)    , 
        .VSS           (VSS)    , 
        .VPP           (1'b1)    , 
        .VNN           (1'b0)    ,               
        .SMTEN         (1'b0)    ,//o_smten_eflsh 
        .SCE           (1'b0)    ,//o_sce_eflsh 
        .SCLK          (1'b0)    ,//sclk_eflsh 
        .SIO_OEN       (i_sio_oen_eflsh)    , 
        .SIO_O         (i_sio_eflsh)    , 
        .SIO_I         (1'b0)    );//o_sio_eflsh

wire jtag_tck  ;
wire jtag_trstn;
wire jtag_tms  ;
wire jtag_tdi  ;
wire jtag_tdo  ;
wire resetn    ;
wire cms_0;
wire cms_1;
initial begin
    force jtag_tck     = jtag_if.tck;
    force jtag_trstn   = jtag_if.trstn;
    force jtag_tms     = jtag_if.tms;
    force jtag_tdi     = jtag_if.tdi;
    force jtag_if.tdo  = jtag_tdo;
    force resetn       = rst_async_key_n;
    force cms_0        = 1'h0;
    force cms_1        = 1'h0;
    force tb.top_i.rst_async_por_n  = rst_async_por_n;
    force tb.top_i.pvd_in           = pvd_in;
    force tb.top_i.clk_rc32m        = clk_32M;
    force tb.top_i.clk_rc32k        = clk_32K;
    force tb.top_i.clk_32k          = clk_32K;
    force tb.top_i.rc32m_ready      = 1'h1;
    force tb.top_i.rc32k_ready      = 1'h1;
end

  pulpino_top
  #(
    .USE_ZERO_RISCY    ( USE_ZERO_RISCY ),
    .RISCY_RV32F       ( RISCY_RV32F    ),
    .ZERO_RV32M        ( ZERO_RV32M     ),
    .ZERO_RV32E        ( ZERO_RV32E     )
   )
  top_i
  (
`ifdef EFLASH_MODEL
    .o_addr_eflsh      (o_addr_eflsh),
    .o_addr_1_eflsh    (o_addr_1_eflsh),
    .o_word_eflsh      (o_word_eflsh),
    .o_din_eflsh       (o_din_eflsh),
    .i_dout_eflsh      (i_dout_eflsh),
    .o_resetb_eflsh    (o_resetb_eflsh),
    .o_cs_eflsh        (o_cs_eflsh),
    .o_ae_eflsh        (o_ae_eflsh),
    .o_oe_eflsh        (o_oe_eflsh),
    .o_ifren_eflsh     (o_ifren_eflsh),
    .o_nvstr_eflsh     (o_nvstr_eflsh),
    .o_prog_eflsh      (o_prog_eflsh),
    .o_sera_eflsh      (o_sera_eflsh),
    .o_mase_eflsh      (o_mase_eflsh),
    .i_tbit_eflsh      (i_tbit_eflsh),
`endif//EFLASH_MODEL
    .pad_resetn_spad   (resetn       ),
    .pad_cms_0_spad    (cms_0        ),
    .pad_cms_1_spad    (cms_1        ),
    .pad_jtag_tck_spad (jtag_tck     ),
    .pad_jtag_rstn_spad(jtag_trstn   ),
    .pad_jtag_tms_spad (jtag_tms     ),
    .pad_jtag_tdi_spad (jtag_tdi     ),
    .pad_jtag_tdo_spad (jtag_tdo     )
  );

//32.768KHz
initial begin
    #(`REF_CLK_PERIOD/2);
    clk_32K = 1'b1;
    forever clk_32K = #(`REF_CLK_PERIOD/2) ~clk_32K;
end

//32MHz
initial begin
    #(`CLK_PERIOD/2);
    clk_32M = 1'b1;
    forever clk_32M = #(`CLK_PERIOD/2) ~clk_32M;
end

  generate
    if (CLK_USE_FLL) begin
      initial
      begin
        #(`REF_CLK_PERIOD/2);
        s_clk = 1'b1;
        forever s_clk = #(`REF_CLK_PERIOD/2) ~s_clk;
      end
    end else begin
      initial
      begin
        #(`CLK_PERIOD/2);
        s_clk = 1'b1;
        forever s_clk = #(`CLK_PERIOD/2) ~s_clk;
      end
    end
  endgenerate

  logic use_qspi;
  reg [7:0] jtagEflashData  = 9;
  reg [7:0] jtagEflashInstr = 9;
  initial
  begin
    int i;

    if($value$plusargs("EFLASH_LOAD=%s", eflashJTAG)) $display("Using EFLASH_LOAD method: %s", eflashJTAG);
    if(!$value$plusargs("MEMLOAD=%s", memload))
      memload = "PRELOAD";

    $display("Using MEMLOAD method: %s", memload);

    $display("Using %s core", USE_ZERO_RISCY ? "zero-riscy" : "ri5cy");

    use_qspi = SPI == "QUAD" ? 1'b1 : 1'b0;

    s_rst_n      = 1'b0;
    force tb.top_i.fetch_enable_i = 1'b0;

    #500ns;

    s_rst_n = 1'b1;

    #500ns;
    if (use_qspi)
      spi_enable_qpi();


    if (memload != "STANDALONE")
    begin
      /* Configure JTAG and set boot address */
      adv_dbg_if.jtag_reset();
      adv_dbg_if.jtag_softreset();
      adv_dbg_if.init();
      if(eflashJTAG !== "EFLASH")
        adv_dbg_if.axi4_write32(32'h1A10_7008, 1, 32'h0000_0000);
      else begin
        adv_dbg_if.axi4_write32(32'h1A10_7008, 1, 32'h0000_8000);
        adv_dbg_if.axi4_write32(32'h0012_0800, 1, 32'h340);
      end
    end

    if (memload == "PRELOAD")
    begin
      // preload memories
      mem_preload();
    end
    else if (memload == "SPI")
    begin
      spi_load(use_qspi);
      spi_check(use_qspi);
    end
    else if (memload == "JTAG")
    begin
     logic         more_stim = 1;
     logic [31:0]  data_mem  [10000:0];                // array for the stimulus vectors
     logic [31:0]  instr_mem  [10000:0];                // array for the stimulus vectors
     int           num_stim;
     string       l2_imem_file;
     string       l2_dmem_file;
     string       caseName;


      if($value$plusargs("caseName=%s", caseName)) begin
          //$display("caseName: %s\n", caseName);
         l2_imem_file = {"firmware/", caseName, "/l2_stim.slm"};
         l2_dmem_file = {"firmware/", caseName, "/tcdm_bank0.slm"};
          //$display("l2_imem_file: %s\n", l2_imem_file);
      end
      else if($value$plusargs("adc_case=%s", caseName)) begin
         l2_imem_file = {"../../fpga/emu/adc/", caseName, "/l2_stim.slm"};
         l2_dmem_file = {"../../fpga/emu/adc/", caseName, "/tcdm_bank0.slm"};
      end
      else if($value$plusargs("calib_case=%s", caseName)) begin
         l2_imem_file = {"../../fpga/emu/calib/", caseName, "/l2_stim.slm"};
         l2_dmem_file = {"../../fpga/emu/calib/", caseName, "/tcdm_bank0.slm"};
      end
      else if($value$plusargs("rtc_case=%s", caseName)) begin
         l2_imem_file = {"../../fpga/emu/rtc/", caseName, "/l2_stim.slm"};
         l2_dmem_file = {"../../fpga/emu/rtc/", caseName, "/tcdm_bank0.slm"};
      end
      else if($value$plusargs("wdt_case=%s", caseName)) begin
         l2_imem_file = {"../../fpga/emu/wdt/", caseName, "/l2_stim.slm"};
         l2_dmem_file = {"../../fpga/emu/wdt/", caseName, "/tcdm_bank0.slm"};
      end
      else if($value$plusargs("scu_case=%s", caseName)) begin
         l2_imem_file = {"../../fpga/emu/scu/", caseName, "/l2_stim.slm"};
         l2_dmem_file = {"../../fpga/emu/scu/", caseName, "/tcdm_bank0.slm"};
      end
      else begin
         $display("ERROR, caseName/adc_case/calib_case/rtc_case/wdt_case/scu_case need setting, pls check cmds");
         $finish;
      end
      $readmemh(l2_imem_file, instr_mem);
      for(int i = 0; i < 1024*32; i++) begin
        if(instr_mem[i] >= 0)instr_mem_size++;
        else break;
      end
      $display("Preloading instruction memory from %0s, size: %0d", l2_imem_file, instr_mem_size);
        
      $readmemh(l2_dmem_file, data_mem);
      for(int i = 0; i < 1024*32; i++) begin
        if(data_mem[i] >= 0)data_mem_size++;
        else break;
      end
      $display("Preloading data memory from %0s, size: %0d", l2_dmem_file, data_mem_size);

      adv_dbg_if.axi_write_cnt = 0;
      adv_dbg_if.axi_read_cnt = 0;
      more_stim = 1 ;
      num_stim = 0 ;
     
      while (more_stim)                        // loop until we have no more stimuli)
      begin
        if(eflashJTAG !== "EFLASH") begin
            adv_dbg_if.axi4_write32(4*num_stim + 32'h0010_0000 , 1, data_mem[num_stim]);
            jtagEflashData = 0;
        end
        else begin
            while(1) begin
                if(tb.top_i.axi4_eflash_ctrl.active_en === 1'b1) break;
                @(posedge tb.top_i.axi4_eflash_ctrl.clk);
            end
            adv_dbg_if.axi4_write32(4*num_stim + 32'h0011_8000 , 1, data_mem[num_stim]);
            jtagEflashData = 1;
        end
        num_stim     = num_stim + 1;             // increment stimuli
        if (num_stim > 9999 | data_mem[num_stim]===32'bx ) // make sure we have more stimuli
          more_stim = 0;                    // if not set variable to 0, will prevent additional stimuli to be applied
      end 
      $display("[adv_dbg_if] AXI4 WRITE32 burst for %d transactions.", adv_dbg_if.axi_write_cnt);
`ifdef JTAG_EFLASH_EN
    //for eflash-read opr         
    for(int i = 0; i < data_mem_size; i++) begin
        adv_dbg_if.axi4_read32(i*4 + 32'h0011_8000 , 1, eflash_read_data_page[i]);
        if(eflash_read_data_page[i] === data_mem[i]) data_mem_cmp = 1;
        else data_mem_cmp = 0;
//        $display("eflash_read_data_page[%0d]: %0x", i*4 + 32'h0011_8000, eflash_read_data_page[i]);
    end
        $display("[adv_dbg_if] AXI4 READ32 burst for %d transactions.", adv_dbg_if.axi_read_cnt);
`endif//JTAG_EFLASH_EN            
      
      more_stim = 1 ;
      num_stim = 0 ;
    
      while (more_stim)                        // loop until we have no more stimuli)
      begin
        if(eflashJTAG !== "EFLASH") begin
            adv_dbg_if.axi4_write32(4*num_stim + 32'h0000_0000 , 1, instr_mem[num_stim]);
            jtagEflashInstr = 0;
        end
        else begin
            while(1) begin
                if(tb.top_i.axi4_eflash_ctrl.active_en === 1'b1) break;
                @(posedge tb.top_i.axi4_eflash_ctrl.clk);
            end
            adv_dbg_if.axi4_write32(4*num_stim + 32'h0011_0000 , 1, instr_mem[num_stim]);
            jtagEflashInstr = 1;
        end
        num_stim     = num_stim + 1;             // increment stimuli
        if (num_stim > 9999 | instr_mem[num_stim]===32'bx ) // make sure we have more stimuli
          more_stim = 0;                    // if not set variable to 0, will prevent additional stimuli to be applied
      end  
      $display("[adv_dbg_if] AXI4 WRITE32 burst for %d transactions.", adv_dbg_if.axi_write_cnt);
`ifdef JTAG_EFLASH_EN
    //for eflash-read opr         
    for(int i = 0; i < instr_mem_size; i++) begin
        adv_dbg_if.axi4_read32(i*4 + 32'h0011_0000 , 1, eflash_read_instr_page[i]);
        if(eflash_read_instr_page[i] === instr_mem[i]) instr_mem_cmp = 1;
        else instr_mem_cmp = 0;
//        $display("eflash_read_instr_page[%0d]: %0x", i*4 + 32'h0011_0000, eflash_read_instr_page[i]);
    end
        $display("[adv_dbg_if] AXI4 READ32 burst for %d transactions.", adv_dbg_if.axi_read_cnt);
`endif//JTAG_EFLASH_EN            

`ifdef JTAG_EFLASH_EN
      $display("\neflash_info_page write & read access");
      for(int info_i = 0; info_i < 2048/4; info_i++) begin
          while(1) begin
              if(tb.top_i.axi4_eflash_ctrl.active_en === 1'b1) break;
              @(posedge tb.top_i.axi4_eflash_ctrl.clk);
          end            
          adv_dbg_if.axi4_write32(4*info_i + 32'h0012_0000 , 1, 4*info_i + 32'h0012_0000);
      end    
      $display("[adv_dbg_if] AXI4 WRITE32 burst for %d transactions.", adv_dbg_if.axi_write_cnt);

      for(int info_i = 0; info_i < 2048/4; info_i++) begin
        adv_dbg_if.axi4_read32(info_i*4 + 32'h0012_0000 , 1, eflash_read_info_page[info_i]);
        if(eflash_read_info_page[info_i] === (4*info_i + 32'h0012_0000)) info_eflash_cmp = 1;
        else info_eflash_cmp = 0;
      end
      $display("[adv_dbg_if] AXI4 READ32 burst for %d transactions.", adv_dbg_if.axi_read_cnt);
`endif//JTAG_EFLASH_EN            

    `ifdef JTAG_EFLASH_EN
        repeat(60000)@(posedge s_clk);
        $finish;
    `endif//JTAG_EFLASH_EN
    end


    #200ns;
    force tb.top_i.fetch_enable_i = 1'b1;

    if(TEST == "DEBUG") begin
      debug_tests();
    end else if (TEST == "DEBUG_IRQ") begin
      debug_irq_tests();
    end else if (TEST == "MEM_DPI") begin
      mem_dpi(4567);
    end else if (TEST == "ARDUINO_UART") begin
      if (~gpio_out[0])
        wait(gpio_out[0]);
      uart.send_char(8'h65);
    end else if (TEST == "ARDUINO_GPIO") begin
      // Here  test for GPIO Starts
      if (~gpio_out[0])
        wait(gpio_out[0]);

      gpio_in[4]=1'b1;

      if (~gpio_out[1])
        wait(gpio_out[1]);
      if (~gpio_out[2])
        wait(gpio_out[2]);
      if (~gpio_out[3])
        wait(gpio_out[3]);

      gpio_in[7]=1'b1;

    end else if (TEST == "ARDUINO_SHIFT") begin

      if (~gpio_out[0])
        wait(gpio_out[0]);
      //start TEST

      if (~gpio_out[4])
        wait(gpio_out[4]);
      gpio_in[3]=1'b1;
      if (gpio_out[4])
        wait(~gpio_out[4]);

      if (~gpio_out[4])
        wait(gpio_out[4]);
      gpio_in[3]=1'b1;
      if (gpio_out[4])
        wait(~gpio_out[4]);

      if (~gpio_out[4])
        wait(gpio_out[4]);
      gpio_in[3]=1'b0;
      if (gpio_out[4])
        wait(~gpio_out[4]);

      if (~gpio_out[4])
        wait(gpio_out[4]);
      gpio_in[3]=1'b0;
      if (gpio_out[4])
        wait(~gpio_out[4]);

      if (~gpio_out[4])
        wait(gpio_out[4]);
      gpio_in[3]=1'b1;
      if (gpio_out[4])
        wait(~gpio_out[4]);

      if (~gpio_out[4])
        wait(gpio_out[4]);
      gpio_in[3]=1'b0;
      if (gpio_out[4])
        wait(~gpio_out[4]);

      if (~gpio_out[4])
        wait(gpio_out[4]);
      gpio_in[3]=1'b0;
      if (gpio_out[4])
        wait(~gpio_out[4]);

      if (~gpio_out[4])
        wait(gpio_out[4]);
      gpio_in[3]=1'b1;
      if (gpio_out[4])
        wait(~gpio_out[4]);

    end else if (TEST == "ARDUINO_PULSEIN") begin
      if (~gpio_out[0])
        wait(gpio_out[0]);
      #50us;
      gpio_in[4]=1'b1;
      #500us;
      gpio_in[4]=1'b0;
      #1ms;
      gpio_in[4]=1'b1;
      #500us;
      gpio_in[4]=1'b0;
    end else if (TEST == "ARDUINO_INT") begin
      if (~gpio_out[0])
        wait(gpio_out[0]);
      #50us;
      gpio_in[1]=1'b1;
      #20us;
      gpio_in[1]=1'b0;
      #20us;
      gpio_in[1]=1'b1;
      #20us;
      gpio_in[2]=1'b1;
      #20us;
    end else if (TEST == "ARDUINO_SPI") begin
      for(i = 0; i < 2; i++) begin
        spi_master.wait_csn(1'b0);
        spi_master.send(0, {>>{8'h38}});
      end
    end



    // end of computation
    if (~gpio_out[8])
      wait(gpio_out[8]);

    spi_check_return_codes(exit_status);
    if (memload == "JTAG")
        repeat(60000)@(posedge s_clk);
        repeat(160000)@(posedge s_clk);
    $fflush();
    $stop();
  end

  // TODO: this is a hack, do it properly!
  `include "tb_spi_pkg.sv"
  `include "tb_mem_pkg.sv"
  `include "spi_debug_test.svh"
  `include "mem_dpi.svh"
//add by chenweijie@2019.01.14
initial begin:dump_fsdb 
    $fsdbDumpfile("./tb.fsdb");
    $fsdbDumpMDA(0, tb.top_i);
    $fsdbDumpvars(0, tb);
    $fsdbDumpon;
end

initial begin:clk_rst_handle
    repeat(10) @(posedge clk_32M);
    rst_async_por_n = 1;
    rst_async_key_n = 1;
end

endmodule
