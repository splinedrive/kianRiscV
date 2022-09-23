#### This file is a general .xdc for the Genesys 2 Rev. H
#### To use it in a project:
#### - uncomment the lines corresponding to used pins
#### - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock Signal
#set_property -dict { PACKAGE_PIN AD11  IOSTANDARD LVDS     } [get_ports { sysclk_n }]; #IO_L12N_T1_MRCC_33 Sch=sysclk_n
#set_property -dict { PACKAGE_PIN AD12  IOSTANDARD LVDS     } [get_ports { sysclk_p }]; #IO_L12P_T1_MRCC_33 Sch=sysclk_p
set_property -dict { PACKAGE_PIN AD11  IOSTANDARD LVDS     } [get_ports { clk200mhz_n }]; #IO_L12N_T1_MRCC_33 Sch=sysclk_n
set_property -dict { PACKAGE_PIN AD12  IOSTANDARD LVDS     } [get_ports { clk200mhz_p }]; #IO_L12P_T1_MRCC_33 Sch=sysclk_p
create_clock -period 5 -waveform {0 2.5} -name clk200mhz_p [get_ports clk200mhz_p]
create_clock -period 5 -waveform {2.5 5} -name clk200mhz_n [get_ports clk200mhz_n]


## Buttons
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS12 } [get_ports { btnc }]; #IO_25_17 Sch=btnc
#set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS12 } [get_ports { btnd }]; #IO_0_15 Sch=btnd
#set_property -dict { PACKAGE_PIN M20   IOSTANDARD LVCMOS12 } [get_ports { btnl }]; #IO_L6P_T0_15 Sch=btnl
#set_property -dict { PACKAGE_PIN C19   IOSTANDARD LVCMOS12 } [get_ports { btnr }]; #IO_L24P_T3_17 Sch=btnr
#set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS12 } [get_ports { btnu }]; #IO_L24N_T3_17 Sch=btnu
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { cpu_resetn }]; #IO_0_14 Sch=cpu_resetn

## LEDs
#set_property -dict { PACKAGE_PIN T28   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L11N_T1_SRCC_14 Sch=led[0]
#set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L19P_T3_A10_D26_14 Sch=led[1]
#set_property -dict { PACKAGE_PIN U30   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=led[2]
#set_property -dict { PACKAGE_PIN U29   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=led[3]
#set_property -dict { PACKAGE_PIN V20   IOSTANDARD LVCMOS33 } [get_ports { led[4] }]; #IO_L19N_T3_A09_D25_VREF_14 Sch=led[4]
#set_property -dict { PACKAGE_PIN V26   IOSTANDARD LVCMOS33 } [get_ports { led[5] }]; #IO_L16P_T2_CSI_B_14 Sch=led[5]
#set_property -dict { PACKAGE_PIN W24   IOSTANDARD LVCMOS33 } [get_ports { led[6] }]; #IO_L20N_T3_A07_D23_14 Sch=led[6]
#set_property -dict { PACKAGE_PIN W23   IOSTANDARD LVCMOS33 } [get_ports { led[7] }]; #IO_L20P_T3_A08_D24_14 Sch=led[7]

