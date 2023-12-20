`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 02/03/2021 02:31:51 PM 
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module BranchAddressGenerator(
    input  [31:0] BAG_PC,
    input  [31:0] BAG_Jtype,
    input  [31:0] BAG_Btype,
    input  [31:0] BAG_Itype,
    input  [31:0] BAG_register,
    output [31:0] BAG_jal,
    output [31:0] BAG_branch,
    output [31:0] BAG_jalr
    );
    
    assign BAG_jal    = BAG_PC + BAG_Jtype;
    assign BAG_branch = BAG_PC + BAG_Btype;
    assign BAG_jalr   = BAG_register + BAG_Itype;
     
endmodule
