//-----------------------------------------------------------
//  This file created by: membistpVerify
//      Software version: 2017.1      Mon Feb 27 18:45:32 GMT 2017
//            Created on: 02/01/19 13:44:14
//-----------------------------------------------------------
//=============================================================================
//
//  File        :  membistpv_P1_SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_ClockMon.vb
//  Description :  Clock Monitor module for pattern membistpv_P1_SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY
//
//=============================================================================
//
// By default the clock monitoring is enabled.
// To disable clock monitoring define one of the following macros:
//   DISABLE_CLOCK_MONITOR
//   membistpv_P1_SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_DISABLE_CLOCK_MONITOR
//
`timescale 100fs/10fs
module membistpv_P1_SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_ClockMon;
 
integer number_clock_cycles;
event   start_monitor_clocks;
event   stop_monitor_clocks;
 
`define ENABLE_CLOCK_MONITOR
`ifdef DISABLE_CLOCK_MONITOR
    `undef ENABLE_CLOCK_MONITOR
`endif
`ifdef membistpv_P1_SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_DISABLE_CLOCK_MONITOR
    `undef ENABLE_CLOCK_MONITOR
`endif
`ifdef ENABLE_CLOCK_MONITOR
// [start] : Signal declarations {{{
time    CLOCK_0_start_time;
time    CLOCK_0_measured_period;
time    CLOCK_0_expected_period;
integer CLOCK_0_cycle_counter;
reg     CLOCK_0_complete;
wire    CLOCK_0_clkNet;
 
// [end]   : Signal declarations }}}
 
// Assign the clock nets we are monitoring
assign  CLOCK_0_clkNet             = TB.CHIP.SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.SMARCHCHKB_MBIST_CTRL.BIST_CLK ;
`endif
 
// [start] : Initialize some signals {{{
initial begin
  $timeformat(-9, 3, " ns", 10);
`ifdef ENABLE_CLOCK_MONITOR
  number_clock_cycles   = 10;
 
  CLOCK_0_cycle_counter             = 0;
  CLOCK_0_complete                 <= 0;
  CLOCK_0_expected_period           = 50000.0;  // 1ns -> 100fs scale
 
`endif
end
// [end]   : Initialize some signals }}}
 
// Display Results when monitoring is over
//----------------------------------------
always @(stop_monitor_clocks) begin
`ifdef ENABLE_CLOCK_MONITOR
    $display ($time, " Clock Monitoring results");
    $display ($time, " ------------------------");
    // [start] : SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.SMARCHCHKB_MBIST_CTRL.BIST_CLK {{{
    if (CLOCK_0_complete) begin
      if (( CLOCK_0_measured_period > CLOCK_0_expected_period * 1.01) | ( CLOCK_0_measured_period < CLOCK_0_expected_period * 0.99 )) begin
        $display ($time,
            "   Compare fail: SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.SMARCHCHKB_MBIST_CTRL.BIST_CLK Period expect = %t actual = %t",
            CLOCK_0_expected_period, CLOCK_0_measured_period);
        increment_compareFailures;
      end else begin
        $display ($time,
            "   SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.SMARCHCHKB_MBIST_CTRL.BIST_CLK Period  = %t as expected (within 1.0%% margin of %t) ", CLOCK_0_measured_period,CLOCK_0_expected_period);
        increment_compareEvents;
      end
    end else begin
      if (CLOCK_0_cycle_counter == 0 ) begin
        $display ($time,
            "   Compare fail: SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.SMARCHCHKB_MBIST_CTRL.BIST_CLK Period expect = %t actual = n/a ( no transition detected )",
            CLOCK_0_expected_period);
        increment_compareFailures;
      end else begin
        $display ($time,
            "   Compare fail: SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.SMARCHCHKB_MBIST_CTRL.BIST_CLK Period expect = %t actual = %t ( did not receive the expected %0d cycles)",
            CLOCK_0_expected_period,($time - CLOCK_0_start_time) / number_clock_cycles, number_clock_cycles);
        increment_compareFailures;
      end
    end
    // [end]   : SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.SMARCHCHKB_MBIST_CTRL.BIST_CLK }}}
    $display ($time, "");
`endif
end
`ifdef ENABLE_CLOCK_MONITOR
// [start] : SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.SMARCHCHKB_MBIST_CTRL.BIST_CLK {{{
always @(start_monitor_clocks) begin
  forever begin
    @(posedge CLOCK_0_clkNet) begin
      if (~CLOCK_0_complete) begin
        if ( CLOCK_0_cycle_counter == 0 ) begin
          CLOCK_0_start_time = $time;
        end
        if ( CLOCK_0_cycle_counter >= number_clock_cycles ) begin
          CLOCK_0_complete <= 1'b1;
          CLOCK_0_measured_period = ($time - CLOCK_0_start_time) / number_clock_cycles;
        end else begin
          CLOCK_0_cycle_counter = CLOCK_0_cycle_counter + 1;
        end
      end
    end
  end
end
// [end]   : SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.SMARCHCHKB_MBIST_CTRL.BIST_CLK }}}
`endif
 
task increment_compareEvents;
    TB.checker_inst.number_compareEvents = TB.checker_inst.number_compareEvents + 1;
endtask
task increment_compareFailures;
begin
    TB.checker_inst.number_compareEvents = TB.checker_inst.number_compareEvents + 1;
    TB.checker_inst.number_compareFailures = TB.checker_inst.number_compareFailures + 1;
end
endtask
 
endmodule
