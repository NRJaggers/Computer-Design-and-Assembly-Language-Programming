`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 02/03/2021 02:31:51 PM 
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module BranchConditionGenerator(
    input [31:0] BCG_A,
    input [31:0] BCG_B,
    output logic BCG_equal,
    output logic BCG_lessThan,
    output logic BCG_lessThanUnsigned
    );
    
    assign BCG_equal            = BCG_A == BCG_B ? 1:0 ;
    assign BCG_lessThan         = $signed (BCG_A) < $signed (BCG_B) ? 1:0 ; 
    assign BCG_lessThanUnsigned = BCG_A < BCG_B ? 1:0 ;  

endmodule