set_property -dict { PACKAGE_PIN T28   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L11N_T1_SRCC_14 Sch=led[0]
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L19P_T3_A10_D26_14 Sch=led[1]
set_property -dict { PACKAGE_PIN U30   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=led[2]
set_property -dict { PACKAGE_PIN U29   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=led[3]
set_property -dict { PACKAGE_PIN V20   IOSTANDARD LVCMOS33 } [get_ports { led[4] }]; #IO_L19N_T3_A09_D25_VREF_14 Sch=led[4]
set_property -dict { PACKAGE_PIN V26   IOSTANDARD LVCMOS33 } [get_ports { led[5] }]; #IO_L16P_T2_CSI_B_14 Sch=led[5]
set_property -dict { PACKAGE_PIN W24   IOSTANDARD LVCMOS33 } [get_ports { led[6] }]; #IO_L20N_T3_A07_D23_14 Sch=led[6]
set_property -dict { PACKAGE_PIN W23   IOSTANDARD LVCMOS33 } [get_ports { led[7] }]; #IO_L20P_T3_A08_D24_14 Sch=led[7]

## Switches
#set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS12 } [get_ports { sw[0] }]; #IO_0_17 Sch=sw[0]
#set_property -dict { PACKAGE_PIN G25   IOSTANDARD LVCMOS12 } [get_ports { sw[1] }]; #IO_25_16 Sch=sw[1]
#set_property -dict { PACKAGE_PIN H24   IOSTANDARD LVCMOS12 } [get_ports { sw[2] }]; #IO_L19P_T3_16 Sch=sw[2]
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS12 } [get_ports { sw[3] }]; #IO_L6P_T0_17 Sch=sw[3]
#set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS12 } [get_ports { sw[4] }]; #IO_L19P_T3_A22_15 Sch=sw[4]
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS12 } [get_ports { sw[5] }]; #IO_25_15 Sch=sw[5]
#set_property -dict { PACKAGE_PIN P26   IOSTANDARD LVCMOS33 } [get_ports { sw[6] }]; #IO_L10P_T1_D14_14 Sch=sw[6]
#set_property -dict { PACKAGE_PIN P27   IOSTANDARD LVCMOS33 } [get_ports { sw[7] }]; #IO_L8P_T1_D11_14 Sch=sw[7]

## USB HIDs For Both Mouse and Keyboard
#set_property -dict { PACKAGE_PIN AD23  IOSTANDARD LVCMOS33  PULLUP true } [get_ports { ps2_clk_0 }]; #IO_L12P_T1_MRCC_12 Sch=ps2_clk[0]
#set_property -dict { PACKAGE_PIN AE20  IOSTANDARD LVCMOS33  PULLUP true } [get_ports { ps2_data_0 }]; #IO_25_12 Sch=ps2_data[0]

## UART
#set_property -dict { PACKAGE_PIN Y23   IOSTANDARD LVCMOS33 } [get_ports { uart_rx_out }]; #IO_L1P_T0_12 Sch=uart_rx_out
#set_property -dict { PACKAGE_PIN Y20   IOSTANDARD LVCMOS33 } [get_ports { uart_tx_in }]; #IO_0_12 Sch=uart_tx_in
set_property -dict { PACKAGE_PIN Y23   IOSTANDARD LVCMOS33 } [get_ports { uart_tx }]; #IO_0_12 Sch=uart_tx_in

## SD Card
#set_property -dict { PACKAGE_PIN P28   IOSTANDARD LVCMOS33 } [get_ports { sd_cd }]; #IO_L8N_T1_D12_14 Sch=sd_cd
#set_property -dict { PACKAGE_PIN R29   IOSTANDARD LVCMOS33 } [get_ports { sd_cmd }]; #IO_L7N_T1_D10_14 Sch=sd_cmd
#set_property -dict { PACKAGE_PIN R26   IOSTANDARD LVCMOS33 } [get_ports { sd_d[0] }]; #IO_L10N_T1_D15_14 Sch=sd_dat[0]
#set_property -dict { PACKAGE_PIN R30   IOSTANDARD LVCMOS33 } [get_ports { sd_d[1] }]; #IO_L9P_T1_DQS_14 Sch=sd_dat[1]
#set_property -dict { PACKAGE_PIN P29   IOSTANDARD LVCMOS33 } [get_ports { sd_d[2] }]; #IO_L7P_T1_D09_14 Sch=sd_dat[2]
#set_property -dict { PACKAGE_PIN T30   IOSTANDARD LVCMOS33 } [get_ports { sd_d[3] }]; #IO_L9N_T1_DQS_D13_14 Sch=sd_dat[3]
#set_property -dict { PACKAGE_PIN AE24  IOSTANDARD LVCMOS33 } [get_ports { sd_reset }]; #IO_L12N_T1_MRCC_12 Sch=sd_reset
#set_property -dict { PACKAGE_PIN R28   IOSTANDARD LVCMOS33 } [get_ports { sd_sclk }]; #IO_L11P_T1_SRCC_14 Sch=sd_sclk

## Audio Codec
#set_property -dict { PACKAGE_PIN AH19  IOSTANDARD LVCMOS18 } [get_ports { aud_adc_sdata }]; #IO_L8N_T1_32 Sch=aud_adc_sdata
#set_property -dict { PACKAGE_PIN AD19  IOSTANDARD LVCMOS18 } [get_ports { aud_adr[0] }]; #IO_L10P_T1_32 Sch=aud_adr[0]
#set_property -dict { PACKAGE_PIN AG19  IOSTANDARD LVCMOS18 } [get_ports { aud_adr[1] }]; #IO_L8P_T1_32 Sch=aud_adr[1]
#set_property -dict { PACKAGE_PIN AG18  IOSTANDARD LVCMOS18 } [get_ports { aud_bclk }]; #IO_L11N_T1_SRCC_32 Sch=aud_bclk
#set_property -dict { PACKAGE_PIN AJ19  IOSTANDARD LVCMOS18 } [get_ports { aud_dac_sdata }]; #IO_L7P_T1_32 Sch=aud_dac_sdata
#set_property -dict { PACKAGE_PIN AJ18  IOSTANDARD LVCMOS18 } [get_ports { aud_lrclk }]; #IO_L9P_T1_DQS_32 Sch=aud_lrclk
#set_property -dict { PACKAGE_PIN AK19  IOSTANDARD LVCMOS18 } [get_ports { aud_mclk }]; #IO_L7N_T1_32 Sch=aud_mclk
#set_property -dict { PACKAGE_PIN AE19  IOSTANDARD LVCMOS18 } [get_ports { aud_scl }]; #IO_L10N_T1_32 Sch=aud_scl
#set_property -dict { PACKAGE_PIN AF18  IOSTANDARD LVCMOS18 } [get_ports { aud_sda }]; #IO_L11P_T1_SRCC_32 Sch=aud_sda

## Ethernet
#set_property -dict { PACKAGE_PIN AK16  IOSTANDARD LVCMOS18 } [get_ports { eth_int_b }]; #IO_L1P_T0_32 Sch=eth_intb
#set_property -dict { PACKAGE_PIN AF12  IOSTANDARD LVCMOS15 } [get_ports { eth_mdc }]; #IO_L23P_T3_33 Sch=eth_mdc
#set_property -dict { PACKAGE_PIN AG12  IOSTANDARD LVCMOS15 } [get_ports { eth_mdio }]; #IO_L23N_T3_33 Sch=eth_mdio
#set_property -dict { PACKAGE_PIN AH24  IOSTANDARD LVCMOS33 } [get_ports { ETH_PHYRST_N }]; #IO_L14N_T2_SRCC_12 Sch=eth_phyrst_n
#set_property -dict { PACKAGE_PIN AK15  IOSTANDARD LVCMOS18 } [get_ports { eth_pme_b }]; #IO_L1N_T0_32 Sch=eth_pmeb
#set_property -dict { PACKAGE_PIN AG10  IOSTANDARD LVCMOS15 } [get_ports { eth_rxck }]; #IO_L13P_T2_MRCC_33 Sch=eth_rx_clk
#set_property -dict { PACKAGE_PIN AH11  IOSTANDARD LVCMOS15 } [get_ports { eth_rxctl }]; #IO_L18P_T2_33 Sch=eth_rx_ctl
#set_property -dict { PACKAGE_PIN AJ14  IOSTANDARD LVCMOS15 } [get_ports { eth_rxd[0] }]; #IO_L21N_T3_DQS_33 Sch=eth_rx_d[0]
#set_property -dict { PACKAGE_PIN AH14  IOSTANDARD LVCMOS15 } [get_ports { eth_rxd[1] }]; #IO_L21P_T3_DQS_33 Sch=eth_rx_d[1]
#set_property -dict { PACKAGE_PIN AK13  IOSTANDARD LVCMOS15 } [get_ports { eth_rxd[2] }]; #IO_L20N_T3_33 Sch=eth_rx_d[2]
#set_property -dict { PACKAGE_PIN AJ13  IOSTANDARD LVCMOS15 } [get_ports { eth_rxd[3] }]; #IO_L22P_T3_33 Sch=eth_rx_d[3]
#set_property -dict { PACKAGE_PIN AE10  IOSTANDARD LVCMOS15 } [get_ports { eth_txck }]; #IO_L14P_T2_SRCC_33 Sch=eth_tx_clk
#set_property -dict { PACKAGE_PIN AJ12  IOSTANDARD LVCMOS15 } [get_ports { eth_txd[0] }]; #IO_L22N_T3_33 Sch=eth_tx_d[0]
#set_property -dict { PACKAGE_PIN AK11  IOSTANDARD LVCMOS15 } [get_ports { eth_txd[1] }]; #IO_L17P_T2_33 Sch=eth_tx_d[1]
#set_property -dict { PACKAGE_PIN AJ11  IOSTANDARD LVCMOS15 } [get_ports { eth_txd[2] }]; #IO_L18N_T2_33 Sch=eth_tx_d[2]
#set_property -dict { PACKAGE_PIN AK10  IOSTANDARD LVCMOS15 } [get_ports { eth_txd[3] }]; #IO_L17N_T2_33 Sch=eth_tx_d[3]
#set_property -dict { PACKAGE_PIN AK14  IOSTANDARD LVCMOS15 } [get_ports { ETH_TX_EN }]; #IO_L20P_T3_33 Sch=eth_tx_en

## VGA Connector
#set_property -dict { PACKAGE_PIN AH20  IOSTANDARD LVCMOS33 } [get_ports { vga_b[0] }]; #IO_L22N_T3_12 Sch=vga_b[3]
#set_property -dict { PACKAGE_PIN AG20  IOSTANDARD LVCMOS33 } [get_ports { vga_b[1] }]; #IO_L22P_T3_12 Sch=vga_b[4]
#set_property -dict { PACKAGE_PIN AF21  IOSTANDARD LVCMOS33 } [get_ports { vga_b[2] }]; #IO_L19N_T3_VREF_12 Sch=vga_b[5]
#set_property -dict { PACKAGE_PIN AK20  IOSTANDARD LVCMOS33 } [get_ports { vga_b[3] }]; #IO_L24P_T3_12 Sch=vga_b[6]
#set_property -dict { PACKAGE_PIN AG22  IOSTANDARD LVCMOS33 } [get_ports { vga_b[4] }]; #IO_L20P_T3_12 Sch=vga_b[7]

#set_property -dict { PACKAGE_PIN AJ23  IOSTANDARD LVCMOS33 } [get_ports { vga_g[0] }]; #IO_L21N_T3_DQS_12 Sch=vga_g[2]
#set_property -dict { PACKAGE_PIN AJ22  IOSTANDARD LVCMOS33 } [get_ports { vga_g[1] }]; #IO_L21P_T3_DQS_12 Sch=vga_g[3]
#set_property -dict { PACKAGE_PIN AH22  IOSTANDARD LVCMOS33 } [get_ports { vga_g[2] }]; #IO_L20N_T3_12 Sch=vga_g[4]
#set_property -dict { PACKAGE_PIN AK21  IOSTANDARD LVCMOS33 } [get_ports { vga_g[3] }]; #IO_L24N_T3_12 Sch=vga_g[5]
#set_property -dict { PACKAGE_PIN AJ21  IOSTANDARD LVCMOS33 } [get_ports { vga_g[4] }]; #IO_L23N_T3_12 Sch=vga_g[6]
#set_property -dict { PACKAGE_PIN AK23  IOSTANDARD LVCMOS33 } [get_ports { vga_g[5] }]; #IO_L17P_T2_12 Sch=vga_g[7]

#set_property -dict { PACKAGE_PIN AK25  IOSTANDARD LVCMOS33 } [get_ports { vga_r[0] }]; #IO_L15N_T2_DQS_12 Sch=vga_r[3]
#set_property -dict { PACKAGE_PIN AG25  IOSTANDARD LVCMOS33 } [get_ports { vga_r[1] }]; #IO_L18P_T2_12 Sch=vga_r[4]
#set_property -dict { PACKAGE_PIN AH25  IOSTANDARD LVCMOS33 } [get_ports { vga_r[2] }]; #IO_L18N_T2_12 Sch=vga_r[5]
#set_property -dict { PACKAGE_PIN AK24  IOSTANDARD LVCMOS33 } [get_ports { vga_r[3] }]; #IO_L17N_T2_12 Sch=vga_r[6]
#set_property -dict { PACKAGE_PIN AJ24  IOSTANDARD LVCMOS33 } [get_ports { vga_r[4] }]; #IO_L15P_T2_DQS_12 Sch=vga_r[7]

#set_property -dict { PACKAGE_PIN AF20  IOSTANDARD LVCMOS33 } [get_ports { vga_hs }]; #IO_L19P_T3_12 Sch=vga_hs
#set_property -dict { PACKAGE_PIN AG23  IOSTANDARD LVCMOS33 } [get_ports { vga_vs }]; #IO_L13N_T2_MRCC_12 Sch=vga_vs

## HDMI in
#set_property -dict { PACKAGE_PIN Y21   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_cec }]; #IO_L2P_T0_12 Sch=hdmi_rx_cec
#set_property -dict { PACKAGE_PIN AF28  IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_n }]; #IO_L14N_T2_SRCC_13 Sch=hdmi_rx_clk_n
#set_property -dict { PACKAGE_PIN AE28  IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_p }]; #IO_L14P_T2_SRCC_13 Sch=hdmi_rx_clk_p
#set_property -dict { PACKAGE_PIN AH29  IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_hpa }]; #IO_L13N_T2_MRCC_13 Sch=hdmi_rx_hpa
#set_property -dict { PACKAGE_PIN AJ28  IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_scl }]; #IO_L17P_T2_13 Sch=hdmi_rx_scl
#set_property -dict { PACKAGE_PIN AJ29  IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_sda }]; #IO_L17N_T2_13 Sch=hdmi_rx_sda
#set_property -dict { PACKAGE_PIN AK26  IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_n[0] }]; #IO_L24N_T3_13 Sch=hdmi_rx_n[0]
#set_property -dict { PACKAGE_PIN AJ26  IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_p[0] }]; #IO_L24P_T3_13 Sch=hdmi_rx_p[0]
#set_property -dict { PACKAGE_PIN AG28  IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_n[1] }]; #IO_L21N_T3_DQS_13 Sch=hdmi_rx_n[1]
#set_property -dict { PACKAGE_PIN AG27  IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_p[1] }]; #IO_L21P_T3_DQS_13 Sch=hdmi_rx_p[1]
#set_property -dict { PACKAGE_PIN AH27  IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_n[2] }]; #IO_L22N_T3_13 Sch=hdmi_rx_n[2]
#set_property -dict { PACKAGE_PIN AH26  IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_p[2] }]; #IO_L22P_T3_13 Sch=hdmi_rx_p[2]

## HDMI out
#set_property -dict { PACKAGE_PIN Y24   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_cec }]; #IO_L1N_T0_12 Sch=hdmi_tx_cec
#set_property -dict { PACKAGE_PIN AB20  IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_clk_n }]; #IO_L6N_T0_VREF_12 Sch=hdmi_tx_clk_n
#set_property -dict { PACKAGE_PIN AA20  IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_clk_p }]; #IO_L6P_T0_12 Sch=hdmi_tx_clk_p
#set_property -dict { PACKAGE_PIN AG29  IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_hpd }]; #IO_L13P_T2_MRCC_13 Sch=hdmi_tx_hpd
#set_property -dict { PACKAGE_PIN AF27  IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_scl }]; #IO_L23N_T3_13 Sch=hdmi_tx_scl
#set_property -dict { PACKAGE_PIN AF26  IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_sda }]; #IO_L23P_T3_13 Sch=hdmi_tx_sda
#set_property -dict { PACKAGE_PIN AC21  IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_n[0] }]; #IO_L5N_T0_12 Sch=hdmi_tx_n[0]
#set_property -dict { PACKAGE_PIN AC20  IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_p[0] }]; #IO_L5P_T0_12 Sch=hdmi_tx_p[0]
#set_property -dict { PACKAGE_PIN AA23  IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_n[1] }]; #IO_L4N_T0_12 Sch=hdmi_tx_n[1]
#set_property -dict { PACKAGE_PIN AA22  IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_p[1] }]; #IO_L4P_T0_12 Sch=hdmi_tx_p[1]
#set_property -dict { PACKAGE_PIN AC25  IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_n[2] }]; #IO_L7N_T1_12 Sch=hdmi_tx_n[2]
#set_property -dict { PACKAGE_PIN AB24  IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_p[2] }]; #IO_L7P_T1_12 Sch=hdmi_tx_p[2]
#set_property -dict { PACKAGE_PIN Y24   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_cec }]; #IO_L1N_T0_12 Sch=hdmi_tx_cec
#set_property -dict { PACKAGE_PIN AB20  IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_clk_n }]; #IO_L6N_T0_VREF_12 Sch=hdmi_tx_clk_n
#set_property -dict { PACKAGE_PIN AA20  IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_clk_p }]; #IO_L6P_T0_12 Sch=hdmi_tx_clk_p
#set_property -dict { PACKAGE_PIN AG29  IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_hpd }]; #IO_L13P_T2_MRCC_13 Sch=hdmi_tx_hpd
#set_property -dict { PACKAGE_PIN AF27  IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_scl }]; #IO_L23N_T3_13 Sch=hdmi_tx_scl
#set_property -dict { PACKAGE_PIN AF26  IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_sda }]; #IO_L23P_T3_13 Sch=hdmi_tx_sda
set_property -dict { PACKAGE_PIN AC21  IOSTANDARD TMDS_33  } [get_ports { hdmi_n[0] }]; #IO_L5N_T0_12 Sch=hdmi_tx_n[0]
set_property -dict { PACKAGE_PIN AC20  IOSTANDARD TMDS_33  } [get_ports { hdmi_p[0] }]; #IO_L5P_T0_12 Sch=hdmi_tx_p[0]
set_property -dict { PACKAGE_PIN AA23  IOSTANDARD TMDS_33  } [get_ports { hdmi_n[1] }]; #IO_L4N_T0_12 Sch=hdmi_tx_n[1]
set_property -dict { PACKAGE_PIN AA22  IOSTANDARD TMDS_33  } [get_ports { hdmi_p[1] }]; #IO_L4P_T0_12 Sch=hdmi_tx_p[1]
set_property -dict { PACKAGE_PIN AC25  IOSTANDARD TMDS_33  } [get_ports { hdmi_n[2] }]; #IO_L7N_T1_12 Sch=hdmi_tx_n[2]
set_property -dict { PACKAGE_PIN AB24  IOSTANDARD TMDS_33  } [get_ports { hdmi_p[2] }]; #IO_L7P_T1_12 Sch=hdmi_tx_p[2]
set_property -dict { PACKAGE_PIN AB20  IOSTANDARD TMDS_33  } [get_ports { hdmi_n[3]}]; #IO_L6N_T0_VREF_12 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN AA20  IOSTANDARD TMDS_33  } [get_ports { hdmi_p[3] }]; #IO_L6P_T0_12 Sch=hdmi_tx_clk_p

## OLED Display
#set_property -dict { PACKAGE_PIN AC17  IOSTANDARD LVCMOS18 } [get_ports { oled_dc }]; #IO_L18N_T2_32 Sch=oled_dc
#set_property -dict { PACKAGE_PIN AB17  IOSTANDARD LVCMOS18 } [get_ports { oled_res }]; #IO_L18P_T2_32 Sch=oled_res
#set_property -dict { PACKAGE_PIN AF17  IOSTANDARD LVCMOS18 } [get_ports { oled_sclk }]; #IO_L12P_T1_MRCC_32 Sch=oled_sclk
#set_property -dict { PACKAGE_PIN Y15   IOSTANDARD LVCMOS18 } [get_ports { oled_sdin }]; #IO_L24N_T3_32 Sch=oled_sdin
#set_property -dict { PACKAGE_PIN AB22  IOSTANDARD LVCMOS33 } [get_ports { oled_vbat }]; #IO_L3P_T0_DQS_12 Sch=oled_vbat
#set_property -dict { PACKAGE_PIN AG17  IOSTANDARD LVCMOS18 } [get_ports { oled_vdd }]; #IO_L12N_T1_MRCC_32 Sch=oled_vdd

## PMOD Header JA
#set_property -dict { PACKAGE_PIN U27   IOSTANDARD LVCMOS33 } [get_ports { ja[0] }]; #IO_L13P_T2_MRCC_14 Sch=ja_p[1]
#set_property -dict { PACKAGE_PIN U28   IOSTANDARD LVCMOS33 } [get_ports { ja[1] }]; #IO_L13N_T2_MRCC_14 Sch=ja_n[1]
#set_property -dict { PACKAGE_PIN T26   IOSTANDARD LVCMOS33 } [get_ports { ja[2] }]; #IO_L12P_T1_MRCC_14 Sch=ja_p[2]
#set_property -dict { PACKAGE_PIN T27   IOSTANDARD LVCMOS33 } [get_ports { ja[3] }]; #IO_L12N_T1_MRCC_14 Sch=ja_n[2]
#set_property -dict { PACKAGE_PIN T22   IOSTANDARD LVCMOS33 } [get_ports { ja[4] }]; #IO_L5P_T0_D06_14 Sch=ja_p[3]
#set_property -dict { PACKAGE_PIN T23   IOSTANDARD LVCMOS33 } [get_ports { ja[5] }]; #IO_L5N_T0_D07_14 Sch=ja_n[3]
#set_property -dict { PACKAGE_PIN T20   IOSTANDARD LVCMOS33 } [get_ports { ja[6] }]; #IO_L4P_T0_D04_14 Sch=ja_p[4]
#set_property -dict { PACKAGE_PIN T21   IOSTANDARD LVCMOS33 } [get_ports { ja[7] }]; #IO_L4N_T0_D05_14 Sch=ja_n[4]

## PMOD Header JB
#set_property -dict { PACKAGE_PIN V29   IOSTANDARD LVCMOS33 } [get_ports { jb[0] }]; #IO_L17P_T2_A14_D30_14 Sch=jb_p[1]
#set_property -dict { PACKAGE_PIN V30   IOSTANDARD LVCMOS33 } [get_ports { jb[1] }]; #IO_L17N_T2_A13_D29_14 Sch=jb_n[1]
#set_property -dict { PACKAGE_PIN V25   IOSTANDARD LVCMOS33 } [get_ports { jb[2] }]; #IO_L18P_T2_A12_D28_14 Sch=jb_p[2]
#set_property -dict { PACKAGE_PIN W26   IOSTANDARD LVCMOS33 } [get_ports { jb[3] }]; #IO_L18N_T2_A11_D27_14 Sch=jb_n[2]
#set_property -dict { PACKAGE_PIN T25   IOSTANDARD LVCMOS33 } [get_ports { jb[4] }]; #IO_L14P_T2_SRCC_14 Sch=jb_p[3]
#set_property -dict { PACKAGE_PIN U25   IOSTANDARD LVCMOS33 } [get_ports { jb[5] }]; #IO_L14N_T2_SRCC_14 Sch=jb_n[3]
#set_property -dict { PACKAGE_PIN U22   IOSTANDARD LVCMOS33 } [get_ports { jb[6] }]; #IO_L21P_T3_DQS_14 Sch=jb_p[4]
#set_property -dict { PACKAGE_PIN U23   IOSTANDARD LVCMOS33 } [get_ports { jb[7] }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=jb_n[4]
set_property -dict { PACKAGE_PIN V29   IOSTANDARD LVCMOS33 } [get_ports { gpio[0] }]; #IO_L17P_T2_A14_D30_14 Sch=jb_p[1]
set_property -dict { PACKAGE_PIN V30   IOSTANDARD LVCMOS33 } [get_ports { gpio[1] }]; #IO_L17N_T2_A13_D29_14 Sch=jb_n[1]
set_property -dict { PACKAGE_PIN V25   IOSTANDARD LVCMOS33 } [get_ports { gpio[2] }]; #IO_L18P_T2_A12_D28_14 Sch=jb_p[2]
set_property -dict { PACKAGE_PIN W26   IOSTANDARD LVCMOS33 } [get_ports { gpio[3] }]; #IO_L18N_T2_A11_D27_14 Sch=jb_n[2]
set_property -dict { PACKAGE_PIN T25   IOSTANDARD LVCMOS33 } [get_ports { gpio[4] }]; #IO_L14P_T2_SRCC_14 Sch=jb_p[3]
set_property -dict { PACKAGE_PIN U25   IOSTANDARD LVCMOS33 } [get_ports { gpio[5] }]; #IO_L14N_T2_SRCC_14 Sch=jb_n[3]
set_property -dict { PACKAGE_PIN U22   IOSTANDARD LVCMOS33 } [get_ports { gpio[6] }]; #IO_L21P_T3_DQS_14 Sch=jb_p[4]
set_property -dict { PACKAGE_PIN U23   IOSTANDARD LVCMOS33 } [get_ports { gpio[7] }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=jb_n[4]

## PMOD Header JC
#set_property -dict { PACKAGE_PIN AC26  IOSTANDARD LVCMOS33 } [get_ports { jc[0] }]; #IO_L19P_T3_13 Sch=jc[1]
#set_property -dict { PACKAGE_PIN AJ27  IOSTANDARD LVCMOS33 } [get_ports { jc[1] }]; #IO_L20P_T3_13 Sch=jc[2]
#set_property -dict { PACKAGE_PIN AH30  IOSTANDARD LVCMOS33 } [get_ports { jc[2] }]; #IO_L18N_T2_13 Sch=jc[3]
#set_property -dict { PACKAGE_PIN AK29  IOSTANDARD LVCMOS33 } [get_ports { jc[3] }]; #IO_L15P_T2_DQS_13 Sch=jc[4]
#set_property -dict { PACKAGE_PIN AD26  IOSTANDARD LVCMOS33 } [get_ports { jc[4] }]; #IO_L19N_T3_VREF_13 Sch=jc[7]
#set_property -dict { PACKAGE_PIN AG30  IOSTANDARD LVCMOS33 } [get_ports { jc[5] }]; #IO_L18P_T2_13 Sch=jc[8]
#set_property -dict { PACKAGE_PIN AK30  IOSTANDARD LVCMOS33 } [get_ports { jc[6] }]; #IO_L15N_T2_DQS_13 Sch=jc[9]
#set_property -dict { PACKAGE_PIN AK28  IOSTANDARD LVCMOS33 } [get_ports { jc[7] }]; #IO_L20N_T3_13 Sch=jc[10]

## PMOD Header JD
#set_property -dict { PACKAGE_PIN V27   IOSTANDARD LVCMOS33 } [get_ports { jd[0] }]; #IO_L16N_T2_A15_D31_14 Sch=jd[1]
#set_property -dict { PACKAGE_PIN Y30   IOSTANDARD LVCMOS33 } [get_ports { jd[1] }]; #IO_L8P_T1_13 Sch=jd[2]
#set_property -dict { PACKAGE_PIN V24   IOSTANDARD LVCMOS33 } [get_ports { jd[2] }]; #IO_L23N_T3_A02_D18_14 Sch=jd[3]
#set_property -dict { PACKAGE_PIN W22   IOSTANDARD LVCMOS33 } [get_ports { jd[3] }]; #IO_L24N_T3_A00_D16_14 Sch=jd[4]
#set_property -dict { PACKAGE_PIN U24   IOSTANDARD LVCMOS33 } [get_ports { jd[4] }]; #IO_L23P_T3_A03_D19_14 Sch=jd[7]
#set_property -dict { PACKAGE_PIN Y26   IOSTANDARD LVCMOS33 } [get_ports { jd[5] }]; #IO_L1P_T0_13 Sch=jd[8]
#set_property -dict { PACKAGE_PIN V22   IOSTANDARD LVCMOS33 } [get_ports { jd[6] }]; #IO_L22N_T3_A04_D20_14 Sch=jd[9]
#set_property -dict { PACKAGE_PIN W21   IOSTANDARD LVCMOS33 } [get_ports { jd[7] }]; #IO_L24P_T3_A01_D17_14 Sch=jd[10]

## XADC Header
#set_property -dict { PACKAGE_PIN J24   IOSTANDARD LVCMOS33 } [get_ports { xa_n[0] }]; #IO_L1N_T0_AD0N_15 Sch=xadc0r_n
#set_property -dict { PACKAGE_PIN J23   IOSTANDARD LVCMOS33 } [get_ports { xa_p[0] }]; #IO_L1P_T0_AD0P_15 Sch=xadc0r_p
#set_property -dict { PACKAGE_PIN K24   IOSTANDARD LVCMOS33 } [get_ports { xa_n[1] }]; #IO_L3N_T0_DQS_AD1N_15 Sch=xadc1r_n
#set_property -dict { PACKAGE_PIN K23   IOSTANDARD LVCMOS33 } [get_ports { xa_p[1] }]; #IO_L3P_T0_DQS_AD1P_15 Sch=xadc1r_p
#set_property -dict { PACKAGE_PIN L23   IOSTANDARD LVCMOS33 } [get_ports { xa_n[2] }]; #IO_L2N_T0_AD8N_15 Sch=xadc8r_n
#set_property -dict { PACKAGE_PIN L22   IOSTANDARD LVCMOS33 } [get_ports { xa_p[2] }]; #IO_L2P_T0_AD8P_15 Sch=xadc8r_p
#set_property -dict { PACKAGE_PIN K21   IOSTANDARD LVCMOS33 } [get_ports { xa_n[3] }]; #IO_L4N_T0_AD9N_15 Sch=xadc9r_n
#set_property -dict { PACKAGE_PIN L21   IOSTANDARD LVCMOS33 } [get_ports { xa_p[3] }]; #IO_L4P_T0_AD9P_15 Sch=xadc9r_p

## FMC
#set_property -dict { PACKAGE_PIN AB30  IOSTANDARD LVCMOS33 } [get_ports { FMC_CLK_DIR }]; #IO_L10N_T1_13 Sch=fmc_clk_dir
#set_property -dict { PACKAGE_PIN E20   IOSTANDARD LVCMOS12 } [get_ports { fmc_clk0_m2c_n }]; #IO_L12N_T1_MRCC_17 Sch=fmc_clk0_m2c_n
#set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS12 } [get_ports { fmc_clk0_m2c_p }]; #IO_L12P_T1_MRCC_17 Sch=fmc_clk0_m2c_p
#set_property -dict { PACKAGE_PIN D28   IOSTANDARD LVCMOS12 } [get_ports { fmc_clk1_m2c_n }]; #IO_L14N_T2_SRCC_16 Sch=fmc_clk1_m2c_n
#set_property -dict { PACKAGE_PIN E28   IOSTANDARD LVCMOS12 } [get_ports { fmc_clk1_m2c_p }]; #IO_L14P_T2_SRCC_16 Sch=fmc_clk1_m2c_p
#set_property -dict { PACKAGE_PIN K25   IOSTANDARD LVCMOS12 } [get_ports { FMC_CLK_N[2] }]; #IO_L12N_T1_MRCC_AD5N_15 Sch=fmc_clk_n[2]
#set_property -dict { PACKAGE_PIN L25   IOSTANDARD LVCMOS12 } [get_ports { FMC_CLK_P[2] }]; #IO_L12P_T1_MRCC_AD5P_15 Sch=fmc_clk_p[2]
#set_property -dict { PACKAGE_PIN K29   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[00] }]; #IO_L13N_T2_MRCC_15 Sch=fmc_ha_n[00]
#set_property -dict { PACKAGE_PIN K28   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[00] }]; #IO_L13P_T2_MRCC_15 Sch=fmc_ha_p[00]
#set_property -dict { PACKAGE_PIN L28   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[01] }]; #IO_L14N_T2_SRCC_15 Sch=fmc_ha_n[01]
#set_property -dict { PACKAGE_PIN M28   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[01] }]; #IO_L14P_T2_SRCC_15 Sch=fmc_ha_p[01]
#set_property -dict { PACKAGE_PIN P22   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[02] }]; #IO_L22N_T3_A16_15 Sch=fmc_ha_n[02]
#set_property -dict { PACKAGE_PIN P21   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[02] }]; #IO_L22P_T3_A17_15 Sch=fmc_ha_p[02]
#set_property -dict { PACKAGE_PIN N26   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[03] }]; #IO_L18N_T2_A23_15 Sch=fmc_ha_n[03]
#set_property -dict { PACKAGE_PIN N25   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[03] }]; #IO_L18P_T2_A24_15 Sch=fmc_ha_p[03]
#set_property -dict { PACKAGE_PIN M25   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[04] }]; #IO_L23N_T3_FWE_B_15 Sch=fmc_ha_n[04]
#set_property -dict { PACKAGE_PIN M24   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[04] }]; #IO_L23P_T3_FOE_B_15 Sch=fmc_ha_p[04]
#set_property -dict { PACKAGE_PIN H29   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[05] }]; #IO_L7N_T1_AD10N_15 Sch=fmc_ha_n[05]
#set_property -dict { PACKAGE_PIN J29   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[05] }]; #IO_L7P_T1_AD10P_15 Sch=fmc_ha_p[05]
#set_property -dict { PACKAGE_PIN N30   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[06] }]; #IO_L17N_T2_A25_15 Sch=fmc_ha_n[06]
#set_property -dict { PACKAGE_PIN N29   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[06] }]; #IO_L17P_T2_A26_15 Sch=fmc_ha_p[06]
#set_property -dict { PACKAGE_PIN M30   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[07] }]; #IO_L15N_T2_DQS_ADV_B_15 Sch=fmc_ha_n[07]
#set_property -dict { PACKAGE_PIN M29   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[07] }]; #IO_L15P_T2_DQS_15 Sch=fmc_ha_p[07]
#set_property -dict { PACKAGE_PIN J28   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[08] }]; #IO_L8N_T1_AD3N_15 Sch=fmc_ha_n[08]
#set_property -dict { PACKAGE_PIN J27   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[08] }]; #IO_L8P_T1_AD3P_15 Sch=fmc_ha_p[08]
#set_property -dict { PACKAGE_PIN K30   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[09] }]; #IO_L9N_T1_DQS_AD11N_15 Sch=fmc_ha_n[09]
#set_property -dict { PACKAGE_PIN L30   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[09] }]; #IO_L9P_T1_DQS_AD11P_15 Sch=fmc_ha_p[09]
#set_property -dict { PACKAGE_PIN N22   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[10] }]; #IO_L20N_T3_A19_15 Sch=fmc_ha_n[10]
#set_property -dict { PACKAGE_PIN N21   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[10] }]; #IO_L20P_T3_A20_15 Sch=fmc_ha_p[10]
#set_property -dict { PACKAGE_PIN N24   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[11] }]; #IO_L21N_T3_DQS_A18_15 Sch=fmc_ha_n[11]
#set_property -dict { PACKAGE_PIN P23   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[11] }]; #IO_L21P_T3_DQS_15 Sch=fmc_ha_p[11]
#set_property -dict { PACKAGE_PIN L27   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[12] }]; #IO_L11N_T1_SRCC_AD12N_15 Sch=fmc_ha_n[12]
#set_property -dict { PACKAGE_PIN L26   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[12] }]; #IO_L11P_T1_SRCC_AD12P_15 Sch=fmc_ha_p[12]
#set_property -dict { PACKAGE_PIN J26   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[13] }]; #IO_L10N_T1_AD4N_15 Sch=fmc_ha_n[13]
#set_property -dict { PACKAGE_PIN K26   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[13] }]; #IO_L10P_T1_AD4P_15 Sch=fmc_ha_p[13]
#set_property -dict { PACKAGE_PIN M27   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[14] }]; #IO_L16N_T2_A27_15 Sch=fmc_ha_n[14]
#set_property -dict { PACKAGE_PIN N27   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[14] }]; #IO_L16P_T2_A28_15 Sch=fmc_ha_p[14]
#set_property -dict { PACKAGE_PIN J22   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[15] }]; #IO_L5N_T0_AD2N_15 Sch=fmc_ha_n[15]
#set_property -dict { PACKAGE_PIN J21   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[15] }]; #IO_L5P_T0_AD2P_15 Sch=fmc_ha_p[15]
#set_property -dict { PACKAGE_PIN M23   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[16] }]; #IO_L24N_T3_RS0_15 Sch=fmc_ha_n[16]
#set_property -dict { PACKAGE_PIN M22   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[16] }]; #IO_L24P_T3_RS1_15 Sch=fmc_ha_p[16]
#set_property -dict { PACKAGE_PIN B25   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[17] }]; #IO_L12N_T1_MRCC_16 Sch=fmc_ha_n[17]
#set_property -dict { PACKAGE_PIN C25   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[17] }]; #IO_L12P_T1_MRCC_16 Sch=fmc_ha_p[17]
#set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[18] }]; #IO_L14N_T2_SRCC_17 Sch=fmc_ha_n[18]
#set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[18] }]; #IO_L14P_T2_SRCC_17 Sch=fmc_ha_p[18]
#set_property -dict { PACKAGE_PIN F30   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[19] }]; #IO_L22N_T3_16 Sch=fmc_ha_n[19]
#set_property -dict { PACKAGE_PIN G29   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[19] }]; #IO_L22P_T3_16 Sch=fmc_ha_p[19]
#set_property -dict { PACKAGE_PIN F27   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[20] }]; #IO_L21N_T3_DQS_16 Sch=fmc_ha_n[20]
#set_property -dict { PACKAGE_PIN G27   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[20] }]; #IO_L21P_T3_DQS_16 Sch=fmc_ha_p[20]
#set_property -dict { PACKAGE_PIN F28   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[21] }]; #IO_L20N_T3_16 Sch=fmc_ha_n[21]
#set_property -dict { PACKAGE_PIN G28   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[21] }]; #IO_L20P_T3_16 Sch=fmc_ha_p[21]
#set_property -dict { PACKAGE_PIN C21   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[22] }]; #IO_L8N_T1_17 Sch=fmc_ha_n[22]
#set_property -dict { PACKAGE_PIN D21   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[22] }]; #IO_L8P_T1_17 Sch=fmc_ha_p[22]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_N[23] }]; #IO_L16N_T2_17 Sch=fmc_ha_n[23]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS12 } [get_ports { FMC_HA_P[23] }]; #IO_L16P_T2_17 Sch=fmc_ha_p[23]
#set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[00] }]; #IO_L12N_T1_MRCC_18 Sch=fmc_hb_n[00]
#set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[00] }]; #IO_L12P_T1_MRCC_18 Sch=fmc_hb_p[00]
#set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[01] }]; #IO_L7N_T1_18 Sch=fmc_hb_n[01]
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[01] }]; #IO_L7P_T1_18 Sch=fmc_hb_p[01]
#set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[02] }]; #IO_L2N_T0_18 Sch=fmc_hb_n[02]
#set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[02] }]; #IO_L2P_T0_18 Sch=fmc_hb_p[02]
#set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[03] }]; #IO_L11N_T1_SRCC_18 Sch=fmc_hb_n[03]
#set_property -dict { PACKAGE_PIN H14   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[03] }]; #IO_L11P_T1_SRCC_18 Sch=fmc_hb_p[03]
#set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[04] }]; #IO_L9N_T1_DQS_18 Sch=fmc_hb_n[04]
#set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[04] }]; #IO_L9P_T1_DQS_18 Sch=fmc_hb_p[04]
#set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[05] }]; #IO_L1N_T0_18 Sch=fmc_hb_n[05]
#set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[05] }]; #IO_L1P_T0_18 Sch=fmc_hb_p[05]
#set_property -dict { PACKAGE_PIN E13   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[06] }]; #IO_L14N_T2_SRCC_18 Sch=fmc_hb_n[06]
#set_property -dict { PACKAGE_PIN F12   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[06] }]; #IO_L14P_T2_SRCC_18 Sch=fmc_hb_p[06]
#set_property -dict { PACKAGE_PIN A13   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[07] }]; #IO_L22N_T3_18 Sch=fmc_hb_n[07]
#set_property -dict { PACKAGE_PIN B13   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[07] }]; #IO_L22P_T3_18 Sch=fmc_hb_p[07]
#set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[08] }]; #IO_L5N_T0_18 Sch=fmc_hb_n[08]
#set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[08] }]; #IO_L5P_T0_18 Sch=fmc_hb_p[08]
#set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[09] }]; #IO_L23N_T3_18 Sch=fmc_hb_n[09]
#set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[09] }]; #IO_L23P_T3_18 Sch=fmc_hb_p[09]
#set_property -dict { PACKAGE_PIN J12   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[10] }]; #IO_L8N_T1_18 Sch=fmc_hb_n[10]
#set_property -dict { PACKAGE_PIN J11   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[10] }]; #IO_L8P_T1_18 Sch=fmc_hb_p[10]
#set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[11] }]; #IO_L18N_T2_18 Sch=fmc_hb_n[11]
#set_property -dict { PACKAGE_PIN D11   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[11] }]; #IO_L18P_T2_18 Sch=fmc_hb_p[11]
#set_property -dict { PACKAGE_PIN A12   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[12] }]; #IO_L17N_T2_18 Sch=fmc_hb_n[12]
#set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[12] }]; #IO_L17P_T2_18 Sch=fmc_hb_p[12]
#set_property -dict { PACKAGE_PIN B12   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[13] }]; #IO_L15N_T2_DQS_18 Sch=fmc_hb_n[13]
#set_property -dict { PACKAGE_PIN C12   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[13] }]; #IO_L15P_T2_DQS_18 Sch=fmc_hb_p[13]
#set_property -dict { PACKAGE_PIN H12   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[14] }]; #IO_L10N_T1_18 Sch=fmc_hb_n[14]
#set_property -dict { PACKAGE_PIN H11   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[14] }]; #IO_L10P_T1_18 Sch=fmc_hb_p[14]
#set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[15] }]; #IO_L3N_T0_DQS_18 Sch=fmc_hb_n[15]
#set_property -dict { PACKAGE_PIN L12   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[15] }]; #IO_L3P_T0_DQS_18 Sch=fmc_hb_p[15]
#set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[16] }]; #IO_L4N_T0_18 Sch=fmc_hb_n[16]
#set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[16] }]; #IO_L4P_T0_18 Sch=fmc_hb_p[16]
#set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[17] }]; #IO_L13N_T2_MRCC_18 Sch=fmc_hb_n[17]
#set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[17] }]; #IO_L13P_T2_MRCC_18 Sch=fmc_hb_p[17]
#set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[18] }]; #IO_L20N_T3_18 Sch=fmc_hb_n[18]
#set_property -dict { PACKAGE_PIN E14   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[18] }]; #IO_L20P_T3_18 Sch=fmc_hb_p[18]
#set_property -dict { PACKAGE_PIN E11   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[19] }]; #IO_L16N_T2_18 Sch=fmc_hb_n[19]
#set_property -dict { PACKAGE_PIN F11   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[19] }]; #IO_L16P_T2_18 Sch=fmc_hb_p[19]
#set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[20] }]; #IO_L24N_T3_18 Sch=fmc_hb_n[20]
#set_property -dict { PACKAGE_PIN B14   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[20] }]; #IO_L24P_T3_18 Sch=fmc_hb_p[20]
#set_property -dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_N[21] }]; #IO_L21N_T3_DQS_18 Sch=fmc_hb_n[21]
#set_property -dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS12 } [get_ports { FMC_HB_P[21] }]; #IO_L21P_T3_DQS_18 Sch=fmc_hb_p[21]
#set_property -dict { PACKAGE_PIN C27   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[00] }]; #IO_L13N_T2_MRCC_16 Sch=fmc_la_n[00]
#set_property -dict { PACKAGE_PIN D27   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[00] }]; #IO_L13P_T2_MRCC_16 Sch=fmc_la_p[00]
#set_property -dict { PACKAGE_PIN C26   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[01] }]; #IO_L11N_T1_SRCC_16 Sch=fmc_la_n[01]
#set_property -dict { PACKAGE_PIN D26   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[01] }]; #IO_L11P_T1_SRCC_16 Sch=fmc_la_p[01]
#set_property -dict { PACKAGE_PIN G30   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[02] }]; #IO_L24N_T3_16 Sch=fmc_la_n[02]
#set_property -dict { PACKAGE_PIN H30   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[02] }]; #IO_L24P_T3_16 Sch=fmc_la_p[02]
#set_property -dict { PACKAGE_PIN E30   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[03] }]; #IO_L18N_T2_16 Sch=fmc_la_n[03]
#set_property -dict { PACKAGE_PIN E29   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[03] }]; #IO_L18P_T2_16 Sch=fmc_la_p[03]
#set_property -dict { PACKAGE_PIN H27   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[04] }]; #IO_L23N_T3_16 Sch=fmc_la_n[04]
#set_property -dict { PACKAGE_PIN H26   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[04] }]; #IO_L23P_T3_16 Sch=fmc_la_p[04]
#set_property -dict { PACKAGE_PIN A30   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[05] }]; #IO_L17N_T2_16 Sch=fmc_la_n[05]
#set_property -dict { PACKAGE_PIN B30   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[05] }]; #IO_L17P_T2_16 Sch=fmc_la_p[05]
#set_property -dict { PACKAGE_PIN C30   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[06] }]; #IO_L16N_T2_16 Sch=fmc_la_n[06]
#set_property -dict { PACKAGE_PIN D29   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[06] }]; #IO_L16P_T2_16 Sch=fmc_la_p[06]
#set_property -dict { PACKAGE_PIN E25   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[07] }]; #IO_L3N_T0_DQS_16 Sch=fmc_la_n[07]
#set_property -dict { PACKAGE_PIN F25   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[07] }]; #IO_L3P_T0_DQS_16 Sch=fmc_la_p[07]
#set_property -dict { PACKAGE_PIN B29   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[08] }]; #IO_L15N_T2_DQS_16 Sch=fmc_la_n[08]
#set_property -dict { PACKAGE_PIN C29   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[08] }]; #IO_L15P_T2_DQS_16 Sch=fmc_la_p[08]
#set_property -dict { PACKAGE_PIN A28   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[09] }]; #IO_L9N_T1_DQS_16 Sch=fmc_la_n[09]
#set_property -dict { PACKAGE_PIN B28   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[09] }]; #IO_L9P_T1_DQS_16 Sch=fmc_la_p[09]
#set_property -dict { PACKAGE_PIN A27   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[10] }]; #IO_L7N_T1_16 Sch=fmc_la_n[10]
#set_property -dict { PACKAGE_PIN B27   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[10] }]; #IO_L7P_T1_16 Sch=fmc_la_p[10]
#set_property -dict { PACKAGE_PIN A26   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[11] }]; #IO_L10N_T1_16 Sch=fmc_la_n[11]
#set_property -dict { PACKAGE_PIN A25   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[11] }]; #IO_L10P_T1_16 Sch=fmc_la_p[11]
#set_property -dict { PACKAGE_PIN E26   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[12] }]; #IO_L5N_T0_16 Sch=fmc_la_n[12]
#set_property -dict { PACKAGE_PIN F26   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[12] }]; #IO_L5P_T0_16 Sch=fmc_la_p[12]
#set_property -dict { PACKAGE_PIN D24   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[13] }]; #IO_L4N_T0_16 Sch=fmc_la_n[13]
#set_property -dict { PACKAGE_PIN E24   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[13] }]; #IO_L4P_T0_16 Sch=fmc_la_p[13]
#set_property -dict { PACKAGE_PIN B24   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[14] }]; #IO_L8N_T1_16 Sch=fmc_la_n[14]
#set_property -dict { PACKAGE_PIN C24   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[14] }]; #IO_L8P_T1_16 Sch=fmc_la_p[14]
#set_property -dict { PACKAGE_PIN A23   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[15] }]; #IO_L1N_T0_16 Sch=fmc_la_n[15]
#set_property -dict { PACKAGE_PIN B23   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[15] }]; #IO_L1P_T0_16 Sch=fmc_la_p[15]
#set_property -dict { PACKAGE_PIN D23   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[16] }]; #IO_L2N_T0_16 Sch=fmc_la_n[16]
#set_property -dict { PACKAGE_PIN E23   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[16] }]; #IO_L2P_T0_16 Sch=fmc_la_p[16]
#set_property -dict { PACKAGE_PIN E21   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[17] }]; #IO_L11N_T1_SRCC_17 Sch=fmc_la_n[17]
#set_property -dict { PACKAGE_PIN F21   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[17] }]; #IO_L11P_T1_SRCC_17 Sch=fmc_la_p[17]
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[18] }]; #IO_L13N_T2_MRCC_17 Sch=fmc_la_n[18]
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[18] }]; #IO_L13P_T2_MRCC_17 Sch=fmc_la_p[18]
#set_property -dict { PACKAGE_PIN H22   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[19] }]; #IO_L7N_T1_17 Sch=fmc_la_n[19]
#set_property -dict { PACKAGE_PIN H21   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[19] }]; #IO_L7P_T1_17 Sch=fmc_la_p[19]
#set_property -dict { PACKAGE_PIN F22   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[20] }]; #IO_L9N_T1_DQS_17 Sch=fmc_la_n[20]
#set_property -dict { PACKAGE_PIN G22   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[20] }]; #IO_L9P_T1_DQS_17 Sch=fmc_la_p[20]
#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[21] }]; #IO_L5N_T0_17 Sch=fmc_la_n[21]
#set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[21] }]; #IO_L5P_T0_17 Sch=fmc_la_p[21]
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[22] }]; #IO_L3N_T0_DQS_17 Sch=fmc_la_n[22]
#set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[22] }]; #IO_L3P_T0_DQS_17 Sch=fmc_la_p[22]
#set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[23] }]; #IO_L18N_T2_17 Sch=fmc_la_n[23]
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[23] }]; #IO_L18P_T2_17 Sch=fmc_la_p[23]
#set_property -dict { PACKAGE_PIN G20   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[24] }]; #IO_L2N_T0_17 Sch=fmc_la_n[24]
#set_property -dict { PACKAGE_PIN H20   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[24] }]; #IO_L2P_T0_17 Sch=fmc_la_p[24]
#set_property -dict { PACKAGE_PIN C22   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[25] }]; #IO_L10N_T1_17 Sch=fmc_la_n[25]
#set_property -dict { PACKAGE_PIN D22   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[25] }]; #IO_L10P_T1_17 Sch=fmc_la_p[25]
#set_property -dict { PACKAGE_PIN A22   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[26] }]; #IO_L23N_T3_17 Sch=fmc_la_n[26]
#set_property -dict { PACKAGE_PIN B22   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[26] }]; #IO_L23P_T3_17 Sch=fmc_la_p[26]
#set_property -dict { PACKAGE_PIN A21   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[27] }]; #IO_L21N_T3_DQS_17 Sch=fmc_la_n[27]
#set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[27] }]; #IO_L21P_T3_DQS_17 Sch=fmc_la_p[27]
#set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[28] }]; #IO_L4N_T0_17 Sch=fmc_la_n[28]
#set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[28] }]; #IO_L4P_T0_17 Sch=fmc_la_p[28]
#set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[29] }]; #IO_L22N_T3_17 Sch=fmc_la_n[29]
#set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[29] }]; #IO_L22P_T3_17 Sch=fmc_la_p[29]
#set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[30] }]; #IO_L20N_T3_17 Sch=fmc_la_n[30]
#set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[30] }]; #IO_L20P_T3_17 Sch=fmc_la_p[30]
#set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[31] }]; #IO_L17N_T2_17 Sch=fmc_la_n[31]
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[31] }]; #IO_L17P_T2_17 Sch=fmc_la_p[31]
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[32] }]; #IO_L1N_T0_17 Sch=fmc_la_n[32]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[32] }]; #IO_L1P_T0_17 Sch=fmc_la_p[32]
#set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_n[33] }]; #IO_L15N_T2_DQS_17 Sch=fmc_la_n[33]
#set_property -dict { PACKAGE_PIN D16   IOSTANDARD LVCMOS12 } [get_ports { fmc_la_p[33] }]; #IO_L15P_T2_DQS_17 Sch=fmc_la_p[33]
#set_property -dict { PACKAGE_PIN AC24  IOSTANDARD LVCMOS33 } [get_ports { FMC_SCL }]; #IO_L9P_T1_DQS_12 Sch=fmc_scl
#set_property -dict { PACKAGE_PIN AD24  IOSTANDARD LVCMOS33 } [get_ports { FMC_SDA }]; #IO_L9N_T1_DQS_12 Sch=fmc_sda

