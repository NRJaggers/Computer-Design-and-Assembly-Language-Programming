`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2021 06:55:29 PM
// Design Name: 
// Module Name: HW3
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


module HW3(
    input HW3_ADR1,
    input HW3_ADR2,
    input HW3_WA,
    input HW3_WD,
    input HW3_EN,
    input HW3_CLK,
    output HW3_RS1,
    output HW3_RS2
    );
    
    RegisterFile HW3_Reg_File (.RF_ADR1(HW3_ADR1),.RF_ADR2(HW3_ADR2),.RF_WA(HW3_WA),.RF_WD(HW3_WD),.RF_EN(HW3_EN),.RF_CLK(HW3_CLK),.RF_RS1(HW3_RS1),.RF_RS2(HW3_RS2));

endmodule
