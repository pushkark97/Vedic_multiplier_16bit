`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2024 03:25:47 PM
// Design Name: 
// Module Name: vedic_4x4
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
`include "vedic_2x2.v"

module vedic_4x4(
    input [3:0] a,
    input [3:0] b,
    output [7:0] c
    );
    
    //outputs of 4 vedic multipliers 
    wire [3:0] q0; 
    wire [3:0] q1;
    wire [3:0] q2;
    wire [3:0] q3;

    //temp var 
    wire [3:0] temp_q0;
    wire [5:0] temp_q2;
    wire [5:0] temp_q3;
    wire [3:0] m4_bit_adder_1;
    wire [5:0] m6_bit_adder_1;
    wire [5:0] m6_bit_adder_2;
    wire [5:0] m4_bit_adder_to_6bit;

    // compute 2x2 for the 4 bits in vedic manner
    
    vedic_2x2 i1 (.a(a[1:0]), .b(b[1:0]) , .c(q0) );
    vedic_2x2 i2 (.a(a[3:2]), .b(b[1:0]) , .c(q1) );
    vedic_2x2 i3 (.a(a[1:0]), .b(b[3:2]) , .c(q2) );
    vedic_2x2 i4 (.a(a[3:2]), .b(b[3:2]) , .c(q3) );

    // 4-bit & 6 bit adders in this stage

    assign temp_q0 = {2'b0 , q0[3:2]};
    assign m4_bit_adder_1 = q1 + temp_q0 ;

    assign m4_bit_adder_to_6bit = {2'b0 , m4_bit_adder_1};

    assign temp_q2 = {2'b0 , q2};
    assign temp_q3 = {q3,2'b0};
    assign m6_bit_adder_1 = temp_q2 + temp_q3 ;

    // 2nd stage of adders 
    
    assign m6_bit_adder_2 = m6_bit_adder_1 + m4_bit_adder_to_6bit;

    // final assign of output 

    assign c = {m6_bit_adder_2,q0[1:0]};


endmodule