## Fan Control
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { FAN_PWM }]; #IO_25_14 Sch=fan_pwm
#set_property -dict { PACKAGE_PIN V21   IOSTANDARD LVCMOS33 } [get_ports { FAN_TACH }]; #IO_L22P_T3_A05_D21_14 Sch=fan_tach

## DPTI
## Note: DPTI and DSPI constraints cannot be used in the same design, as they share pins.
#set_property -dict { PACKAGE_PIN AB27  IOSTANDARD LVCMOS33 } [get_ports { PROG_CLKO }]; #IO_L12P_T1_MRCC_13 Sch=prog_clko
#set_property -dict { PACKAGE_PIN AD27  IOSTANDARD LVCMOS33 } [get_ports { PROG_D[0] }]; #IO_L11P_T1_SRCC_13 Sch=prog_d0/sck
#set_property -dict { PACKAGE_PIN W27   IOSTANDARD LVCMOS33 } [get_ports { PROG_D[1] }]; #IO_L2P_T0_13 Sch=prog_d1/mosi
#set_property -dict { PACKAGE_PIN W28   IOSTANDARD LVCMOS33 } [get_ports { PROG_D[2] }]; #IO_L2N_T0_13 Sch=prog_d2/miso
#set_property -dict { PACKAGE_PIN W29   IOSTANDARD LVCMOS33 } [get_ports { PROG_D[3] }]; #IO_L4P_T0_13 Sch=prog_d3/ss
#set_property -dict { PACKAGE_PIN Y29   IOSTANDARD LVCMOS33 } [get_ports { PROG_D[4] }]; #IO_L4N_T0_13 Sch=prog_d[4]
#set_property -dict { PACKAGE_PIN Y28   IOSTANDARD LVCMOS33 } [get_ports { PROG_D[5] }]; #IO_L3P_T0_DQS_13 Sch=prog_d[5]
#set_property -dict { PACKAGE_PIN AA28  IOSTANDARD LVCMOS33 } [get_ports { PROG_D[6] }]; #IO_L3N_T0_DQS_13 Sch=prog_d[6]
#set_property -dict { PACKAGE_PIN AA26  IOSTANDARD LVCMOS33 } [get_ports { PROG_D[7] }]; #IO_L1N_T0_13 Sch=prog_d[7]
#set_property -dict { PACKAGE_PIN AC30  IOSTANDARD LVCMOS33 } [get_ports { PROG_OEN }]; #IO_L7N_T1_13 Sch=prog_oen
#set_property -dict { PACKAGE_PIN AB25  IOSTANDARD LVCMOS33 } [get_ports { PROG_RDN }]; #IO_L6N_T0_VREF_13 Sch=prog_rdn
#set_property -dict { PACKAGE_PIN AB29  IOSTANDARD LVCMOS33 } [get_ports { PROG_RXFN }]; #IO_L10P_T1_13 Sch=prog_rxfn
#set_property -dict { PACKAGE_PIN AB28  IOSTANDARD LVCMOS33 } [get_ports { PROG_SIWUN }]; #IO_L5N_T0_13 Sch=prog_siwun
#set_property -dict { PACKAGE_PIN AD29  IOSTANDARD LVCMOS33 } [get_ports { PROG_SPIEN }]; #IO_L9P_T1_DQS_13 Sch=prog_spien
#set_property -dict { PACKAGE_PIN AA25  IOSTANDARD LVCMOS33 } [get_ports { PROG_TXEN }]; #IO_L6P_T0_13 Sch=prog_txen
#set_property -dict { PACKAGE_PIN AC27  IOSTANDARD LVCMOS33 } [get_ports { PROG_WRN }]; #IO_L12N_T1_MRCC_13 Sch=prog_wrn

