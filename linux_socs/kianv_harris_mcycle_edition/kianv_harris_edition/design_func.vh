function automatic [5:0] clz32;
  input [31:0] x;
  reg [31:0] y;
  reg [ 5:0] n;
  begin
    if (x == 32'b0) clz32 = 6'd32;
    else begin
      y = x;
      n = 6'd0;
      if (y[31:16] == 0) begin
        n = n + 16;
        y = y << 16;
      end
      if (y[31:24] == 0) begin
        n = n + 8;
        y = y << 8;
      end
      if (y[31:28] == 0) begin
        n = n + 4;
        y = y << 4;
      end
      if (y[31:30] == 0) begin
        n = n + 2;
        y = y << 2;
      end
      if (y[31] == 0) begin
        n = n + 1;
      end
      clz32 = n;
    end
  end
endfunction

function automatic [5:0] ctz32;
  input [31:0] x;
  reg [31:0] y;
  reg [ 5:0] n;
  begin
    if (x == 32'b0) ctz32 = 6'd32;
    else begin
      y = x;
      n = 6'd0;
      if (y[15:0] == 0) begin
        n = n + 16;
        y = y >> 16;
      end
      if (y[7:0] == 0) begin
        n = n + 8;
        y = y >> 8;
      end
      if (y[3:0] == 0) begin
        n = n + 4;
        y = y >> 4;
      end
      if (y[1:0] == 0) begin
        n = n + 2;
        y = y >> 2;
      end
      if (y[0] == 0) begin
        n = n + 1;
      end
      ctz32 = n;
    end
  end
endfunction
