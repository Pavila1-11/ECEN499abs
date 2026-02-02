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
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module jackpot(

 
 input  CLOCK,        // K17: 125MHz onboard  
    input  [3:0] SWITCHES,  // G15,P15,W13,T16: DIP 0-3
    output reg [3:0] LEDS    // M14,M15,G14,D18: LEDs 0-3
);

    reg [21:0] slow_count = 0;  // Clock divider
    reg [1:0] led_index = 0;    // Which LED (0,1,2,3)
    reg win_mode = 0;           // Jackpot flag

    always @(posedge CLOCK) begin
        slow_count <= slow_count + 1;
        
        // === CLOCK DIVIDER: 125MHz → ~5Hz (visible but fast) ===
        if (slow_count == 22'd25_000_000) begin
            slow_count <= 0;
            
            if (win_mode) begin
                // Auto-reset jackpot after 1 cycle
                win_mode <= 0;
                led_index <= 0;
                LEDS <= 4'b0001;
            end else begin
                // === CYCLE LEDs (ONE-HOT) ===
                case (led_index)
                    2'b00: LEDS <= 4'b0001;  // LED0
                    2'b01: LEDS <= 4'b0010;  // LED1
                    2'b10: LEDS <= 4'b0100;  // LED2  
                    2'b11: LEDS <= 4'b1000;  // LED3
                endcase
                
                // === WIN CHECK: Switch matches current LED? ===
                if (SWITCHES[led_index]) begin
                    win_mode <= 1;
                    LEDS <= 4'b1111;     // JACKPOT!
                end else begin
                    led_index <= led_index + 1;  // Next LED
                end
            end
        end
    end

endmodule
