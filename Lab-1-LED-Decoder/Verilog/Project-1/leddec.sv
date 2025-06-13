/*
Name: Jose Maritnez-Ponce
Date: 6/12/2025
Assignment: Lab 1
Purpose: To display hex on the on-board seven-segment display
*/

`timescale 1ns / 1ps


module leddec
   (input [2:0] dig,            // 3-bit input
    input [3:0] data,           // 4-bit input
    output logic [7:0] anode,   // 8-bit output
    output logic [6:0] seg      // 7-bit output
   );    

   
    always @(data, dig)
    begin
    
    case(data)
        4'b0000 : seg <= 7'b0000001; // 0
        4'b0001 : seg <= 7'b1001111; // 1
        4'b0010 : seg <= 7'b0010010; // 2
        4'b0011 : seg <= 7'b0000110; // 3
        4'b0100 : seg <= 7'b1001100; // 4
        4'b0101 : seg <= 7'b0100100; // 5
        4'b0110 : seg <= 7'b0100000; // 6
        4'b0111 : seg <= 7'b0001111; // 7
        4'b1000 : seg <= 7'b0000000; // 8
        4'b1001 : seg <= 7'b0000100; // 9
        4'b1010 : seg <= 7'b0001000; // A
        4'b1011 : seg <= 7'b1100000; // B
        4'b1100 : seg <= 7'b0110001; // C
        4'b1101 : seg <= 7'b1000010; // D
        4'b1110 : seg <= 7'b0110000; // E
        4'b1111 : seg <= 7'b0111000; // F
        default : seg <= 7'b1111111;
    endcase 
    
    case(dig)
        3'b000 : anode <= 8'b11111110; // 0
        3'b001 : anode <= 8'b11111101; // 1
        3'b010 : anode <= 8'b11111011; // 2
        3'b011 : anode <= 8'b11110111; // 3
        3'b100 : anode <= 8'b11101111; // 4
        3'b101 : anode <= 8'b11011111; // 5
        3'b110 : anode <= 8'b10111111; // 6
        3'b111 : anode <= 8'b01111111; // 7
        default: anode <= 8'b11111111;
    endcase
        
    end
    
endmodule: leddec
