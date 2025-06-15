################################################################################
# IO constraints
################################################################################
# clk48:0
set_property LOC D4 [get_ports {clk_osc}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk_osc}]

# led:0
set_property LOC J16 [get_ports {led}]
set_property IOSTANDARD LVCMOS33 [get_ports {led}]

# sys_rst_n:0
#set_property LOC P14 [get_ports {uart_rx[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {uart_rx[1]}]
set_property LOC P14 [get_ports {sys_rst_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {sys_rst_n}]

# aud_optical:0
set_property LOC B1 [get_ports {uart_tx[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {uart_tx[1]}]

# pmod_a1:0
#set_property LOC P15 [get_ports {pmod_a1}]
#set_property IOSTANDARD LVCMOS33 [get_ports {pmod_a1}]
set_property LOC P15 [get_ports {uart_rx[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {uart_rx[1]}]

# pmod_a2:0
#set_property LOC R16 [get_ports {pmod_a2}]
#set_property IOSTANDARD LVCMOS33 [get_ports {pmod_a2}]

# pmod_a3:0
#set_property LOC R15 [get_ports {pmod_a3}]
#set_property IOSTANDARD LVCMOS33 [get_ports {pmod_a3}]

# pmod_a4:0
set_property LOC T15 [get_ports {pmod_a4}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmod_a4}]

# pmod_a7:0
set_property LOC N16 [get_ports {pmod_a7}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmod_a7}]

# pmod_a8:0
set_property LOC P16 [get_ports {pmod_a8}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmod_a8}]

# pmod_a9:0
set_property LOC M15 [get_ports {pmod_a9}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmod_a9}]

# pmod_a10:0
set_property LOC M16 [get_ports {pmod_a10}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmod_a10}]

# sdram_clk:0
set_property LOC C8 [get_ports {sdram_clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_clk}]

