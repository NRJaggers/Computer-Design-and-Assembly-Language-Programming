`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 01/28/2021 09:43:27 PM
//////////////////////////////////////////////////////////////////////////////////


module ImmediateGenerator_Sim();

    logic [31:0] instruction;
    logic [31:0] Utype;
    logic [31:0] Itype;
    logic [31:0] Stype;
    logic [31:0] Jtype;
    logic [31:0] Btype;
    
    ImmediateGenerator Immed_Gen (.*);
    
    initial begin 
    //insert test cases
    
    instruction = 32'hFFFFFFFF;
    #10;
    instruction = 32'h00000000;
    #10;
    instruction = 32'h11111111;
    #10;
    instruction = 32'hAAAAAAAA;
    #10;
    
    end
    
endmodule
