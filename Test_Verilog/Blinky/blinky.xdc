# Purpose: Set CLOCK, LED, and DIP switch set up on NEXYS A7 100T

## Clock Signal
set_property -dict { PACKAGE_PIN E3  IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; # IO_L12P_T1_MRCC_35 Sch = clk100mhz
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}];

## Switch

set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports { SW_0 }]; # IO_L24N_T3_RS0_15 Sch=sw[0]

## LED
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { LED_0 }]; # IO_L18P_T2_A24_15 Sch=led[0]
