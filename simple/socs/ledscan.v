/*
*  
  *  Copyright(C) 2018 Gerald Coe, Devantech Ltd <gerry@devantech.co.uk>
  * 
  *  Permission to use, copy, modify, and/or distribute this software for any purpose with or
  *  without fee is hereby granted, provided that the above copyright notice and 
  *  this permission notice appear in all copies.
    * 
    *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO
    *  THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. 
      *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL 
      *  DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN
      *  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN 
      *  CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
        * 
        */

// LedScan takes the four led columns as inputs and outputs them to the led matrix

module LedScan (
           input clk,
           input [7:0] leds1,
           input [7:0] leds2,
           input [7:0] leds3,
           input [7:0] leds4,
           output reg [7:0] leds,
           output reg [3:0] lcol
       );


/* Counter register */
reg [17:0] timer = 12'b0;


always @ (posedge clk) begin
    case (timer[17:16])
        2'b00: begin
            leds[7:0] <= leds1[7:0];
            lcol[3:0] <= 4'b1110;
        end
        2'b01: begin
            leds[7:0] <= leds2[7:0];
            lcol[3:0] <= 4'b1101;
        end
        2'b10: begin
            leds[7:0] <= leds3[7:0];
            lcol[3:0] <= 4'b1011;
        end
        2'b11: begin
            leds[7:0] <= leds4[7:0];
            lcol[3:0] <= 4'b0111;
        end
    endcase
end


// increment the scan timer
always @ (posedge clk) begin
    timer <= timer + 1;
end

endmodule
