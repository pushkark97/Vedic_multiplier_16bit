`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2024 12:22:33 PM
// Design Name: 
// Module Name: vedic_2x2
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

module vedic_2x2(
    
    input wire [1:0] a, 
    input wire [1:0] b,
    output wire [3:0] c

    );
    
    wire [2:0] vedic;
    wire [1:0] adder_of_cross;
    wire [1:0] adder_of_MSB_cross;

    assign c[0] = a[0] & b[0] ;
    assign vedic = {a[1] & b[1] , a[0] & b[1] , a[1] & b[0] };
    assign adder_of_cross = { vedic[0] & vedic[1] , vedic[0] ^ vedic[1] } ; // half adder implementation of the 2 cross multiplicands
    assign adder_of_MSB_cross = {vedic[2] & adder_of_cross[1] , vedic[2] ^ adder_of_cross[1]}; // HA of MSb of vedic and MSB of vedic1
    assign c [3:1] = {adder_of_MSB_cross, adder_of_cross[0]} ;

endmodule