## DSPI
## Note: DPTI and DSPI constraints cannot be used in the same design, as they share pins.
#set_property -dict { PACKAGE_PIN AD29  IOSTANDARD LVCMOS33 } [get_ports { PROG_SPIEN }]; #IO_L9P_T1_DQS_13 Sch=prog_spien
#set_property -dict { PACKAGE_PIN AD27  IOSTANDARD LVCMOS33 } [get_ports { PROG_SCK }]; #IO_L11P_T1_SRCC_13 Sch=prog_d0/sck
#set_property -dict { PACKAGE_PIN W27   IOSTANDARD LVCMOS33 } [get_ports { PROG_MOSI }]; #IO_L2P_T0_13 Sch=prog_d1/mosi
#set_property -dict { PACKAGE_PIN W28   IOSTANDARD LVCMOS33 } [get_ports { PROG_MISO }]; #IO_L2N_T0_13 Sch=prog_d2/miso
#set_property -dict { PACKAGE_PIN W29   IOSTANDARD LVCMOS33 } [get_ports { PROG_SS }]; #IO_L4P_T0_13 Sch=prog_d3/ss

## QSPI
#set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { QSPI_CSN }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_csn
#set_property -dict { PACKAGE_PIN P24   IOSTANDARD LVCMOS33 } [get_ports { QSPI_D[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_d[0]
#set_property -dict { PACKAGE_PIN R25   IOSTANDARD LVCMOS33 } [get_ports { QSPI_D[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_d[1]
#set_property -dict { PACKAGE_PIN R20   IOSTANDARD LVCMOS33 } [get_ports { QSPI_D[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_d[2]
#set_property -dict { PACKAGE_PIN R21   IOSTANDARD LVCMOS33 } [get_ports { QSPI_D[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_d[3]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { flash_csn }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_csn
set_property -dict { PACKAGE_PIN P24   IOSTANDARD LVCMOS33 } [get_ports { flash_mosi }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_d[0]
set_property -dict { PACKAGE_PIN R25   IOSTANDARD LVCMOS33 } [get_ports { flash_miso }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_d[1]
#set_property -dict { PACKAGE_PIN R20   IOSTANDARD LVCMOS33 } [get_ports { QSPI_D[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_d[2]
#set_property -dict { PACKAGE_PIN R21   IOSTANDARD LVCMOS33 } [get_ports { QSPI_D[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_d[3]


## IIC Bus
#set_property -dict { PACKAGE_PIN AE30  IOSTANDARD LVCMOS33 } [get_ports { SYS_SCL }]; #IO_L16P_T2_13 Sch=sys_scl
#set_property -dict { PACKAGE_PIN AF30  IOSTANDARD LVCMOS33 } [get_ports { SYS_SDA }]; #IO_L16N_T2_13 Sch=sys_sda

## Display Port IN
#set_property -dict { PACKAGE_PIN AC19  IOSTANDARD LVCMOS18 } [get_ports { RX_AUX_IN_CH_N }]; #IO_L17N_T2_32 Sch=rx_aux_ch_n
#set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS18 } [get_ports { RX_AUX_OUT_CH_N }]; #IO_L15N_T2_DQS_32 Sch=rx_aux_ch_n
#set_property -dict { PACKAGE_PIN AB19  IOSTANDARD LVCMOS18 } [get_ports { RX_AUX_IN_CH_P }]; #IO_L17P_T2_32 Sch=rx_aux_ch_p
#set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS18 } [get_ports { RX_AUX_OUT_CH_P }]; #IO_L15P_T2_DQS_32 Sch=rx_aux_ch_p
#set_property -dict { PACKAGE_PIN AE21  IOSTANDARD LVCMOS33 } [get_ports { RX_HPD }]; #IO_L10N_T1_12 Sch=rx_hpd

## Display Port OUT
#set_property -dict { PACKAGE_PIN AD16  IOSTANDARD LVCMOS18 } [get_ports { TX_AUX_IN_CH_N }]; #IO_L14N_T2_SRCC_32 Sch=tx_aux_ch_n
#set_property -dict { PACKAGE_PIN AB18  IOSTANDARD LVCMOS18 } [get_ports { TX_AUX_OUT_CH_N }]; #IO_L16N_T2_32 Sch=tx_aux_ch_n
#set_property -dict { PACKAGE_PIN AA18  IOSTANDARD LVCMOS18 } [get_ports { TX_AUX_OUT_CH_P }]; #IO_L16P_T2_32 Sch=tx_aux_ch_p
#set_property -dict { PACKAGE_PIN AD17  IOSTANDARD LVCMOS18 } [get_ports { TX_AUX_IN_CH_P }]; #IO_L14P_T2_SRCC_32 Sch=tx_aux_ch_p
#set_property -dict { PACKAGE_PIN AD21  IOSTANDARD LVCMOS33 } [get_ports { TX_HPD }]; #IO_L10P_T1_12 Sch=tx_hpd

## USB
#set_property -dict { PACKAGE_PIN AD18  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_CLK }]; #IO_L13P_T2_MRCC_32 Sch=usb_otg_clk
#set_property -dict { PACKAGE_PIN AE14  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_D[0] }]; #IO_L19N_T3_VREF_32 Sch=usb_otg_d[0]
#set_property -dict { PACKAGE_PIN AE15  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_D[1] }]; #IO_L19P_T3_32 Sch=usb_otg_d[1]
#set_property -dict { PACKAGE_PIN AC15  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_D[2] }]; #IO_L21N_T3_DQS_32 Sch=usb_otg_d[2]
#set_property -dict { PACKAGE_PIN AC16  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_D[3] }]; #IO_L21P_T3_DQS_32 Sch=usb_otg_d[3]
#set_property -dict { PACKAGE_PIN AB15  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_D[4] }]; #IO_L20N_T3_32 Sch=usb_otg_d[4]
#set_property -dict { PACKAGE_PIN AA15  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_D[5] }]; #IO_L20P_T3_32 Sch=usb_otg_d[5]
#set_property -dict { PACKAGE_PIN AD14  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_D[6] }]; #IO_L22N_T3_32 Sch=usb_otg_d[6]
#set_property -dict { PACKAGE_PIN AC14  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_D[7] }]; #IO_L22P_T3_32 Sch=usb_otg_d[7]
#set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_DIR }]; #IO_L24P_T3_32 Sch=usb_otg_dir
#set_property -dict { PACKAGE_PIN AA16  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_NXT }]; #IO_L23N_T3_32 Sch=usb_otg_nxt
#set_property -dict { PACKAGE_PIN AB14  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_RESETB }]; #IO_25_VRP_32 Sch=usb_otg_resetb
#set_property -dict { PACKAGE_PIN AA17  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_STP }]; #IO_L23P_T3_32 Sch=usb_otg_stp
#set_property -dict { PACKAGE_PIN AF16  IOSTANDARD LVCMOS18 } [get_ports { USB_OTG_VBUSOC }]; #IO_L6N_T0_VREF_32 Sch=usb_otg_vbusoc
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current design]
