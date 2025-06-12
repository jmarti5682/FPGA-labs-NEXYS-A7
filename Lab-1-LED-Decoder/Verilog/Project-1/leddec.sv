/*
Name: Jose Maritnez-Ponce
Date: 6/12/2025
Assignment: Lab 1
Purpose: To display hex on the on-board seven-segment display
*/

`timescale 1ns / 1ps


module leddec(
    input [2:0] dig, 
    input [3:0] data, 
    output reg [7:0] anode, 
    output reg [6:0] seg);

   
    always @ (*) 
    begin
    
    case(data)
        'b0000 : seg <= 'b0000001; // 0
        'b0001 : seg <= 'b1001111; // 1
        'b0010 : seg <= 'b0010010; // 2
        'b0011 : seg <= 'b0000110; // 3
        'b0100 : seg <= 'b1001100; // 4
        'b0101 : seg <= 'b0100100; // 5
        'b0110 : seg <= 'b0100000; // 6
        'b0111 : seg <= 'b0001111; // 7
        'b1000 : seg <= 'b0000000; // 8
        'b1001 : seg <= 'b0000100; // 9
        'b1010 : seg <= 'b0001000; // A
        'b1011 : seg <= 'b1100000; // B
        'b1100 : seg <= 'b0110001; // C
        'b1101 : seg <= 'b1000010; // D
        'b1110 : seg <= 'b0110000; // E
        'b1111 : seg <= 'b0111000; // F
        default : seg <= 'b1111111;
    endcase 
    
    case(dig)
        'b000 : anode <= 'b11111110; // 0
        'b001 : anode <= 'b11111101; // 1
        'b010 : anode <= 'b11111011; // 2
        'b011 : anode <= 'b11110111; // 3
        'b100 : anode <= 'b11101111; // 4
        'b101 : anode <= 'b11011111; // 5
        'b110 : anode <= 'b10111111; // 6
        'b111 : anode <= 'b01111111; // 7
        default: anode <= 'b11111111;
    endcase
        
    end
    
endmodule
