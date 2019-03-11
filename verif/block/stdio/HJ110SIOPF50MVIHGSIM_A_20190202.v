// File name: HJ110SIOPF50MVIHGSIM_A_v0.4_20160622.v

/**********************************************************************************************/
/*                                                                                            */
/*   VERILOG MODEL FOR 0.11um pFlash 5V SIM IO Library                                        */
/*                                                                                            */
/*   Version: 0.4						                              */
/*   Datasheet: DS_HJ110SIOPF50MVIHGSIM_A_0.3_20160622.pdf			              */
/*								                              */		
/*   HeJain Technology Corp.                                                                  */
/*   Copyright@2016                                                                           */
/*                                                                                            */
/*   Verified With: Cadence Verilog-XL                                                        */
/*                  Cadence NC-Verilog                                                        */
/*								                              */
/*   Note:                                                                                    */
/*    1. Cells included in this file: IDIO_HJ110SIOPF50MVIHGSIM_A,                       */
/*				      IDIOE_HJ110SIOPF50MVIHGSIM_A,                      */
/*				      IRSTB_HJ110SIOPF50MVIHGSIM_A,                      */
/*				      ICLK_HJ110SIOPF50MVIHGSIM_A,                       */
/*				      IANA_HJ110SIOPF50MVIHGSIM_A,                       */
/*				      IVCC_HJ110SIOPF50MVIHGSIM_A,                       */
/*				      IVDD_HJ110SIOPF50MVIHGSIM_A,                       */
/*				      IGND_HJ110SIOPF50MVIHGSIM_A,                       */
/*				      IFILLER0_HJ110SIOPF50MVIHGSIM_A,                   */
/*				      IFILLER1_HJ110SIOPF50MVIHGSIM_A,                   */
/*				      IFILLER5_HJ110SIOPF50MVIHGSIM_A,                   */
/*				      IFILLER10_HJ110SIOPF50MVIHGSIM_A,                  */
/*				      IFILLER20_HJ110SIOPF50MVIHGSIM_A,                  */
/*				      IFILLER50_HJ110SIOPF50MVIHGSIM_A,                  */
/*				      IBREAK_HJ110SIOPF50MVIHGSIM_A.                     */
/*				      IEDGEL_HJ110SIOPF50MVIHGSIM_A,                     */
/*				      IEDGER_HJ110SIOPF50MVIHGSIM_A.                     */
/*                                                                                            */
/*    2. The input to output delay time 50ns in ICLK_HJ110SIOPF50MVIHGSIM_A is just a possible value.*/
/*       In actual circuit, the phase variation will make the delay time uncertain.           */
/*                                                                                            */
/*    3. ICLK_HJ110SIOPF50MVIHGSIM_A has LPF function. Only clock signal with pulse width >25ns can be passed.*/
/*                                                                                            */
/*    Revision History:                                                                       */
/*       * Version *   Date   * Description *                                                 */
/*       * 0.1     *2016/03/24* Initiated.  *                                                 */
/*       * 0.2     *2016/04/01* Added power ports.  *                                         */
/*       * 0.3     *2016/04/06* Added IBREAK cell.  *                                         */
/*       * 0.4     *2016/06/22* Added IDIOE cell.   *                                         */
/**********************************************************************************************/



`celldefine
`timescale 1ns/10ps

module IDIO_HJ110SIOPF50MVIHGSIM_A(DIN, DOUT, SPAD, ENO, ENI, OD, PU1, PU2, VDD_RDY_HV, VCC, VDD, GND);
input DOUT,
      ENO, 
      ENI,
      OD,
      PU1,
      PU2,
      VDD_RDY_HV;     //added for controlled by RSTB_HV 
output DIN;
inout SPAD, VCC, VDD, GND;

supply1 VCC, VDD;
supply0 GND;

wire WIRE_DIN_IN, pu_in, SPAD;

assign pu_in = VDD_RDY_HV && ( PU1 || PU2 );  // controlled by VDD_RDY_HV

buf buf1 (WIRE_DIN_IN, SPAD && ENI && VDD_RDY_HV);//ENI=1, DIN=SPA, DENI=0, DIN=0; controlled by VDD_RDY_HV
bufif1 (SPAD, DOUT, ENO && (! OD) && VDD_RDY_HV );  //OD=0, ENO=1; controlled by VDD_RDY_HV
bufif1 (SPAD, 0, ENO && OD && (!DOUT) && VDD_RDY_HV );  //OD=1, ENO=1, DOUT=0; controlled by VDD_RDY_HV

assign DIN=WIRE_DIN_IN; 

nmos pu1 (SPAD, pu_node, pu_in);
pullup (pull1, strong0) PUP (pu_node);

