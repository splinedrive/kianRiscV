module pll (
    output c0,
    output locked,
    input  inclk0
);
  assign locked = 1'b1;
  assign c0 = inclk0;

endmodule
