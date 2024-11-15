`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2024 10:49:48 AM
// Design Name: 
// Module Name: vedic_16x16
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


module vedic_16x16(
    input [15:0] a,
    input [15:0] b,
    output [31:0] c
    );

    // output of 4 8x8 multipliers
    wire [15:0] q0; 
    wire [15:0] q1; 
    wire [15:0] q2; 
    wire [15:0] q3; 

    // temp vars

    wire [15:0] temp_q0;
    wire [15:0] m16_bit_adder_1;
    wire [23:0] m16_bit_adder_1_to_24_bit;
    wire [23:0] temp_q2;
    wire [23:0] temp_q3;
    wire [23:0] m24_bit_adder_1;   
    wire [23:0] m24_bit_adder_2;   

    // compute 8x8 multiplication in vedic manner for 4 instances 
    
    vedic_8x8 dut1_8x8 (.a(a[7:0]),
                        .b(b[7:0]),
                        .c(q0) );
    
    vedic_8x8 dut2_8x8 (.a(a[15:8]),
                        .b(b[7:0]),
                        .c(q1) );

    vedic_8x8 dut3_8x8 (.a(a[7:0]),
                        .b(b[15:8]),
                        .c(q2) );

    vedic_8x8 dut4_8x8 (.a(a[15:8]),
                        .b(b[15:8]),
                        .c(q3) );

   // 1st stage of 16bit and 24 bit adders 
    assign temp_q0 = {8'b0,q0[15:8]};
    assign m16_bit_adder_1 = q1 + temp_q0 ;
    assign m16_bit_adder_1_to_24_bit = {8'b0, m16_bit_adder_1}; // used in 2nd stage of adders

    assign temp_q2 = {8'b0,q2};
    assign temp_q3 = {q3, 8'b0};
    assign m24_bit_adder_1 = temp_q2 + temp_q3;

    // 2nd stage of adders
    assign m24_bit_adder_2 = m24_bit_adder_1 + m16_bit_adder_1_to_24_bit;
    
    //Final assignment of 32 bit output
    assign c = {m24_bit_adder_2,q0[7:0]};

endmodule
