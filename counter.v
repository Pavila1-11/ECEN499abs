`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/26/2026 07:01:52 PM
// Design Name: 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter (
    input  CLOCK,      // 125MHz clock (K17)
    input  BTN0_UP,    // Count UP (M18)
    input  BTN1_DOWN,  // Count DOWN (P16)
    input  RESET,      // Reset (R18)
    output [3:0] LEDS  // 4-bit display
);

reg [3:0] count = 0;
reg [25:0] slow_clk = 0;  // Simple divider

always @(posedge CLOCK) begin
    slow_clk <= slow_clk + 1;  // Divide clock
end

always @(posedge slow_clk[24] or posedge RESET) begin  // ~1Hz toggle
    if (RESET)
        count <= 0;
    else if (BTN0_UP)
        count <= (count == 15) ? 0 : count + 1;  // UP
    else if (BTN1_DOWN)
        count <= (count == 0) ? 15 : count - 1;  // DOWN
end

assign LEDS = count;

endmodule
