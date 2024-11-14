`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2024 06:21:54 PM
// Design Name: 
// Module Name: vedic_8x8
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
`include "vedic_4x4.v"

module vedic_8x8(
    input [7:0] a,
    input [7:0] b,
    output [15:0] c
    );

    //output of 4 4x4 vedic multipliers
    wire [7:0] q0;
    wire [7:0] q1;
    wire [7:0] q2;
    wire [7:0] q3;

    // temp vars
    wire [7:0]  temp_q0;
    wire [7:0]  m8_bit_adder_1;
    wire [11:0] m8_bit_adder_1_to_12bit;
    wire [11:0] temp_q2;
    wire [11:0] temp_q3;
    wire [11:0] m12_bit_adder_1;
    wire [11:0] m12_bit_adder_2;

    // compute 4x4 multiplication in vedic manner
    
    vedic_4x4 dut1_4x4 (.a(a[3:0]) ,
                        .b(b[3:0]) ,
                        .c(q0) );

    vedic_4x4 dut2_4x4 (.a(a[7:4]) ,
                        .b(b[3:0]) ,
                        .c(q1) );
    
    vedic_4x4 dut3_4x4 (.a(a[3:0]) ,
                        .b(b[7:4]) ,
                        .c(q2) );
    
    vedic_4x4 dut4_4x4 (.a(a[7:4]) ,
                        .b(b[7:4]) ,
                        .c(q3) );

    // 8 bit adders & 10 bit adders in this stage 

    assign temp_q0 = {4'b0, q0[7:4]};
    assign m8_bit_adder_1 = q1 + temp_q0;

    assign m8_bit_adder_1_to_12bit = {4'b0 , m8_bit_adder_1}; // used in 2nd stage of adders

    assign temp_q2 = {4'b0 , q2};
    assign temp_q3 = {q3, 4'b0};
    assign m12_bit_adder_1 = temp_q2 + temp_q3;
    
    // 2nd stage of adders
    assign m12_bit_adder_2 = m12_bit_adder_1 + m8_bit_adder_1_to_12bit;


    //final assignment of output
    assign c = {m12_bit_adder_2, q0[3:0]};

endmodule
