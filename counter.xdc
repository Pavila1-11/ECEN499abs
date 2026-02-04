
## Clock (125 MHz)
set_property PACKAGE_PIN K17 [get_ports CLOCK]
set_property IOSTANDARD LVCMOS33 [get_ports CLOCK]

## Buttons
## (Use the pins your lab / master XDC specifies for BTN0, BTN1, RESET.)

set_property PACKAGE_PIN K18 [get_ports BTN0_UP]
set_property IOSTANDARD LVCMOS33 [get_ports BTN0_UP]

set_property PACKAGE_PIN P16 [get_ports BTN1_DOWN]
set_property IOSTANDARD LVCMOS33 [get_ports BTN1_DOWN]

set_property PACKAGE_PIN K19 [get_ports RESET]
set_property IOSTANDARD LVCMOS33 [get_ports RESET]

## LEDs 0–3
set_property PACKAGE_PIN M14 [get_ports {LEDS[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[0]}]

set_property PACKAGE_PIN M15 [get_ports {LEDS[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[1]}]

set_property PACKAGE_PIN G14 [get_ports {LEDS[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[2]}]

set_property PACKAGE_PIN D18 [get_ports {LEDS[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDS[3]}]
