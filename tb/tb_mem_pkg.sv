// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

  logic [31:0]     data_mem[];  // this variable holds the whole memory content
  logic [31:0]     instr_mem[]; // this variable holds the whole memory content
  event            event_mem_load;

  task mem_preload;
    integer      addr;
    integer      mem_addr;
    integer      bidx;
    integer      instr_size;
    integer      instr_width;
    integer      data_size;
    integer      data_width;
    logic [31:0] data;
    string       caseName;
    string       l2_imem_file;
    string       l2_dmem_file;
    begin
      $display("Preloading memory");
      instr_size   = tb.top_i.core_region_i.mbist.INSTR_RAM_SIZE;
      instr_width = tb.top_i.core_region_i.mbist.DATA_WIDTH;

      data_size   = tb.top_i.core_region_i.mbist.DATA_RAM_SIZE;
      data_width = tb.top_i.core_region_i.mbist.DATA_WIDTH;

      instr_mem = new [instr_size/4];
      data_mem  = new [data_size/4];

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
//      else if(!$value$plusargs("l2_imem=%s", l2_imem_file))
//         l2_imem_file = "slm_files/l2_stim.slm";

      $display("Preloading instruction memory from %0s", l2_imem_file);
      $readmemh(l2_imem_file, instr_mem);
        
//      if($value$plusargs("caseName=%s", caseName)) begin
//         l2_dmem_file = {"firmware/", caseName, "/tcdm_bank0.slm"};
//      end
//      else if(!$value$plusargs("l2_dmem=%s", l2_dmem_file))
//         l2_dmem_file = "slm_files/tcdm_bank0.slm";

      $display("Preloading data memory from %0s", l2_dmem_file);
      $readmemh(l2_dmem_file, data_mem);


      // preload data memory
      for(addr = 0; addr < data_size/4; addr = addr) begin

        for(bidx = 0; bidx < data_width/8; bidx++) begin
          mem_addr = addr / (data_width/32);
          data = data_mem[addr];
          if (bidx%4 == 0)
            tb.top_i.core_region_i.mbist.sram_bist.MEM0_MEM_INST.Memory_byte0[mem_addr] = data[ 7: 0];
          else if (bidx%4 == 1)
            tb.top_i.core_region_i.mbist.sram_bist.MEM0_MEM_INST.Memory_byte1[mem_addr] = data[15: 8];
          else if (bidx%4 == 2)
            tb.top_i.core_region_i.mbist.sram_bist.MEM0_MEM_INST.Memory_byte2[mem_addr] = data[23:16];
          else if (bidx%4 == 3)
            tb.top_i.core_region_i.mbist.sram_bist.MEM0_MEM_INST.Memory_byte3[mem_addr] = data[31:24];

          if (bidx%4 == 3) addr++;
        end
      end

      // preload instruction memory
      for(addr = 0; addr < instr_size/4; addr = addr) begin

        for(bidx = 0; bidx < instr_width/8; bidx++) begin
          mem_addr = addr / (instr_width/32);
          data = instr_mem[addr];

          if (bidx%4 == 0)
            tb.top_i.core_region_i.mbist.sram_bist.MEM1_MEM_INST.Memory_byte0[mem_addr] = data[ 7: 0];
          else if (bidx%4 == 1)
            tb.top_i.core_region_i.mbist.sram_bist.MEM1_MEM_INST.Memory_byte1[mem_addr] = data[15: 8];
          else if (bidx%4 == 2)
            tb.top_i.core_region_i.mbist.sram_bist.MEM1_MEM_INST.Memory_byte2[mem_addr] = data[23:16];
          else if (bidx%4 == 3)
            tb.top_i.core_region_i.mbist.sram_bist.MEM1_MEM_INST.Memory_byte3[mem_addr] = data[31:24];

          if (bidx%4 == 3) addr++;
        end
      end
    end
  endtask
