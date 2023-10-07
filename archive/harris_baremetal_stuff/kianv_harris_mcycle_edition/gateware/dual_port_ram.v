`timescale 1 ns / 100 ps
`default_nettype none
module dual_port_ram #(
        parameter DATA_WIDTH = 8,
        parameter ADDR_WIDTH = 8
    )(
        input  wire    [DATA_WIDTH -1:0] wdata,
        input  wire    [ADDR_WIDTH -1:0] rd_addr,
        input  wire    [ADDR_WIDTH -1:0] wr_addr,
        input  wire                      we,
        input  wire                      rd_clk,
        input  wire                      wr_clk,
        output reg     [DATA_WIDTH -1:0] rdata
    );

    reg [DATA_WIDTH -1:0] mem [2**ADDR_WIDTH -1:0];

    always @(posedge wr_clk) begin
        if (we) begin
            mem[wr_addr] <= wdata;
        end
    end

    always @(posedge rd_clk) begin
        rdata <= mem[rd_addr];
    end

endmodule
