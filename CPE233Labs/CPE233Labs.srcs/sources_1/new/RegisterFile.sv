`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Nathan Jaggers
// 
// Create Date: 01/20/2021 06:55:29 PM
// Description: 
//////////////////////////////////////////////////////////////////////////////////

//define behavior of file
module RegisterFile(
    input        [4:0]  RF_ADR1,  //address to access first register
    input        [4:0]  RF_ADR2,  //address to access second register
    input        [4:0]  RF_WA,    //address to write data to 
    input        [31:0] RF_WD,    //data to write to address in RF_WA
    input               RF_EN,    //enable to allow for writing of data to address
    input               RF_CLK,   //clock signal
    output logic [31:0] RF_RS1,   //output from saved data in register at address ADR1
    output logic [31:0] RF_RS2    //output from saved data in register at address ADR2
    );
    
    //define register table and initialize data to zero
    logic [31:0] ram [0:31] ;
    
    initial
    begin
        for(int i=0; i<32; i++)begin
        ram[i] = 0;
        end 
    end
    
    //read and output data continuously 
    always_comb
    begin
        RF_RS1 = ram[RF_ADR1];
        RF_RS2 = ram[RF_ADR2];
    end
    
    //save data synchronously 
    always_ff @(posedge RF_CLK)
    begin
        if(RF_EN) begin
            if(RF_WA != 0) begin   //write to all registers but register zero
            ram[RF_WA] <= RF_WD;            
            end
        end   
    end
    
endmodule
