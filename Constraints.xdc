## Clock 100MHz
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk -period 10.00 -waveform {0 5} [get_ports clk]

## Reset (Center Button)
set_property PACKAGE_PIN N17 [get_ports btnC]
set_property IOSTANDARD LVCMOS33 [get_ports btnC]

## Start (Up Button)
set_property PACKAGE_PIN M18 [get_ports btnU] 
set_property IOSTANDARD LVCMOS33 [get_ports btnU]

## LEDs
set_property PACKAGE_PIN H17 [get_ports led0]
set_property IOSTANDARD LVCMOS33 [get_ports led0]

set_property PACKAGE_PIN K15 [get_ports led1]
set_property IOSTANDARD LVCMOS33 [get_ports led1]


