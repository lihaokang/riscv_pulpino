// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`include "apb_bus.sv"

module periph_bus_wrap
  #(
    parameter APB_ADDR_WIDTH = 32,
    parameter APB_DATA_WIDTH = 32
    )
   (
    input logic       clk_i,
    input logic       rst_ni,

    APB_BUS.Slave     apb_slave,

    APB_BUS.Master    uart_master,
    APB_BUS.Master    gpio_master,
    APB_BUS.Master    spi_master,
    APB_BUS.Master    timer_master,
    APB_BUS.Master    pwm_master,
    APB_BUS.Master    event_unit_master,
    APB_BUS.Master    i2c_master,
 
    APB_BUS.Master    soc_ctrl_master,

	APB_BUS.Master    iom_master,

	APB_BUS.Master    adc_master,
	APB_BUS.Master    wdt_master,
	APB_BUS.Master    rtc_master,
	APB_BUS.Master    scu_master,
	APB_BUS.Master    calib_master,

	APB_BUS.Master    uart1_master,
	APB_BUS.Master    uart2_master,
	APB_BUS.Master    uart3_master,
	APB_BUS.Master    uart4_master,
	APB_BUS.Master    uart5_master,
	APB_BUS.Master    i2c1_master,
	APB_BUS.Master    i2c2_master,
	APB_BUS.Master    i2c3_master,
	APB_BUS.Master    i2c4_master,
	APB_BUS.Master    i2c5_master,
	APB_BUS.Master    spi1_master,

    APB_BUS.Master    debug_master

    );

  localparam NB_MASTER      = `NB_MASTER;

  logic [NB_MASTER-1:0][APB_ADDR_WIDTH-1:0] s_start_addr;
  logic [NB_MASTER-1:0][APB_ADDR_WIDTH-1:0] s_end_addr;

  APB_BUS
    #(
      .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
      .APB_DATA_WIDTH(APB_DATA_WIDTH)
      )
  s_masters[NB_MASTER-1:0]();

  APB_BUS
    #(
      .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
      .APB_DATA_WIDTH(APB_DATA_WIDTH)
      )
  s_slave();

  `APB_ASSIGN_SLAVE(s_slave, apb_slave);

  `APB_ASSIGN_MASTER(s_masters[0], uart_master);
  assign s_start_addr[0] = `UART_START_ADDR;
  assign s_end_addr[0]   = `UART_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[1], gpio_master);
  assign s_start_addr[1] = `GPIO_START_ADDR;
  assign s_end_addr[1]   = `GPIO_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[2], spi_master);
  assign s_start_addr[2] = `SPI_START_ADDR;
  assign s_end_addr[2]   = `SPI_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[3], timer_master);
  assign s_start_addr[3] = `TIMER_START_ADDR;
  assign s_end_addr[3]   = `TIMER_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[4], event_unit_master);
  assign s_start_addr[4] = `EVENT_UNIT_START_ADDR;
  assign s_end_addr[4]   = `EVENT_UNIT_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[5], i2c_master);
  assign s_start_addr[5] = `I2C_START_ADDR;
  assign s_end_addr[5]   = `I2C_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[6], soc_ctrl_master);
  assign s_start_addr[6] = `SOC_CTRL_START_ADDR;
  assign s_end_addr[6]   = `SOC_CTRL_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[7], debug_master);
  assign s_start_addr[7] = `DEBUG_START_ADDR;
  assign s_end_addr[7]   = `DEBUG_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[8], wdt_master);
  assign s_start_addr[8] = `WDT_START_ADDR;
  assign s_end_addr[8]   = `WDT_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[9], rtc_master);
  assign s_start_addr[9] = `RTC_START_ADDR;
  assign s_end_addr[9]   = `RTC_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[10], calib_master);
  assign s_start_addr[10] = `CALIB_START_ADDR;
  assign s_end_addr[10]   = `CALIB_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[11], scu_master);
  assign s_start_addr[11] = `SCU_START_ADDR;
  assign s_end_addr[11]   = `SCU_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[12], adc_master);
  assign s_start_addr[12] = `ADC_START_ADDR;
  assign s_end_addr[12]   = `ADC_END_ADDR;

//PERIPH_IP
  `APB_ASSIGN_MASTER(s_masters[13], uart1_master);
  assign s_start_addr[13] = `UART1_START_ADDR;
  assign s_end_addr[13]   = `UART1_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[14], uart2_master);
  assign s_start_addr[14] = `UART2_START_ADDR;
  assign s_end_addr[14]   = `UART2_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[15], uart3_master);
  assign s_start_addr[15] = `UART3_START_ADDR;
  assign s_end_addr[15]   = `UART3_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[16], uart4_master);
  assign s_start_addr[16] = `UART4_START_ADDR;
  assign s_end_addr[16]   = `UART4_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[17], uart5_master);
  assign s_start_addr[17] = `UART5_START_ADDR;
  assign s_end_addr[17]   = `UART5_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[18], i2c1_master);
  assign s_start_addr[18] = `I2C1_START_ADDR;
  assign s_end_addr[18]   = `I2C1_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[19], i2c2_master);
  assign s_start_addr[19] = `I2C2_START_ADDR;
  assign s_end_addr[19]   = `I2C2_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[20], i2c3_master);
  assign s_start_addr[20] = `I2C3_START_ADDR;
  assign s_end_addr[20]   = `I2C3_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[21], i2c4_master);
  assign s_start_addr[21] = `I2C4_START_ADDR;
  assign s_end_addr[21]   = `I2C4_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[22], i2c5_master);
  assign s_start_addr[22] = `I2C5_START_ADDR;
  assign s_end_addr[22]   = `I2C5_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[23], spi1_master);
  assign s_start_addr[23] = `SPI1_START_ADDR;
  assign s_end_addr[23]   = `SPI1_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[24], iom_master);
  assign s_start_addr[24] = `IOM_START_ADDR;
  assign s_end_addr[24]   = `IOM_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[25], pwm_master);
  assign s_start_addr[25] = `PWM_START_ADDR;
  assign s_end_addr[25]   = `PWM_END_ADDR;
  
  //********************************************************
  //**************** SOC BUS *******************************
  //********************************************************

  apb_node_wrap
  #(
    .NB_MASTER      ( NB_MASTER      ),
    .APB_ADDR_WIDTH ( APB_ADDR_WIDTH ),
    .APB_DATA_WIDTH ( APB_DATA_WIDTH )
  )
  apb_node_wrap_i
  (
    .clk_i        ( clk_i        ),
    .rst_ni       ( rst_ni       ),

    .apb_slave    ( s_slave      ),
    .apb_masters  ( s_masters    ),

    .start_addr_i ( s_start_addr ),
    .end_addr_i   ( s_end_addr   )
  );

endmodule
