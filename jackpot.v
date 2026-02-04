
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/26/2026 07:39:27 PM
// Design Name: 
// Module Name: jackpot
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Jackpot game for ECEN 449 Lab 1
//              LEDs cycle one at a time (one-hot).
//              If the matching switch is ON when its LED is lit,
//              all LEDs turn on (JACKPOT) for one slow tick, then
//              the sequence restarts.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module jackpot (
    input        CLOCK,        // 125 MHz system clock
    input  [3:0] SWITCHES,     // DIP switches 0-3
    output reg [3:0] LEDS      // LEDs 0-3
);

    // 25-bit divider for a clearly visible speed
    reg [24:0] div_counter = 0;

    // Index of the currently lit LED (0..3)
    reg [1:0] led_index = 0;

    // Jackpot flag: when 1, show all LEDs for one slow tick
    reg       jackpot_state = 0;

    // Clock divider: count up on every 125 MHz clock edge
    always @(posedge CLOCK) begin
        div_counter <= div_counter + 1;
    end

    // Use a high bit of div_counter as a slow clock.
    // Bit 24 is slower than 23; you can adjust if needed.
    wire slow_clk;
    assign slow_clk = div_counter[24];

    // Main game logic, driven by the slow clock
    always @(posedge slow_clk) begin
        if (jackpot_state) begin
            // JACKPOT: all LEDs on for one slow tick
            LEDS          <= 4'b1111;
            jackpot_state <= 1'b0;    // clear jackpot
            led_index     <= 2'b00;   // restart sequence at LED0
        end else begin
            // One-hot LED pattern based on led_index
            case (led_index)
                2'b00: LEDS <= 4'b0001;  // LED0
                2'b01: LEDS <= 4'b0010;  // LED1
                2'b10: LEDS <= 4'b0100;  // LED2
                2'b11: LEDS <= 4'b1000;  // LED3
            endcase

            // Win if matching switch is ON when its LED is lit
            if (SWITCHES[led_index]) begin
                jackpot_state <= 1'b1;   // enter jackpot on next tick
            end else begin
                // Otherwise advance to the next LED
                led_index <= led_index + 1'b1;
            end
        end
    end

endmodule

