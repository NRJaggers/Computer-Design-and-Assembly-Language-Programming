`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 01/21/2021 04:49:04 PM
//////////////////////////////////////////////////////////////////////////////////


module RegisterFile_Sim();
    
    //define signals
    logic        [4:0]  RF_ADR1;  //address to access first register
    logic        [4:0]  RF_ADR2;  //address to access second register
    logic        [4:0]  RF_WA;    //address to write data to 
    logic        [31:0] RF_WD;    //data to write to address in RF_WA
    logic               RF_EN;    //enable to allow for writing of data to address
    logic               RF_CLK;   //clock signal
    logic        [31:0] RF_RS1;   //output from saved data in register at address ADR1
    logic        [31:0] RF_RS2;   //output from saved data in register at address ADR2
    
    //link signals to module
    RegisterFile RF(.*);
    
    //set up test cases
    always
    begin
        RF_CLK = 0;
        #5;
        RF_CLK = 1;
        #5;
    end 
       
    initial
    begin

        //test values       
        RF_WA = 1; RF_WD = 32'hFFFFFFFF; RF_EN = 1;      //write data
        RF_ADR1 = 0; RF_ADR2 = 1;                       //read data
        #10;
        
        RF_WA = 0; RF_WD = 32'hCAB0DAB0; RF_EN = 1;      //write data
        #10; 
        
        RF_WA = 2; RF_WD = 32'hA00B00C0; RF_EN = 1;    //write data
        RF_ADR1 = 2;                                    //read data
        #10;
        
        RF_WA = 30; RF_WD = 32'h30303030; RF_EN = 0;     //write data
        RF_ADR1 = 30; RF_ADR2 = 31;                     //read data
        #10;
        
        RF_WA = 31; RF_WD = 32'h31313131; RF_EN = 1;     //write data
        RF_ADR2 = 31;                                   //read data
        #10;        

    end

endmodule
