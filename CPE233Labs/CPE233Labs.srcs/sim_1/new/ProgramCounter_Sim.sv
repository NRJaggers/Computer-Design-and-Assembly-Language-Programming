`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers

// Create Date: 01/15/2021 06:59:59 PM
//////////////////////////////////////////////////////////////////////////////////


module ProgramCounter_Sim();

    //define signals 
    logic PC_CLK;
    logic PC_WRITE;
    logic PC_RESET;
    logic [31:0] PC_DIN;
    logic [31:0] PC_COUNT;
    
    //link signals to module
    ProgramCounter PC(.*);
    
    //set up test cases
    always
    begin
        PC_CLK = 0;
        #5;
        PC_CLK = 1;
        #5;
        PC_DIN = PC_COUNT +4; 
           
    end
    
    initial
    begin
    
    PC_WRITE = 1; PC_RESET = 0; PC_DIN = 0;
    #10;
    
    PC_WRITE = 1;
    #20;
    
    PC_WRITE = 0; PC_RESET = 1;
    #10;
    
    PC_WRITE = 1;PC_RESET = 0;
    #20;
    
    PC_WRITE = 1;PC_RESET = 1;
    #20;
          
    end
endmodule