# serial:0.tx
set_property LOC R16 [get_ports {uart_tx[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {uart_tx[0]}]

# serial:0.rx
set_property LOC R15 [get_ports {uart_rx[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {uart_rx[0]}]

# sdram:0.a
set_property LOC D15 [get_ports {sdram_addr[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[0]}]

# sdram:0.a
set_property LOC D16 [get_ports {sdram_addr[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[1]}]

# sdram:0.a
set_property LOC E15 [get_ports {sdram_addr[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[2]}]

# sdram:0.a
set_property LOC E16 [get_ports {sdram_addr[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[3]}]

# sdram:0.a
set_property LOC C9 [get_ports {sdram_addr[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[4]}]

# sdram:0.a
set_property LOC D9 [get_ports {sdram_addr[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[5]}]

# sdram:0.a
set_property LOC D8 [get_ports {sdram_addr[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[6]}]

# sdram:0.a
set_property LOC C7 [get_ports {sdram_addr[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[7]}]

# sdram:0.a
set_property LOC E6 [get_ports {sdram_addr[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[8]}]

# sdram:0.a
set_property LOC D6 [get_ports {sdram_addr[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[9]}]

# sdram:0.a
set_property LOC C16 [get_ports {sdram_addr[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[10]}]

# sdram:0.a
set_property LOC D5 [get_ports {sdram_addr[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[11]}]

# sdram:0.a
set_property LOC E5 [get_ports {sdram_addr[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_addr[12]}]

# sdram:0.ba
set_property LOC B9 [get_ports {sdram_ba[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_ba[0]}]

# sdram:0.ba
set_property LOC A8 [get_ports {sdram_ba[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_ba[1]}]

# sdram:0.cs_n
set_property LOC A9 [get_ports {sdram_csn}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_csn}]

# sdram:0.cke
set_property LOC C4 [get_ports {sdram_cke}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_cke}]

# sdram:0.ras_n
set_property LOC B10 [get_ports {sdram_rasn}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_rasn}]

# sdram:0.cas_n
set_property LOC A10 [get_ports {sdram_casn}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_casn}]

# sdram:0.we_n
set_property LOC B11 [get_ports {sdram_wen}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_wen}]

# sdram:0.dq
set_property LOC B16 [get_ports {sdram_dq[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[0]}]

# sdram:0.dq
set_property LOC A15 [get_ports {sdram_dq[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[1]}]

# sdram:0.dq
set_property LOC B15 [get_ports {sdram_dq[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[2]}]

# sdram:0.dq
set_property LOC A14 [get_ports {sdram_dq[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[3]}]

# sdram:0.dq
set_property LOC B14 [get_ports {sdram_dq[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[4]}]

# sdram:0.dq
set_property LOC A13 [get_ports {sdram_dq[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[5]}]

# sdram:0.dq
set_property LOC C13 [get_ports {sdram_dq[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[6]}]

# sdram:0.dq
set_property LOC A12 [get_ports {sdram_dq[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[7]}]

# sdram:0.dq
set_property LOC B6 [get_ports {sdram_dq[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[8]}]

# sdram:0.dq
set_property LOC C6 [get_ports {sdram_dq[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[9]}]

# sdram:0.dq
set_property LOC A5 [get_ports {sdram_dq[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[10]}]

# sdram:0.dq
set_property LOC B5 [get_ports {sdram_dq[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[11]}]

# sdram:0.dq
set_property LOC A4 [get_ports {sdram_dq[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[12]}]

# sdram:0.dq
set_property LOC B4 [get_ports {sdram_dq[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[13]}]

# sdram:0.dq
set_property LOC C3 [get_ports {sdram_dq[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[14]}]

# sdram:0.dq
set_property LOC A3 [get_ports {sdram_dq[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dq[15]}]

# sdram:0.dm
set_property LOC B12 [get_ports {sdram_dqm[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dqm[0]}]

# sdram:0.dm
set_property LOC A7 [get_ports {sdram_dqm[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdram_dqm[1]}]

# sdcard:0.cd
#set_property LOC J15 [get_ports {sdcard_cd}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_cd}]
#
## sdcard:0.clk
#set_property LOC G16 [get_ports {sdcard_clk}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_clk}]
#
## sdcard:0.cmd
#set_property LOC F14 [get_ports {sdcard_cmd}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_cmd}]
#
## sdcard:0.data
#set_property LOC G15 [get_ports {sdcard_data[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_data[0]}]
#
## sdcard:0.data
#set_property LOC H16 [get_ports {sdcard_data[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_data[1]}]
#
## sdcard:0.data
#set_property LOC E13 [get_ports {sdcard_data[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_data[2]}]
#
## sdcard:0.data
#set_property LOC F15 [get_ports {sdcard_data[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sdcard_data[3]}]

# SPI Chip Select (CS)
set_property LOC F15 [get_ports {spi_cen0}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_cen0}]

# SPI Clock (SCLK)
set_property LOC G16 [get_ports {spi_sclk0}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_sclk0}]

# SPI MOSI (Master Out, Slave In)
set_property LOC F14 [get_ports {spi_sio0_si_mosi0}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_sio0_si_mosi0}]

# SPI MISO (Master In, Slave Out)
set_property LOC G15 [get_ports {spi_sio1_so_miso0}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_sio1_so_miso0}]


################################################################################
# Design constraints
################################################################################

################################################################################
# Clock constraints
################################################################################


create_clock -name clk48 -period 20.833 [get_ports clk48]

################################################################################
# False path constraints
################################################################################


set_false_path -quiet -through [get_nets -hierarchical -filter {mr_ff == TRUE}]

set_false_path -quiet -to [get_pins -filter {REF_PIN_NAME == PRE} -of_objects [get_cells -hierarchical -filter {ars_ff1 == TRUE || ars_ff2 == TRUE}]]

set_max_delay 2 -quiet -from [get_pins -filter {REF_PIN_NAME == C} -of_objects [get_cells -hierarchical -filter {ars_ff1 == TRUE}]] -to [get_pins -filter {REF_PIN_NAME == D} -of_objects [get_cells -hierarchical -filter {ars_ff2 == TRUE}]]
