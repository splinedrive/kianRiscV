module pll (
    input  inclk0,
    output c0,
    output locked
);
  assign locked = 1'b1;
  assign c0 = inclk0;

endmodule
