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

module sp_instr_ram_wrap
  #(
    parameter RAM_SIZE   = 32768,              // in bytes
    parameter ADDR_WIDTH = $clog2(RAM_SIZE),
    parameter DATA_WIDTH = 32
  )(
    // Clock and Reset
    input  logic                    clk,
    input  logic                    rstn_i,
    input  logic                    en_i,
    input  logic [ADDR_WIDTH-1:0]   addr_i,
    input  logic [DATA_WIDTH-1:0]   wdata_i,
    output logic [DATA_WIDTH-1:0]   rdata_o,
    input  logic                    we_i,
    input  logic [DATA_WIDTH/8-1:0] be_i,
    input  logic                    bypass_en_i
  );

`ifdef xilinx_fpga_mem

  xilinx_mem_instr_ram_8192
  sp_ram_i
  (
    .clka   ( clk                    ),
    .rsta   ( 1'b0                   ), // reset is active high

    .ena    ( en_i                   ),
    .addra  ( addr_i[ADDR_WIDTH-1:2] ),
    .dina   ( wdata_i                ),
    .douta  ( rdata_o                ),
    .wea    ( be_i & {4{we_i}}       )
  );
  

//    mem_ila
//    instr_ila_i
//    (
//      .clk    ( clk            ),
  
//      .probe0 ( be_i & {4{we_i}}     ),
//      .probe1 ( en_i    ),
//      .probe2 ( addr_i[ADDR_WIDTH-1:2]  ),
//      .probe3 ( wdata_i   ),
//      .probe4 ( rdata_o  )
//    );

  // TODO: we should kill synthesis when the ram size is larger than what we
  // have here

`else
   if (RAM_SIZE == 32768) begin: RAM32K
   sp_ram_bank_32KB sp_ram_bank_i(
     .CK(clk),
     .A(addr_i[ADDR_WIDTH-1:2]),
     .DI(wdata_i),
     .WEB( ~(be_i & {4{we_i}} & {4{en_i}} & {4{~bypass_en_i}}) ), // write enable active low here
     .DO(rdata_o)
   );
   end
   
   if (RAM_SIZE == 16384) begin: RAM16K
     sp_ram_bank_16KB sp_ram_bank_i(
       .CK(clk),
       .A(addr_i[ADDR_WIDTH-1:2]),
       .DI(wdata_i),
       .WEB(~(be_i & {4{we_i}} & {4{en_i}} & {4{~bypass_en_i}}) ),
       .DO(rdata_o)
     );
   end

   // the following are the original sp_ram
   // sp_ram_bank
   // #(
   //  .NUM_BANKS  ( RAM_SIZE/4096 ),
   //  .BANK_SIZE  ( 1024          )
   // )
   // sp_ram_bank_i
   // (
   //  .clk_i   ( clk                     ), // CK
   //  .rstn_i  ( rstn_i                  ), // 
   //  .en_i    ( en_i                    ), //
   //  .addr_i  ( addr_i                  ), // A[11:0]
   //  .wdata_i ( wdata_i                 ), // DI[31:0]
   //  .rdata_o ( ram_out_int             ), // DO[31:0]
   //  .we_i    ( (we_i & ~bypass_en_i)   ), // WEB[3:0] there are 4 rams in the bank 
   //  .be_i    ( be_i                    ) // byte ? bank ? enable
   // );

// the following are the orginal simulation model
// `else
//   sp_ram
//   #(
//     .ADDR_WIDTH ( ADDR_WIDTH ),
//     .DATA_WIDTH ( DATA_WIDTH ),
//     .NUM_WORDS  ( RAM_SIZE   )
//   )
//   sp_ram_i
//   (
//     .clk     ( clk       ),
// 
//     .en_i    ( en_i      ),
//     .addr_i  ( addr_i    ),
//     .wdata_i ( wdata_i   ),
//     .rdata_o ( rdata_o   ),
//     .we_i    ( we_i      ),
//     .be_i    ( be_i      )
//   );
// 
`endif

endmodule