specify
// Module Path Delay
// DOUT --> SPAD
(DOUT => SPAD) = (0, 0);

// ENO --> SPAD
(ENO => SPAD) = (0, 0);

// SPAD --> DIN
(SPAD => DIN) = (0, 0);

endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps

module IDIOE_HJ110SIOPF50MVIHGSIM_A(DIN, DOUT, SPAD, ENO, PU1, PU2, OE5V, VCC, VDD, GND);
input DOUT,
      ENO,
      OE5V, 
      PU1,
      PU2;      
output DIN;
inout SPAD, VCC, VDD, GND;

supply1 VCC, VDD;
supply0 GND;

wire WIRE_DIN_IN, pu_in, ENC;

assign pu_in = PU1 || PU2;

buf buf1 (WIRE_DIN_IN, SPAD);
and a2 (ENC, ENO, OE5V);
bufif1 (SPAD, DOUT, ENC);

assign DIN=WIRE_DIN_IN; 

nmos pu1 (SPAD, pu_node, pu_in);
pullup (pull1, strong0) PUP (pu_node);

specify
// Module Path Delay
// DOUT --> SPAD
(DOUT => SPAD) = (0, 0);

// ENO --> SPAD
(ENO => SPAD) = (0, 0);

// SPAD --> DIN
(SPAD => DIN) = (0, 0);

endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps

module IRSTB_HJ110SIOPF50MVIHGSIM_A(DIN, DIN_HV, SPAD, VCC, VDD, GND);
inout SPAD;
output DIN;
output DIN_HV;       //added for RSTB_HV
wire SPAD, DIN;
inout VCC, VDD, GND;

supply1 VCC, VDD;
supply0 GND;

assign DIN = SPAD;
assign DIN_HV = SPAD; //added for RSTB_HV
pullup PUP(SPAD);

// Specify Block
specify
// Module Path Delay
(SPAD => DIN)=(0, 0);
endspecify

endmodule
`endcelldefine



`celldefine
`timescale 1ns/10ps

module ICLK_HJ110SIOPF50MVIHGSIM_A(DIN, DINP, SPAD, VCC, VDD, GND);
inout SPAD;
output DIN, DINP;
wire temp1, SPAD;
reg temp2;
inout VCC, VDD, GND;

supply1 VCC, VDD;
supply0 GND;

initial
temp2=1'b0;

assign #25.1 temp1 = SPAD;
assign DINP = SPAD;

always@(temp1)
temp2 = #24.9 temp1;

assign DIN=temp2;

// Specify Block
specify

// Module Path Delay
(SPAD => DIN) = (0, 0);
(SPAD => DINP) = (0, 0);
//specparam PATHPULSE$SPAD$DIN = (25, 40);

endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps

module IANA_HJ110SIOPF50MVIHGSIM_A(A, VCC, VDD, GND);
     
inout A, VCC, VDD, GND;

supply1 VCC, VDD;
supply0 GND;

wire A;

endmodule
`endcelldefine



`celldefine
`timescale 1ns/10ps
module IVDD_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 vcc;
   supply1 VDD;
   supply0 gnd;
   
   assign VCC = vcc;
   assign VDD = VDD;
   assign GND = gnd;
   specify
   endspecify

endmodule
`endcelldefine



`celldefine
`timescale 1ns/10ps
module IVCC_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 vcc;
   supply1 VDD;
   supply0 gnd;
   
   assign VCC = vcc;
   assign VDD = VDD;
   assign GND = gnd;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IGND_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 vcc;
   supply1 VDD;
   supply0 gnd;
   
   assign VCC = vcc;
   assign VDD = VDD;
   assign GND = gnd;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER0_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 VCC;
   supply1 VDD;
   supply0 gnd;
   
   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER1_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 VCC;
   supply1 VDD;
   supply0 gnd;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER5_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 VCC;
   supply1 VDD;
   supply0 gnd;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER10_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 VCC;
   supply1 VDD;
   supply0 gnd;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER20_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 VCC;
   supply1 VDD;
   supply0 gnd;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER50_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 VCC;
   supply1 VDD;
   supply0 gnd;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IBREAK_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND,GNDA);

   inout VCC,VDD,GND,GNDA;
   wire GND, GNDA;
   
   supply1 VCC;
   supply1 VDD;
   supply0 gnd;
   
   assign GNDA = GND;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IEDGEL_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 VCC;
   supply1 VDD;
   supply0 gnd;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IEDGER_HJ110SIOPF50MVIHGSIM_A(VCC,VDD,GND);

   inout VCC,VDD,GND;
   supply1 VCC;
   supply1 VDD;
   supply0 gnd;

   specify
   endspecify

endmodule
`endcelldefine


