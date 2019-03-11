// File name: HJ110SIOPF50MVIHCAA_A_V0.1_P1_20190123.v

/**********************************************************************************************/
/*                                                                                            */
/*   VERILOG MODEL FOR 0.11um pFlash 5V SIM IO Library                                        */
/*                                                                                            */
/*   Version: 0.1						                              */
/*   Datasheet: DS_HJ110SIOPF50MVIHCAA_A_0.1_20190123.pdf			              */
/*								                              */		
/*   HeJian Technology Corp.                                                                  */
/*   Copyright@2016                                                                           */
/*                                                                                            */
/*   Verified With: Cadence Verilog-XL                                                        */
/*                  Cadence NC-Verilog                                                        */
/*								                              */
/*   Note:                                                                                    */
/*    1. Cells included in this file: IDIO,                                                   */
/*				      IRSTB,                                                  */
/*				      ICLK,                                                   */
/*				      IANA,                                                   */
/*				      IVDDIO,                                                 */
/*				      IVDD,                                                   */
/*				      IVSS,                                                   */
/*				      IFILLER0N,                                              */
/*				      IFILLER1N,                                              */
/*				      IFILLER5N,                                              */
/*				      IFILLER10N,                                             */
/*				      IFILLER20N,                                             */
/*				      IFILLER50N,                                             */
/*				      IEDGELN,                                                */
/*				      IEDGERN,                                                */
/*				      ICORNERN.                                               */
/*                                                                                            */
/*    2. The input to output delay time 50ns in ICLK is just a possible value.                */
/*       In actual circuit, the phase variation will make the delay time uncertain.           */
/*                                                                                            */
/*    3. ICLK has LPF function. Only clock signal with pulse width >25ns can be passed.       */
/*                                                                                            */
/*    Revision History:                                                                       */
/*       * Version *   Date   * Description *                                                 */
/*       * 0.1     *2019/01/23* Initiated.  *                                                 */
/**********************************************************************************************/



`celldefine
`timescale 1ns/10ps

module IDIO(DIN, DOUT, SPAD, ENO, PU1, PU2, OD, ENI);
input DOUT,
      ENO, 
      PU1,
      PU2,
      OD,
      ENI;      
output DIN;
inout SPAD;

wire WIRE_DIN_IN, pu_in, OD_DOUT, WIRE_DOUT, WIRE_DOUT2;

assign pu_in = PU1 || PU2;

and a1 (OD_DOUT, OD, DOUT);
bufif1 (WIRE_DOUT, DOUT, ENO);
pmos p1 (WIRE_DOUT2, WIRE_DOUT, OD_DOUT); 
assign SPAD=WIRE_DOUT2; 

and a2 (WIRE_DIN_IN, SPAD, ENI);
assign DIN=WIRE_DIN_IN; 
//buf buf1 (WIRE_DIN_IN, SPAD);
//bufif1 (SPAD, DOUT, ENO);

//assign DIN=WIRE_DIN_IN; 

nmos pu1 (SPAD, pu_node, pu_in);
pullup (pull1, strong0) PUP (pu_node);


always @(PU1 or PU2)
begin
  if ((PU1==0)&&(PU2==1) )
    begin
      $display("ERROR! This condition is forbidden");
    end
end


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

module IRSTB(DIN, DIN_HV, SPAD);
input SPAD;
output DIN, DIN_HV;
wire SPAD, DIN, DIN_HV;

assign DIN = SPAD;
assign DIN_HV = SPAD;
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

module ICLK(DIN, DINP, SPAD);
input SPAD;
output DIN, DINP;
wire temp1;
reg temp2;

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

module IANA(A);
     
inout A;

wire A;

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IVDD(VDD);

   inout VDD;
  
   supply1 VDD;
   
   assign VDD = VDD;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IVDDIO(VDDIO);

   inout VDDIO;
   
   supply1 VDDIO;
   
   assign VDDIO = VDDIO;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IVSS(VSS);

   inout VSS;
   
   supply0 VSS;
   
   assign VSS = VSS;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER0N();
   
   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER1N();

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER5N();

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER10N();

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER20N();

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IFILLER50N();

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IEDGELN(VDDIO,VDD,VSS);

   inout VDDIO,VDD,VSS;
   supply1 VDDIO;
   supply1 VDD;
   supply0 VSS;

   specify
   endspecify

endmodule
`endcelldefine


`celldefine
`timescale 1ns/10ps
module IEDGERN(VDDIO,VDD,VSS);

   inout VDDIO,VDD,VSS;
   supply1 VDDIO;
   supply1 VDD;
   supply0 VSS;

   specify
   endspecify

endmodule
`endcelldefine

`celldefine
`timescale 1ns/10ps
module ICORNERN ();

   specify
   endspecify

endmodule
`endcelldefine
