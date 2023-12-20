`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 02/03/2021 03:31:01 PM 
//////////////////////////////////////////////////////////////////////////////////


module BranchConditionGenerator_Sim();

    logic [31:0] A;
    logic [31:0] B;
    logic equal;
    logic lessThan;
    logic lessThanUnsigned;

BranchConditionGenerator BCG_Sim(.*);

//test cases

initial begin
    
    A = 0; B = 0;
    #5;
    
    A = 233; B =133;
    #5;
    
    A = 32'hFFFFFFFF; B = 32'h7FFFFFFF;
    #5;   
    
    A = 2024; B = 4000 ;
    #5; 
    
    A = 32'h0B0D0B0; B = 32'h80000000;
    #5;

end

endmodule
