module top(
    input clk_25mhz,
    output [7:0] led,
    output ftdi_rxd,
    input ftdi_txd,
    output wifi_gpio0
);

assign wifi_gpio0 = 1'b1;

wire clk;
pll pll(
    .clki(clk_25mhz),
    .clko(clk)
);
attosoc soc(
    .clk(clk),
    .led(led),
    .uart_tx(ftdi_rxd),
    .uart_rx(ftdi_txd)
);
endmodule
